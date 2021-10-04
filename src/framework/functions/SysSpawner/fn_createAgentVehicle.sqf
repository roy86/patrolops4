/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createGroup.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Create a group of units at a position

	Parameter(s):
			1: <ARRAY> - Position [x,y]
			2: <STRING/SIDE> - Side or Faction name from cfgMission_Sides
			3: <STRING/ARRAY> - Array of Units or Group from cfgMission_Sides

	Returns:
		ARRAY: Units Spawned

	Example:
		[screenToWorld [0.5,0.5],West,["B_Soldier_TL_f","B_Soldier_AT_F","B_Soldier_GL_F"]] call MPSF_fnc_createGroup;
		[screenToWorld [0.5,0.5],"FactionTypeBLU","InfSquad"] call MPSF_fnc_createGroup;
*/
params [["_position",[0,0,0],[[]]],["_faction","",[""]],["_vehicleClass","",[""]],["_classNames",[],[[],""]]];

private _position = position selectRandom (_position nearRoads 50);
if (_position isEqualTo []) exitWith {[]};
private _vehicleData = [_position,_faction,_vehicleClass] call MPSF_fnc_createVehicle;
private _vehicle = _vehicleData param [0,objNull,[objNull]];
private _return = [_vehicle,[]];

if (count _classNames > 0) then {
	private _units = [_position,_faction,_classNames] call MPSF_fnc_createAgentGroup;
	if (count _units > 0) then {
		{
			if !(_x moveInAny _vehicle) then {deleteVehicle _x;};
		} forEach _units;
	};
	_return set [1,_units];
};

_return;