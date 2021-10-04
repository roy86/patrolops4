/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createParadrop.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Creats a paradrop of units
*/
params [
	["_insertPos",[0,0,0],[[],objNull]]
	,["_faction","FactionTypeOPF",[""]]
	,["_className","Transport_Air",[""]]
	,["_forceJump",false,[false]]
];

_insertPos = _insertPos call BIS_fnc_position;
private _ingressPos = _insertPos getPos [3000,random 360];
private _egressPos = _insertPos getPos [3000,_ingressPos getDir _insertPos];

private _flyInHeight = 200;
_ingressPos set [2,_flyInHeight];
private _direction = _ingressPos getDir _insertPos;

        [str _ingressPos,_ingressPos,nil,nil,nil,"ColorRED"] call MPSF_fnc_createMarker;
        [str _insertPos,_insertPos,nil,nil,nil,"ColorGreen"] call MPSF_fnc_createMarker;
        [str _egressPos,_egressPos,nil,nil,nil,"ColorBLUE"] call MPSF_fnc_createMarker;

// Check faction ID
if (_faction IN ["FactionTypeBLU","FactionTypeOPF","FactionTypeCIV"]) then {
	_faction = [_faction] call MPSF_fnc_getCfgFactionID;
};

// Check aircraft classname
if !(isClass(configFile >> "CfgVehicles" >> _className)) then {
	_className = ["vehicles",_faction,_className,true] call MPSF_fnc_getCfgFaction;
};
if (_className isKindof "Plane") then { _forceJump = true; };

private _aircraftData = [_ingressPos,_faction,_className,_direction,true,"QRFSquad"] call MPSF_fnc_createVehicle;
_aircraftData params [["_aircraft",objNull,[objNull]],["_crew",[],[[]]]];
_aircraft flyInHeight _flyInHeight;
_aircraftPilot = driver _aircraft;
(group _aircraftPilot) setBehaviour "SAFE";
(group _aircraftPilot) setSpeedMode "LIMITED";
(group _aircraftPilot) setCombatMode "YELLOW";
(group _aircraftPilot) setFormation (selectRandom ["ECH LEFT","ECH RIGHT"]);
_aircraftPilot setSkill 1;
_aircraftPilot disableAI "TARGET";
_aircraftPilot disableAI "AUTOTARGET";
_aircraftPilot doMove _insertPos;

		_aircraft setcaptive true;
		_aircraft disableai "target";
		_aircraft disableai "autotarget";
		//_aircraft setcombatmode "blue";
		driver _aircraft forceSpeed 80;

if !(_forceJump) then {
	_insertPos = [_insertPos,0,200,10,0,0.5,0] call BIS_fnc_findSafePos;

	private _landingZone = "HeliHEmpty" createVehicle _insertPos;
	_landingZone setPosATL _insertPos;
} else {

MPSF_JUMP = {
	private _aircraft = _this call BIS_fnc_objectFromNetID;
	private _jumpList = fullCrew _aircraft select {toLower(_x select 1) == 'cargo'};
	{
		_x params ['_unit','_role','_cargoIndex','_turretPath','_personTurret'];
		unassignVehicle _unit;
		moveOut _unit;
		if !(backpack _unit isEqualTo "") then {
			removeBackpack _unit;
		};
		_unit addBackpack 'B_parachute';
		sleep 0.25;
	} forEach _jumpList;
};

	_wp0 = (group _aircraftPilot) addWaypoint [_ingressPos,0];
	_wp0 setWaypointStatements ["hint str this; true",format ["(%1 call BIS_fnc_objectFromNetID) animatedoor ['Door_1_source',1];",str (_aircraft call BIS_fnc_netId)]];
	_wp1 = (group _aircraftPilot) addWaypoint [_insertPos,0];
	_wp1 setWaypointStatements ["true",format ["%1 spawn MPSF_JUMP",str (_aircraft call BIS_fnc_netId)]];
	_wp1 setWaypointCompletionRadius 500;
	_wp2 = (group _aircraftPilot) addWaypoint [_egressPos,0];
	_wp2 setWaypointStatements ["true",format ["['MPSF_%1_EH','onEachFrame'] call MPSF_fnc_removeEventhandler; _vehicle = %1 call BIS_fnc_objectFromNetID; {_vehicle deletevehiclecrew _x;} foreach crew _vehicle; deletevehicle _vehicle;",str (_aircraft call BIS_fnc_netId)]];
	_wp2 setWaypointCompletionRadius 500;
};

/*[format["MPSF_Paradrop_%1",_aircraft call BIS_fnc_netID],"onEachFrame",{
	if (diag_frameNo % 50 == 0) then {
		params ["_aircraft","_forceJump","_insertPos"];
		private _stage = _aircraft getVariable ["Paradrop_Stage","travel"];
		private _exit = false;
		switch (true) do {
			case (!alive _aircraft) : { _exit = true; };
			case (_forceJump && _aircraft distance2D _insertPos < 250 && !(_stage == "flyout")) : {
				_aircraft setVariable ["Paradrop_Stage","flyout"];
				_aircraft doMove (_insertPos getPos [5000,direction _aircraft]);
				private _jumpList = fullCrew _aircraft select {toLower(_x select 1) == "cargo"};
				[_jumpList,_insertPos] spawn {
					params ["_jumpList","_insertPos"];
					private _jumpGroup = grpNull;
					{
						_x params ["_unit","_role","_cargoIndex","_turretPath","_personTurret"];
						unassignVehicle _unit;
						moveOut _unit;
						if !(backpack _unit isEqualTo "") then {removeBackpack _unit;};
						_unit addBackpack "B_parachute";
						_jumpGroup = group _unit;
						sleep 1;
					} forEach _jumpList;
					[_jumpGroup,_insertPos,150] call MPSF_fnc_setGroupPatrol;
				};
			};
			case (!_forceJump && _aircraft distance2D _insertPos < 250 && !(_stage == "flyout")) : {
				_aircraft setVariable ["Paradrop_Stage","flyout"];
				_aircraft land "Land";
			};
			case (_stage == "flyout" && _aircraft distance2D _insertPos > 3000) : {
				{ deleteVehicle _x; } forEach (crew _aircraft + [_aircraft]);
				_exit = true;
			};
		};
		if (_exit) then {
			[format["MPSF_Paradrop_%1",_aircraft call BIS_fnc_netID],"onEachFrame"] call MPSF_fnc_removeEventHandler;
		};
	};
},[_aircraft,_forceJump,_insertPos]] call MPSF_fnc_addEventHandler;*/