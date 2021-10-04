params [["_centre",[0,0,0],[[],"",objNull]],["_side","",["",sideUnknown]],["_platforms",3,[0]],["_allowDamage",true,[false]]];

if !(isServer) exitWith {};

if !(_centre isEqualType []) then { _centre = _centre call BIS_fnc_position; };
if (_centre isEqualTo [0,0,0]) exitWith { [] };
if (_side isEqualTo "" || _side isEqualTo sideUnknown) exitWith { [] };

if (_side isEqualType "") then {
	_side = ["side",([_side] call MPSF_fnc_getCfgFactionID)] call MPSF_fnc_getCfgFaction;
};

private _samTypes = switch (_side) do {
	case east : { ["O_Radar_System_02_F","O_SAM_System_04_F","o_antiair","\a3\ui_f\data\Map\Markers\NATO\o_antiair.paa"]; };
	case west : { ["B_Radar_System_01_F","B_SAM_System_03_F","b_antiair","\a3\ui_f\data\Map\Markers\NATO\b_antiair.paa"] };
	case independent : { ["I_LT_01_AA_F","I_static_AA_F","n_antiair","\a3\ui_f\data\Map\Markers\NATO\n_antiair.paa"] };
	default {[]};
};
if (_samTypes isEqualTo []) exitWith {["Unable to create SAM site due to no types available."] call BIS_fnc_error; []};

private _samSite = [];

private _samRadar = createVehicle [(_samTypes select 0),_centre,[],0,"NONE"];
private _samRadarGroup = createVehicleCrew _samRadar;
["updateGroupIcon",[_samRadarGroup,_samTypes select 2]] call MPSF_fnc_itemAmrelTablet;
_samRadar setVehicleReportOwnPosition true;
_samRadar setVehicleReportRemoteTargets true;
_samRadar setVehicleRadar 1;
_samRadar setFuel 0;
_samRadar allowDamage _allowDamage;
[_samRadar, true, true, true] call BIS_fnc_initVehicle;
_samSite pushBack _samRadar;

private _groupID = (groupID _samRadarGroup) splitString " ";
_groupID set [0,"AA"];
_samRadarGroup setGroupIdGlobal [_groupID joinString " "];
_samRadarGroup setVariable ["natoIconPath",_samTypes select 3];

_samSite pushBack (createVehicle ["Land_TTowerSmall_2_F",_centre getPos [2,130],[],0,"NONE"]);

if (_platforms > 0) then {
	private _angle = random 360;
	for "_i" from 1 to _platforms do {
		private _samMissile = createVehicle [(_samTypes select 1),_centre getPos [25,(360/_platforms) * _i],[],0,"NONE"];
		_samMissile setDir ((360/_platforms) * _i);
		_samMissile setVehicleReceiveRemoteTargets true;
		_samMissile allowDamage _allowDamage;
		_samMissile setFuel 0;
		_samMissile addEventHandler ["Fired",{
			params ["_unit"];
			terminate (_unit getVariable ["MPSF_rearmSAM_script",scriptNull]);
			_unit setVariable ["MPSF_rearmSAM_script",_unit spawn {
				sleep 20;
				if (alive _this) then {
					_this setVehicleAmmoDef 1;
				};
				terminate (_this getVariable ["MPSF_rearmSAM_script",scriptNull]);
			}];
		}];
		(createVehicleCrew _samMissile) setVariable ["hideGroupIcon",true,true];
		[_samMissile, true, true, true] call BIS_fnc_initVehicle;
		_samSite pushBack _samMissile;
	};
};

_samSite