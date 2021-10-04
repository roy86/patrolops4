/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]],["_attributes",[],[[]]]];

_attributes params [["_taskID","",[""]]];

if (isServer) then {
    private _taskLogic = missionNamespace getVariable [_taskID,objNull];
    if !(isNull _taskLogic) then {
        _taskLogic setVariable ["intelpickedUp",true];
        ["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
    };
};

if (hasInterface) then {
    if (side _target == side player) then {
        ["MPSF_onIntelPickup",[name _target]] call BIS_fnc_showNotification;
    };
};

true;