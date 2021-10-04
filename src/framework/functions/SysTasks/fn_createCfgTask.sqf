#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})

params [["_cfgTaskID","",["",[]]],["_position","",[[],""]],["_parentID","",[""]]];

if (_cfgTaskID isEqualTo "") exitWith {};

private _taskID = "";
if (_cfgTaskID isEqualType []) then {
	_taskID = _cfgTaskID param [0,"",[""]];
	_cfgTaskID = _cfgTaskID param [1,"",[""]];
};

if (_taskID isEqualTo "") then {_taskID = [_cfgTaskID] call MPSF_fnc_getCfgTaskID; };

private _lastTimeVar = format ["PO4_Encounter_%1_lastTime",_cfgTaskID];
missionNamespace setVariable [_lastTimeVar,MISSIONTIME + (["conditionTimeout",[_cfgTaskID]] call MPSF_fnc_getCfgTasks)];
publicVariable _lastTimeVar;

// Create Task Manager Logic
private _taskLogic = missionNamespace getVariable [_taskID,objNull];
if (isNull _taskLogic) then { _taskLogic = [[0,0,0],_taskID] call MPSF_fnc_createCfgTaskLogic; };
_taskLogic setVariable ["cfgTaskID",_cfgTaskID,true];
_taskLogic setVariable ["taskID",_taskID,true];
_taskLogic setVariable ["parentID",_parentID,true];

// Crate Task Position
private _positionData = [_cfgTaskID,_taskID,_position] call MPSF_fnc_getCfgTaskPosition;
_positionData params [["_position",[0,0,0],[[]]],["_positionOffset",[0,0,0],[[]]],["_areaID",[0,0,0],[[],""]]];
_taskLogic setVariable ["position",_position,true];
_taskLogic setVariable ["positionOffset",_positionOffset,true];
_taskLogic setVariable ["area",_areaID,true];
_taskLogic setPos _positionOffset;

// Create Markers
[_taskID,_cfgTaskID] call MPSF_fnc_createCfgTaskMarkers;

// Create Compositions
[_taskID,_cfgTaskID] call MPSF_fnc_createCfgTaskCompositions;

// Create Return Point
[_taskID,_cfgTaskID] call MPSF_fnc_createCfgTaskReturnPoint;

// Create Deployable Objects
[_taskID,_cfgTaskID] call MPSF_fnc_createCfgTaskDeployable;

// Create Parent Task
[_taskID,_cfgTaskID,_parentID] call MPSF_fnc_createCfgTaskObjective;

// Create Groups
if ([] call MPSF_fnc_isHeadlessClientPresent) then {
	["onSpawnCommand",[_taskID,_cfgTaskID,_position,_positionOffset],[] call MPSF_fnc_getHeadlessClient] call MPSF_fnc_triggerEventHandler;
} else {
	[_taskID,_cfgTaskID,_position,_positionOffset] call MPSF_fnc_createCfgTaskGroups;
};

[_taskID,_cfgTaskID] call MPSF_fnc_addCfgTaskMonitor;

// Fire onTaskCreate Event Handler
["onTaskCreate",[_taskID,_cfgTaskID],0] call MPSF_fnc_triggerEventHandler;

if (["isParent",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) then {
	// Create Children Tasks
	private _childTask = ["childTask",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
	if (count _childTask > 0) then {
		[selectRandom _childTask,nil,_taskID] call MPSF_fnc_createCfgTask;
	};
	private _childTasks = ["childTasks",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
	if (count _childTasks > 0) then {
		{ [_x,nil,_taskID] call MPSF_fnc_createCfgTask; } forEach _childTasks;
	};

	if (count _childTasks > 0) then {
	};
};

_taskLogic setVariable ["TaskActive",true,true];

_taskLogic