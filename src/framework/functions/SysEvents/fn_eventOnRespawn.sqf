/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params ["_unit", "_corpse"];

waitUntil {!isNull player && alive player};

if (_unit isEqualTo player) then {
    ["init"] spawn MPSF_fnc_interaction;
    player setUnitLoadout (missionNamespace getVariable ["MPSF_Loadout",getUnitLoadout _unit]);
};