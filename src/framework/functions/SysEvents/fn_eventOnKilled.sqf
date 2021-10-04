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
params [["_target",objNull,[objNull]],["_killer",objNull,[objNull]], "_instigator", "_useEffects"];

missionNamespace setVariable ["MPSF_Loadout",getUnitLoadout _target];

if (_target isEqualTo player) then {
    private _loadout = getUnitLoadout _target;
    _loadout spawn {
        waitUntil {!isNull player && alive player};
        player setUnitLoadout _this;
        ["init"] spawn MPSF_fnc_interaction;
    };
};
