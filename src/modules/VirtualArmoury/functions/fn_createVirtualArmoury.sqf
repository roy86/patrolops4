/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_logic",objNull,[objNull]],["_loadout","",[""]]];

if !(_logic isEqualType objNull) exitWith {false};
if !(isNull (_logic getVariable ["MPSF_VirtualArmoury_LoadoutPoint_Trigger",objNull])) exitWith {false};

if (isServer) then {
    _logic setVariable ["MPSF_VirtualArmoury_LoadoutPoint",true,true];
    if !(_loadout isEqualTo "") then {
        _logic setVariable ["MPSF_VirtualArmoury_LoadoutPoint_Loadout",_loadout,true];
    };
};

if (hasInterface) then {
    private _trigger = createTrigger ["EmptyDetector",_logic,false];
    _trigger setTriggerArea [4,4,getDir _logic,false];
    _trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
    _trigger setTriggerStatements ["(vehicle player) in thisList"
        ,format["['activateActionLoadoutPoint',[thisTrigger,thisList]] call MPSF_fnc_virtualArmoury;"]
        ,format["['deactivateActionLoadoutPoint',[thisTrigger]] call MPSF_fnc_virtualArmoury;"]
    ];
    _trigger attachTo [_logic,[0,0,0]];
    _logic setVariable ["MPSF_VirtualArmoury_LoadoutPoint_Trigger",_trigger];

    ["setRoleVirtualCargo",[player,_loadout]] call MPSF_fnc_virtualArmoury;
};

if (_logic isEqualType objNull) then {
    clearWeaponCargoGlobal _logic;
    clearItemCargoGlobal _logic;
    clearBackpackCargoGlobal _logic;
    clearMagazineCargoGlobal _logic;
};

[_logic,(_logic call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
[_logic,true,true] call BIS_fnc_removeVirtualWeaponCargo;

true;