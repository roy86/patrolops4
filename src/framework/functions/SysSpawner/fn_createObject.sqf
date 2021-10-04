/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_createObject.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a preconfigured loadout from cfgMissionArmoury If the unit is local to the server/client running the code

	Parameter(s):
			1: <STRING> - Vehicle Class Name of Vehicle Type from cfgMission_Sides
			2: <ARRAY> - Position [x,y]
			3: <NUMBER> - Direction from 0-360 degrees

	Returns:
		[<VEHICLE>,<VEHICLE GROUP>,<ARRAY OF UNITS IN VEHICLE>]

	Example:
		[screenToWorld [0.5,0.5],"FactionTypeBLU","B_MRAP_01_F",random 360,true,["B_soldier_f","B_soldier_f"]] call MPSF_fnc_createVehicle;
*/
params [["_className","",[""]],["_position",[],[[]]],["_direction",random 360,[0]],["_force",false,[false]]];

if !(isClass(configFile >> "cfgVehicles" >> _className)) exitWith { objNull };

_position = _position call BIS_fnc_position;
if (count _position < 3) then {_position set [2,0]; };

private _object = createVehicle [_className,_position,[],0,if (_force) then {"CAN_COLLIDE"} else {"NONE"}];
_object setPosATL _position;
_object setDir _direction;
clearWeaponCargoGlobal _object;
clearItemCargoGlobal _object;
clearBackpackCargoGlobal _object;
clearMagazineCargoGlobal _object;

_object allowDamage true;
_object enableDynamicSimulation true;

[[_object]] call MPSF_fnc_addZeusObjects;

_object