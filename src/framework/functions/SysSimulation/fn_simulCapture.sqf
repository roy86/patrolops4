/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-22
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "setSurrender" : {
		_params params [["_target",objNull,[objNull]],["_allowJoin",false,[false]]];
		_target setCaptive true;
		_target action ["Surrender",_target];
		_target disableAi "MOVE";
		_target setVariable ["CaptureState",'Surrended',true];
		[_target] joinSilent grpNull;
		_target setVariable ["allowJoin",_allowJoin];
	};
	case "setDetained" : {
		_params params [["_target",objNull,[objNull]]];
		_target setCaptive true;
		_target disableAi "MOVE";
		_target setVariable ["CaptureState",'Detained',true];
		[_target,"Acts_AidlPsitMstpSsurWnonDnon_loop"] call MPSF_fnc_animateUnit;
	};
	case "setMoved" : {
		_params params [["_target",objNull,[objNull]]];
		_target setCaptive true;
		_target disableAi "MOVE";
		_target setVariable ["CaptureState",'Moving',true];
		[_target,"AmovPercMstpSsurWnonDnon"] call MPSF_fnc_animateUnit;
	};
	case "setJoined" : {
		_params params [["_target",objNull,[objNull]]];
		_target setCaptive true;
		_target enableAI "MOVE";
		_target setVariable ["CaptureState",'Joined',true];
		[_target,"Acts_AidlPsitMstpSsurWnonDnon_out"] call MPSF_fnc_animateUnit;
	};
	case "setVehicle" : {
		_params params [["_target",objNull,[objNull]],["_vehicle",objNull,[objNull]]];
		if (isNull _target || isNull _vehicle) exitWith {};
		detach _target;
		_target assignAsCargo _vehicle;
		_target moveInCargo _vehicle;
		_target setVariable ["CaptureState",'Detained',true];
		_target;

		[format["MPSF_Capture_%1_unLoad",_vehicle call BIS_fnc_netID],_vehicle,"Unload Target",{
			params ["_target", "_caller", "_actionId", "_arguments"];
			{
				if !((_x getVariable ["CaptureState",'']) isEqualTo '') then {
					_x action ["getOut",_target];
					_x action ["Eject",_target];
					_x setVariable ["CaptureState",'Detained',true];
				};
			} forEach crew _target;
			[format["MPSF_Capture_%1_unLoad",_target call BIS_fnc_netID],_target] call MPSF_fnc_removeAction;
		},[],
			"alive _target && _this distance _target < 6 "
				+ " && count ((crew _target) select {!((_x getVariable ['CaptureState','']) isEqualTo '')}) > 0"
				+ " && !(isNull ([vehicles,_target,6] call MPSF_fnc_getNearestObject))"
			,0,false
		] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
	};
	case "initCapture" : {
		_params params [["_target",objNull,[objNull]],["_state","",[""]]];

		[format["MPSF_Capture_%1_Detain",_target call BIS_fnc_netID],_target,"Detain Target",[ // TODO: Localise
				["framework\data\holdactions\holdAction_take_ca.paa",{}],
				["framework\data\holdactions\holdAction_take_ca.paa",{}],
				{ _target setVariable ["CaptureState",'Detained',true] },
				{},1,false
			],[],
			"alive _target && _this distance _target < 3 "
				+ "&& (_target getVariable ['CaptureState','']) == 'Surrended'"
			,0,false
		] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};

		if (side _target isEqualTo civilian) then {
			[format["MPSF_Capture_%1_Recover",_target call BIS_fnc_netID],_target,"Recover Target",[ // TODO: Localise
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					{
						[_target] joinAsSilent group player;
						_target setVariable ["CaptureState",'Recovered',true];
					},
					{},1,false
				],[],
				"alive _target && _this distance _target < 3 "
					+ "&& (_target getVariable ['CaptureState','']) == 'Detained'"
				,0,false
			] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};

			[format["MPSF_Capture_%1_Detain3",_target call BIS_fnc_netID],_target,"Detain Target",[ // TODO: Localise
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					{ [_target] joinSilent grpNull; },
					{},1,false
				],[],
				"alive _target && _this distance _target < 3 "
					+ "&& (_target getVariable ['CaptureState','']) == 'Recovered'"
				,0,false
			] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
		} else {
			[format["MPSF_Capture_%1_Move",_target call BIS_fnc_netID],_target,"Move Target",[ // TODO: Localise
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					{
						_target setVariable ["movingPlayer",player,true];
						player setVariable ["movingPlayer",_target,true];
						_target setVariable ["CaptureState",'Moving',true];
						_target setVariable["attachedTo",player,true];
						_target attachTo [player,[0.1,1.5,0]];
					},
					{},1,false
				],[],
				"alive _target && _this distance _target < 3 "
					+ " && (_target getVariable ['CaptureState','']) == 'Detained'"
				,0,false
			] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};

			[format["MPSF_Capture_%1_Load",_target call BIS_fnc_netID],_target,"Load Target",{
				params ["_target", "_caller", "_actionId", "_arguments"];
				['setVehicle',[_target,[vehicles,_target,6] call MPSF_fnc_getNearestObject]] call MPSF_fnc_simulCapture;
			},[],
				"alive _target && _this distance _target < 3 "
					+ " && (_target getVariable ['CaptureState','']) == 'Detained'"
					+ " && !(isNull ([vehicles select {_x isKindOf 'AllVehicles'},_target,6] call MPSF_fnc_getNearestObject))"
				,0,false
			] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};

			[format["MPSF_Capture_%1_Detain2",_target call BIS_fnc_netID],player,"Detain Target",[ // TODO: Localise
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					["framework\data\holdactions\holdAction_take_ca.paa",{}],
					{ (_target getVariable ["movingPlayer",objNull]) setVariable ["CaptureState",'Detained',true]; },
					{},1,false
				],[],
				"alive _target"
					//+ " && (_target getVariable ['CaptureState','']) == 'Moving'"
					+ " && count (attachedObjects _target) > 0"
				,0,false
			] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
		};

		if (local _target) then {
			[_target] spawn MPSF_fnc_capture;
		};
	};
};
