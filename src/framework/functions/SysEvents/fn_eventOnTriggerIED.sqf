/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2018-06-29
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_ied",objNull,[objNull]],["_size",0,[0]]];

if (_size <= 0) then { _side = ceil random 4; };

_ied setVariable ["MPSF_IED_BOOM",true,true];
_ied setVariable ["MPSF_IED",false,true];

private _boomtype = ["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","ammo_Missile_Cruise_01"] select (0 max _size min 4);

_boomtype createVehicle position _ied;
_ied setDamage 1;