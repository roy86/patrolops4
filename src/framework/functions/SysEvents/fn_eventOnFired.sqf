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
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if (_ammo find "SmokeShell" >= 0) then {
    _this spawn {
        params ["_target","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];
        waituntil {vectorMagnitude velocity _projectile < 0.1};
        ["onSmokeThrown",[_target,_ammo,getPosVisual _projectile],0] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);
    };
};