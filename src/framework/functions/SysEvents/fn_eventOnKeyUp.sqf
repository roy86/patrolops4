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
private _key = param [1,0,[0]];

missionNamespace setVariable [format["MPSF_onKeyPress_%1_State",_key],nil];

/* Weapon Holstering */
if (hasInterface) then {
    terminate (missionNamespace getVariable ["MPSF_weaponHolset_script",scriptNull]);
};