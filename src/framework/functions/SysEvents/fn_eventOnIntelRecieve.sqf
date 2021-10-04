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
params [["_object",objNull,[objNull]],["_target",objNull,[objNull]],["_attributes",[],[[]]]];

if (isServer) then {
    _attributes params [["_taskID","",[""]]];

    private _taskLogic = missionNamespace getVariable [_taskID,objNull];
    if !(isNull _taskLogic) then {
        _taskLogic setVariable ["intelRecieved",true];
        ["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
    };
};

if (hasInterface) then {
    if (side _target == side player) then {
        ["MPSF_onIntelRecieve",[name _target,name _object]] call BIS_fnc_showNotification;
    };
};

true;