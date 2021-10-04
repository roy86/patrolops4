/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-01-04
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
if !(isserver) exitwith {};

params [
	["_vehicleClass","",[""]],
	["_targetPos",objNull,[objNull,[],""]],
	["_ordnance",0,[0]],
	["_ingressDir",0,[0]],
	["_supportTypes",[],[[]]],
	["_condition",{false},[{}]]
];

private _planeCfg = configfile >> "cfgvehicles" >> _vehicleClass;
if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_vehicleClass] call bis_fnc_error; false};

private _fnc_getLaserMarkers = {
	params ["_refPos"];

	private _lasedTargets = [];
	{
		private _laserTarget = laserTarget _x;
		if (_laserTarget distance2D _refPos < 150) exitWith {
			_lasedTargets pushBackUnique _laserTarget;
		};
	} forEach ((playableUnits + switchableUnits) select {side _x isEqualTo side player});

	_lasedTargets;
};

//--- Detect gun
private _weaponTypes = switch (_ordnance) do {
	case 0: {["bomblauncher"]};
	case 1: {["missilelauncher"]};
	case 2: {["bomblauncher","missilelauncher"]};
	case 3: {["machinegun"]};
	default {[]};
};

private _weapons = [];
{
	if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
		_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
		if (count _modes > 0) then {
			_mode = _modes select 0;
			if (_mode == "this") then {_mode = _x;};
			_weapons set [count _weapons,[_x,_mode]];
		};
	};
} foreach (_vehicleClass call bis_fnc_weaponsEntityType);

if (count _weapons == 0) exitwith { ["No weapon of types %2 wound on '%1'",_vehicleClass,_weaponTypes] call bis_fnc_error; false };

_ingressDir = _ingressDir - 180;

private _posATL = (_targetPos call BIS_fnc_position);
private _pos = +_posATL;
_pos set [2,(_pos select 2) + getterrainheightasl _pos];
private _dir = _ingressDir;

private _dis = 3000;
private _alt = 1000;
private _pitch = atan (_alt / _dis);
private _speed = 400 / 3.6;
private _duration = ([0,0] distance2D [_dis,_alt]) / _speed;

//--- Create plane
private _planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
_planePos set [2,(_pos select 2) + _alt];
private _planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
private _planeArray = [_planePos,_dir,_vehicleClass,_planeSide] call bis_fnc_spawnVehicle;
private _plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";

private _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setvectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorup _plane;

//--- Remove all other weapons;
private _currentWeapons = weapons _plane;
{
	if !(tolower ((_x call BIS_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
		_plane removeweapon _x;
	};
} foreach _currentWeapons;

//--- Cam shake
private _ehFired = _plane addeventhandler [
	"fired",
	{
		_this spawn {
			_plane = _this select 0;
			_plane removeeventhandler ["fired",_plane getvariable ["ehFired",-1]];
			_projectile = _this select 6;
			waituntil {isnull _projectile};
			[[0.005,4,[_plane getvariable ["logic",objnull],200]],"bis_fnc_shakeCuratorCamera"] call bis_fnc_mp;
		};
	}
];
_plane setvariable ["ehFired",_ehFired];

//--- Approach
_fire = [] spawn {waituntil {false}};
_fireNull = true;
_time = time;
_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};

waituntil {
	_fireProgress = _plane getvariable ["fireProgress",0];

	//--- Update plane position when module was moved / rotated
	if ((_targetPos distance _posATL > 0) && _fireProgress == 0) then {
		_posATL = _targetPos;
		_pos = +_posATL;
		_pos set [2,(_pos select 2) + getterrainheightasl _pos];
		_dir = _ingressDir;
		missionnamespace setvariable [_dirVar,_dir];

		_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
		_planePos set [2,(_pos select 2) + _alt];
		_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
		_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
		_plane setvectordir _vectorDir;
		//[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
		_vectorUp = vectorup _plane;

		_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
	};

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setvelocity velocity _plane;

	//--- Fire!
	if ((getposasl _plane) distance _pos < 1000 && _fireNull) then {


		//--- Create laser target
		private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
		_target = ((_targetPos nearEntities [_targetType,250])) param [0,objnull];
		_target = ([_targetPos] call _fnc_getLaserMarkers) param [0,objnull];
		if (isnull _target) then {
			_target = createvehicle [_targetType,_targetPos,[],0,"none"];
		};
		_plane reveal lasertarget _target;
		_plane dowatch lasertarget _target;
		_plane dotarget lasertarget _target;

		_fireNull = false;
		terminate _fire;
		_fire = [_plane,_weapons,_target,_ordnance] spawn {
			_plane = _this select 0;
			_planeDriver = driver _plane;
			_weapons = _this select 1;
			_target = _this select 2;
			_ordnance = _this select 3;
			_duration = 3;
			_time = time + _duration;
			waituntil {
				{
					//_plane selectweapon (_x select 0);
					//_planeDriver forceweaponfire _x;
					_planeDriver fireattarget [_target,(_x select 0)];
				} foreach _weapons;
				_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				time > _time || _ordnance == 4 || isnull _plane //--- Shoot only for specific period or only one bomb
			};
			sleep 1;
		};
	};

	sleep 0.01;
	scriptdone _fire || isnull _plane
};

_plane setvelocity velocity _plane;
_plane flyinheight _alt;

//--- Fire CM
if ({_x == "bomblauncher"} count _weaponTypes == 0) then {
	for "_i" from 0 to 1 do {
		driver _plane forceweaponfire ["CMFlareLauncher","Burst"];
		_time = time + 1.1;
		waituntil {time > _time || isnull _plane};
	};
};

_time = time + 30;
waituntil {time > _time || isNull _plane || !alive _plane};

//--- Delete plane
if (alive _plane) then {
	_group = group _plane;
	_crew = crew _plane;
	deletevehicle _plane;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;
};