params [["_types",[],[[],""]],["_active","NONE",[false,""]]];

if (_types isEqualTo "") then { _types = []; };
if !(_types isEqualType []) then { _types = [_types]; };

private _taskModules = (allMissionObjects "Logic") select {_x getVariable ["MPSF_Module_Task_F",false]};

if (count _types > 0) then {
	_taskModules = _taskModules select { (_x getVariable ["cfgTaskID",""]) in _types };
};

if (_active isEqualType "") exitWith {_taskModules};

switch (true) do {
	case (_active isEqualTo true) : { _taskModules select { (_x getVariable ["TaskActive",false]); }; };
	case (_active isEqualTo false) : { _taskModules select { !(_x getVariable ["TaskActive",true]); }; };
};
