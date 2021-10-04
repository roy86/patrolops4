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

missionNamespace setVariable [format["MPSF_onKeyPress_%1_State",_key],true];

/* Weapon Holstering */
if (hasInterface) then {
    if !(currentWeapon player isEqualTo "") exitWith {
        switch (true) do {
            case (inputAction "SwitchPrimary" == 1 && currentWeapon player isEqualTo primaryWeapon player);
            case (inputAction "SwitchHandgun" == 1 && currentWeapon player isEqualTo handgunWeapon player);
            case (inputAction "SwitchSecondary" == 1 && currentWeapon player isEqualTo secondaryWeapon player) : {
                if (isNull (missionNamespace getVariable ["MPSF_weaponHolset_script",scriptNull])) then {
                    missionNamespace setVariable ["MPSF_weaponHolset_script",[] spawn {
                        sleep 0.5;
                        player action ["SWITCHWEAPON",player,player,-1];
                    }];
                };
            };
        };
    };
};