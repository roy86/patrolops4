params [["_position",[0,0,0],[[],""]],["_radius",0,[0]]];

private _taskModules = (allMissionObjects "Logic") select {_x getVariable ["MPSF_Module_Task_F",false]};

if (count _taskModules > 0) then {
	_taskModules = _taskModules select { _x distance2D _position <= _radius };
};

count _taskModules > 0