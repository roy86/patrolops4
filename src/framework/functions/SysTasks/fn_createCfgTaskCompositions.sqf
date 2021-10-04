params [["_taskLogic",objNull,[objNull,""]],["_cfgTaskID","",[""]]];

if !(["hasCompositions",[_cfgTaskID]] call MPSF_fnc_getCfgTasks) exitWith { [] };

if (typeName _taskLogic isEqualTo typeName "") then { _taskLogic = missionNamespace getVariable [_taskLogic,objNull]; };
if (isNull _taskLogic) exitWith { /*["Unable to get task logic"] call BIS_fnc_error;*/ };

private _taskID = _taskLogic getVariable ["taskID",""];
private _position = _taskLogic getVariable ["position",[0,0,0]];
private _positionOffset = _taskLogic getVariable ["positionOffset",[0,0,0]];

private _compositionData = ["Compositions",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _intelObjects = ["intelDownloadTypes"] call MPSF_fnc_getCfgTasks;
private _targetObjects = [];
private _createdObjects = [];
{
	_x params [
		["_compID","",[""]]
		,["_compTypes",[],[[]]]
		,["_compPos",[0,0,0],[[],""]]
		,["_compDist",[0,0],[[]]]
		,["_compDir",[0,0],[[]]]
		,["_compRadius",100,[0]]
		,["_compAngle",[0,0],[]]
		,["_compFaction","",[""]]
		,["_compGroups",[],[[]]]
		,["_compTargets",[],[[]]]
		,["_compIntel",false,[false]]
		,["_compMinefield","",[""]]
	];

	if (_compPos isEqualTo "position") then { _compPos =+ _position };
	if (_compPos isEqualTo "positionOffset") then { _compPos =+ _positionOffset };
	if (typeName _compPos isEqualTo typeName "") then { _compPos = _compPos call BIS_fnc_position; };

	_compDist = ([(_compDist select 0) * 100,(_compDist select 1) * 100] call BIS_fnc_randomNum)/100;
	if (_compDist > 0) then {
		_compDir = ([(_compDir select 0) * 100,(_compDir select 1) * 100] call BIS_fnc_randomNum)/100;
		_compPos = [_compPos,_compDist,_compDir] call BIS_fnc_relPos;
	};
	_compAngle = ([(_compAngle select 0) * 100,(_compAngle select 1) * 100] call BIS_fnc_randomNum) / 100;

	switch (true) do {
		case !(_compMinefield isEqualTo "") : {
			private _factionID = ["sideID","FactionTypeBLU"] call MPSF_fnc_getCfgFaction;
			private _mines = switch (toLower _compMinefield) do {
				case "uxo" : {[_factionID,_compPos,[0,_compRadius],_compIntel] call MPSF_fnc_createUXOarea;};
				case "ied" : {[_compPos,[0,_compRadius],_compIntel] call MPSF_fnc_createIED;};
				default {[]};
			};
			_targetObjects append _mines;
			_createdObjects append _mines;
		};
		case (count _compTypes > 0) : {
			private _compType = selectRandom _compTypes;
			private _compObjects = [_compType,_compPos,_compAngle] call MPSF_fnc_createComposition;
			{
				private _compObject = _x;
				if ({_compObject isKindOf _x} count _compTargets > 0) then {
					_targetObjects pushback _compObject;
					[[_compObject],[_taskID]] call MPSF_fnc_eventOnObjectDamagedC4;
				};
				if (_compIntel) then {
					if ({_compObject isKindOf _x} count _intelObjects > 0) then {
						[_compObject,[_taskID,_cfgTaskID]] call MPSF_fnc_createIntel;
					};
				};
				_createdObjects pushBack _compObject;
			} forEach _compObjects;
		};
		case (count _compTargets > 0) : {
			private _nearestObjects = nearestObjects [_compPos,_compTargets,_compRadius];

			if (count _nearestObjects == 0) then {
				private _compTarget = createVehicle [selectRandom _compTargets,_compPos,[],0,"CAN_COLLIDE"];
				_compTarget setVehiclePosition [_compPos,[],0,"CAN_COLLIDE"];
				_nearestObjects = [_compTarget];
			};

			{
				private _compObject = _x;
				_targetObjects pushback _compObject;
				["onObjectiveDamaged",[[_compObject],[_taskID]]] call MPSF_fnc_eventhandlers;
				if (_compIntel) then {
					if ({_compObject isKindOf _x} count _intelObjects > 0) then {
						[_compObject,[_taskID,_cfgTaskID]] call MPSF_fnc_createIntel;
					};
				};
				_createdObjects pushBack _compObject;
			} forEach _nearestObjects;
		};
	};
} forEach _compositionData;

_taskLogic setVariable ["targetObjects",_targetObjects];
_taskLogic setVariable ["compositions",_createdObjects];

_createdObjects