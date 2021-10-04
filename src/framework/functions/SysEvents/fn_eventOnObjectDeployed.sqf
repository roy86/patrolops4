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

params [["_object",objNull,[objNull]],["_previousObject","",[""]],["_caller",objNull,[objNull]],["_attributes",[],[[]]]];

_attributes params [["_taskID","",[""]]];

private _taskLogic = missionNamespace getVariable [_taskID,objNull];
if !(isNull _taskLogic) then {
	["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
};

true;