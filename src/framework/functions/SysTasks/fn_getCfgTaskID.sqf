params [["_cfgTaskID","",[""]]];

if (_cfgTaskID isEqualTo "") exitWith { "" };

_testFuntion = {
	params ["_testID"];
	[_testID] call BIS_fnc_taskExists
	|| !(isNull (missionNamespace getVariable [_testID,objNull]))
	|| _testID in (missionNamespace getVariable ["MPSF_var_createdTaskIDs",[]])
};


if ([_cfgTaskID] call _testFuntion) then {
	for "_i" from 1 to 999 do {
		private _testID = format["%1_%2",_cfgTaskID,_i];
		if !([_testID] call _testFuntion) exitWith { _cfgTaskID = _testID; };
	};
};

private _createdIDs = missionNamespace getVariable ["MPSF_var_createdTaskIDs",[]];
_createdIDs pushback _cfgTaskID;
missionNamespace setVariable ["MPSF_var_createdTaskIDs",_createdIDs];

_cfgTaskID;