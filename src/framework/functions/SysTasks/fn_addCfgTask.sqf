if !(isServer) exitWith {};

params [["_cfgTaskID","",[""]],["_parentID","",[""]]];

if (_cfgTaskID isEqualTo "") exitWith {};

// Create Unique Task ID
private _taskID = [_cfgTaskID] call MPSF_fnc_getCfgTaskID;
private _taskLogic = [[0,0,0],_taskID] call MPSF_fnc_createCfgTaskLogic;
_taskLogic setVariable ["MPSF_Module_Task_F",true,true];
_taskLogic setVariable ["cfgTaskID",_cfgTaskID,true];
_taskLogic setVariable ["taskID",_taskID,true];
_taskLogic setVariable ["TaskActive",false,true];
if (["isParent",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) then {
	_taskLogic setVariable ["childTaskIDs",[],true];
};

// Crate Task Position
private _positionData = [_cfgTaskID,_taskID] call MPSF_fnc_getCfgTaskPosition;
_positionData params [["_position",[0,0,0],[[]]],["_positionOffset",[0,0,0],[[]]],["_areaID",[0,0,0],[[],""]]];
_taskLogic setVariable ["position",_position,true];
_taskLogic setVariable ["positionOffset",_positionOffset,true];
_taskLogic setVariable ["area",_areaID,true];
_taskLogic setPos _positionOffset;

private _args = [
	["TaskDetails",[_cfgTaskID,"description"]] call MPSF_fnc_getCfgTasks
	,["TaskDetails",[_cfgTaskID,"title"]] call MPSF_fnc_getCfgTasks
];

private _textArguments = ["TaskDetails",[_cfgTaskID,"textArguments"]] call MPSF_fnc_getCfgTasks;
{
	private _argument = [_x,[_position,[]]] call MPSF_fnc_getTaskDescription;
	_textArguments set [_forEachIndex,_argument];
} forEach _textArguments;

if (_args isEqualType []) then {
	{ _args set [_forEachIndex,format([_x] + _textArguments)]; } forEach _args;
};

private _score = ["minIntelScore",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
if (_score >= 0) then {
	_taskLogic setVariable ["taskScore",_score,true];
};

_args params ["_description","_title"];
_taskLogic setVariable ["taskTitle",_title,true];
_taskLogic setVariable ["taskDesc",_description,true];

_taskLogic;