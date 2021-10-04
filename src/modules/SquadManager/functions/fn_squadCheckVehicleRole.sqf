/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-21
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]],["_vehicle",objNull,[objNull]]];

if (_target IN assignedCargo _vehicle) exitWith { true };

/* private _accessExempt = ["getCfgVehicleAccess"] call MPSF_fnc_virtualArmoury;
if ({ _vehicle isKindOf _x } count _accessExempt > 0) exitWith { true }; */

switch (true) do {
	case (_vehicle isKindOf "ParachuteBase") : { [_target,"HALO"] call MPSF_fnc_getUnitTrait; };
	case (_vehicle isKindOf "Helicopter") : { [_target,"pilotHeli"] call MPSF_fnc_getUnitTrait; };
	case (_vehicle isKindOf "Plane") : { [_target,"pilotPlane"] call MPSF_fnc_getUnitTrait; };
	case (_vehicle isKindOf "Tank") : { [_target,"crewman"] call MPSF_fnc_getUnitTrait; };
	default { true };
};