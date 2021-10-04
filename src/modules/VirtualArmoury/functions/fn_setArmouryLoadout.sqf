/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-12-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]],["_loadoutID","",[""]]];

if (isNull _target || _loadoutID isEqualTo "") exitWith {};

private _cfgLoadout = missionConfigFile >> "CfgVirtualArmoury" >> _loadoutID;
if !(isClass _cfgLoadout) exitWith {
	["CfgVirtualArmoury loadout not found: %1",_loadoutID] call BIS_fnc_error;
};

if (isClass (_cfgLoadout >> "Loadout")) then {
	_target setUnitLoadout (_cfgLoadout >> "Loadout");
};

true;