params [["_taskLogic",objNull,[objNull]],["_cfgTaskID","",[""]],["_taskID","",[""]]];

private _arguments = [];
_arguments pushBack (_taskLogic getVariable ["targets",[]]);
_arguments pushBack (_taskLogic getVariable ["groups",[]]);
_arguments pushBack (_taskLogic getVariable ["units",[]]);
_arguments pushBack (_taskLogic getVariable ["lives",-1]);
_arguments pushBack (abs(_taskLogic getVariable ["lives",-1]) > 0);

private _attributes = ["objectiveAttributes",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;

#define ATTRCOUNT 4
{
	switch (toLower _x) do {
		case "targetkilled";
		case "targetskilled" : {
			_arguments set [ATTRCOUNT + 1,
				({alive _x && canMove _x} count (_taskLogic getVariable ["targets",[]]) == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "targetdestroyed";
		case "targetsdestroyed" : {
			private _targets = _taskLogic getVariable ["targets",[]];
			_targets append (_taskLogic getVariable ["targetObjects",[]]);
			_targets append (_taskLogic getVariable ["deployableTargets",[]]);
			_arguments set [ATTRCOUNT + 2,
				({alive _x && damage _x < 0.8} count _targets == 0)
			];
		};
		case "targetreturned";
		case "targetsreturned" : {
			private _targets = _taskLogic getVariable ["targets",[]];
			if (count _targets > 0 && (_taskLogic getVariable ["cfgGroupsSet",false])) then {
				_targets = _targets apply {
					if (alive _x) then {
						_x distance getMarkerPos ([position _x] call MPSF_fnc_getNearestReturnPoint) < 30
						&& isTouchingGround _x
						&& alive _x
						&& canMove _x
					} else {isNull _x}
				};
			} else { _targets = [false]; };
			_arguments set [ATTRCOUNT + 3,count (_targets select {_x}) == count _targets];
		};
		case "targetdeployed";
		case "targetsdeployed" : {
			private _targetAreas = _taskLogic getVariable ["deployableObjects",[]];
			private _deployedTargets = [];
			{
				_x params [["_deployClass","",[""]],["_deployArea",[[0,0,0],0,0,0,false],[[]]]];
				_deployArea params [["_deployDest",[0,0,0],[[]]],["_xRadius",0,[0]],["_yRadius",0,[0]]];
				private _nearbyObjects = _deployDest nearObjects [_deployClass,_xRadius max _yRadius];
				if (count (_nearbyObjects select {_x inArea _deployArea}) > 0) then {
					_deployedTargets pushBack _deployClass;
				};
			} forEach _targetAreas;
			_arguments set [ATTRCOUNT + 4,count(_deployedTargets) isEqualTo count(_targetAreas)];
		};
		case "unitskilled" : {
			_arguments set [ATTRCOUNT + 5,
				({alive _x && canMove _x} count (_taskLogic getVariable ["units",[]]) == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "cachedestroyed" : {
			private _caches = (_taskLogic getVariable ["targets",[]]) select {typeOf _x IN (["WeaponCacheTypes"] call MPSF_fnc_getCfgTasks)};
			_arguments set [ATTRCOUNT + 6,
				({damage _x == 0} count _caches == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "inteldownloaded" : {
			_arguments set [ATTRCOUNT + 7,_taskLogic getVariable ["inteldownloaded",false]];
		};
		case "intelpickedup" : {
			_arguments set [ATTRCOUNT + 8,_taskLogic getVariable ["intelpickedup",false]];
		};
		case "intelrecieved" : {
			_arguments set [ATTRCOUNT + 9,_taskLogic getVariable ["intelrecieved",false]];
		};
		case "playerskilled" : {
			private _allPlayers = [_taskID] call MPSF_fnc_getAssignedTaskPlayers;
			_arguments set [ATTRCOUNT + 10,
				count (_allPlayers select {!(_taskID IN (_x getVariable ["MPSF_Player_var_assignedTasksKIA",[]]))}) == 0
			];
		};
		case "playersleft" : {
			private _allPlayers = [_taskID] call MPSF_fnc_getAssignedTaskPlayers;
			_arguments set [ATTRCOUNT + 11,
				count (_allPlayers select {!(_taskID IN (_x getVariable ["MPSF_Player_var_assignedTasksKIA",[]]))}) > 0
			];
		};
		case "sectorscleared" : {
			_arguments set [ATTRCOUNT + 12,false];
		};
		case "areadefended" : {
			private _areaActive = missionNamespace getVariable [format["MPSF_Taskmanager_%1_var_areaActive",_taskID],false];
			if !(_areaActive) then {
				missionNamespace setVariable [format["MPSF_Taskmanager_%1_var_areaActive",_taskID],({false} count allPlayers > 0)];
			};
			if (_areaActive) then { ({alive _x} count allPlayers > 0) } else {true};
			_arguments set [ATTRCOUNT + 13,false];
		};
		case "childtaskscomplete" : {
				private _childTasks = [_taskID] call BIS_fnc_taskChildren;
				_arguments set [ATTRCOUNT + 14,count (_childTasks select {[_x] call MPSF_fnc_isTaskComplete}) isEqualTo count _childTasks];
		};
		case "playersnearby" : {
			_arguments set [ATTRCOUNT + 15,
				count (allPlayers select {_x distance _taskLogic < 3000}) > 0
			];
		};
		case "minesdestroyed" : {
			private _mineTriggers = [];
			{
				_mineTriggerType = tolower gettext (_x >> "mineTriggerType");
				if (_mineTriggerType in ["radius","wire"]) then {
					_mineTriggers pushback tolower configname _x;
				};
			} foreach ((configfile >> "CfgMineTriggers") call bis_fnc_returnchildren);

			private _mineTypes = (_taskLogic getVariable ["targetObjects",[]]) select {
				_trigger = tolower gettext (configfile >> "cfgammo" >> typeof _x >> "minetrigger");
				_trigger in _mineTriggers;
			};

			_arguments set [ATTRCOUNT + 16,
				({damage _x == 0} count _mineTypes == 0)
				&& (_taskLogic getVariable ["cfgGroupsSet",false])
			];
		};
		case "targetsdelivered" : {
			private _targets = _taskLogic getVariable ["targets",[]];
			private _targetPoint = (_taskLogic getVariable ["positionOffset",[0,0,0]]) call BIS_fnc_position;
			if (count _targets > 0 && (_taskLogic getVariable ["cfgGroupsSet",false])) then {
				_targets = _targets apply {
					_x distance _targetPoint < 30
					&& !(["isLoaded",[_x]] call (missionNamespace getVariable ["MPSF_fnc_logistics",{false}]))
					&& alive _x
					&& damage _x < 0.8
				};
			} else { _targets = [false]; };
			_arguments set [ATTRCOUNT + 17,count (_targets select {_x}) == count _targets];
		};
	};
} forEach _cfgTaskAttributes;

_arguments