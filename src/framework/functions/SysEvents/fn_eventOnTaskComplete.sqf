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
params ["_taskID","_cfgTaskID","_parentID","_position","_positionOffset","_exitState"];

private _tasks = [[],true] call MPSF_fnc_getCfgTaskModules;
{
	if ((_x getVariable ["taskID",""]) isEqualTo _parentID) then {
		["onTaskValidate",[(_x getVariable ["taskID",""])],2] call MPSF_fnc_triggerEventHandler;
	};
} forEach _tasks;

true;