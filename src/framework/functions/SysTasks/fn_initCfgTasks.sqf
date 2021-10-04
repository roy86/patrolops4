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

if (isServer) then {
	private _scope2Tasks = (["CfgMissionTasks"] call BIS_fnc_getCfgSubClasses) select {(["CfgMissionTasks",_x,"scope"] call MPSF_fnc_getCfgDataNumber) isEqualTo 2};
	{
		[_x] call MPSF_fnc_createCfgTask;
	} forEach (_scope2Tasks);
};

if !(isServer || hasInterface) then { // Headless Client
	["MPSF_Taskmanager_HLC_onSpawnCommand_EH","onSpawnCommand",{ _this call MPSF_fnc_createCfgTaskGroups; }] call MPSF_fnc_addEventHandler;
};