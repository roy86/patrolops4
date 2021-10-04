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
params [["_unit",objNull,[objNull]],["_attributes",[],[[]]]];

_attributes params [["_taskID","",[""]]];

private _taskLogic = missionNamespace getVariable [_taskID,objNull];
if !(isNull _taskLogic) then {
	_taskLogic setVariable ["targetskilled",({alive _x && canMove _x} count (_taskLogic getVariable ["targets",[]]) == 0)];
	_taskLogic setVariable ["unitskilled",({alive _x && canMove _x} count (_taskLogic getVariable ["units",[]]) == 0)];
	_taskLogic setVariable ["cachedestroyed",({damage _x == 0} count ((_taskLogic getVariable ["targets",[]]) select {typeOf _x IN (["WeaponCacheTypes"] call MPSF_fnc_getCfgTasks)}) == 0)];
	["onTaskValidate",[_taskID],2] call MPSF_fnc_triggerEventHandler;
};

true;