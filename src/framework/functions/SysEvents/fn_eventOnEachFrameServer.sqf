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
if !(isServer) exitWith {};

if ((diag_frameNo % 500) isEqualTo 0) then {
	private _tasks = [[],true] call MPSF_fnc_getCfgTaskModules;
	if (count _tasks > 0) then {
		private _index = ((missionNamespace getVariable ["MPSF_Taskmanager_monitor_taskStatesIndex",0]) + 1) % (count _tasks);
		missionNamespace setVariable ["MPSF_Taskmanager_monitor_taskStatesIndex",_index];
		private _taskID = (_tasks select _index) getVariable ["taskID",""];
		if !(_taskID isEqualTo "") then {
			[_taskID] spawn {sleep (1 + random 1); _this call MPSF_fnc_processCfgTask};
		};
	};
};