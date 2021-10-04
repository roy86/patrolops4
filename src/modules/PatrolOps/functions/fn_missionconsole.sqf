/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-01-18
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})
private _timeVar = "PO4_Encounter_%1_lastTime";

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
    case "getOperations" : {
		_params params [["_target",player,[objNull,grpNull,sideUnknown,missionNamespace]]];

        [];
    };
	case "setPosition" : {
		_params params [["_target",objNull,[objNull]],["_position",[0,0,0],[[],objNull,grpNull,""]],["_halo",false,[false]]];

		if (isNull _target) exitWith {false};

		switch (true) do {
			case (_position isEqualType objNull) : { _position = vehicle _position };
			case (_position isEqualType grpNull) : { _position = leader _position };
		};

		if (_position isEqualTo [0,0,0]) exitWith {false};

		switch (true) do {
			case (_position isEqualType objNull) : {
				// Move to Leader/Vehicle
				if !(locked _position > 1) then {
					if (_target moveInAny _position) exitWith {true};
				};

				private _zPos = (ASLToAGL getPosASL _position) select 2;
				private _bb = boundingBox _position;
				private _moveDirectionSelect = speed _position < 0 && !(_position isKindOf "CAManBase");

				if (_zPos >= 50) exitWith {
					private _spawnPos = _position modelToWorldVisual [5/2 - random 5,(_bb select _moveDirectionSelect select 1),(_bb select 0 select 2) * 1.25];
					if (_spawnPos isEqualTo [0,0,0]) exitWith {false};
					isNil {
						private _para = createVehicle ["Steerable_Parachute_F", _spawnPos, [], 0, "CAN_COLLIDE"];
						_para setDir (_para getDir _position);
						_target moveInDriver _para;
						_para setVelocity velocity _position;
					};
					true
				};

				//--- vehicle is on the ground, move next to it
				private _offset = (getPos _position distance getPosVisual _position) + 1.5;
				private _spawnPos = (_position getRelPos [ //--- get spawn position now, to make it more robust in scheduled
					(_bb select _moveDirectionSelect select 1)
					+
					([-_offset, _offset] select _moveDirectionSelect), //--- avoid appearing in front of a moving vehicle
					linearConversion [0, 100, round random 100, -15, 15]
				]) vectorAdd [0, 0, _zPos];

				if (isNil "_spawnPos" || {_spawnPos isEqualTo [0,0,0]}) exitWith {false};

				_target setVehiclePosition [_spawnPos, [], 0, "NONE"];
				_target setDir (_target getDir _position);

				true
			};
			case (_position isEqualType "") : {
				if !(isNull (missionNamespace getVariable [_position,objNull])) exitWith {
					["setPosition",[_target,missionNamespace getVariable [_position,objNull],_halo]] call (missionNamespace getVariable ["MPSF_fnc_respawnMP",{}]);
				};
				private _markerPos = markerPos _position;
				if (_markerPos isEqualTo [0,0,0]) exitWith {};
				markerSize _position params ["_markerX", "_markerY"];
				_target setDir markerDir _position;
				_target setVehiclePosition [_markerPos, [], (_markerX * _markerY) / 2, "NONE"];
				true
			};
			case (_position isEqualTypeArray [0,0,0]) : {
				switch (true) do {
					case (_position select 2 >= 500) : {
						[_target,_position,(_position select 2)] call MPSF_fnc_respawnHALO;
					};
					case (_position select 2 >= 50) : {
						isNil {
							private _para = createVehicle ["Steerable_Parachute_F",_position,[],0,"CAN_COLLIDE"];
							_para setDir getDir _target;
							_target moveInDriver _para;
							true
						};
						_target setPosASL AGLToASL _position;
					};
					default {
						_target setPosASL AGLToASL _position;
					};
				};
				true
			};
		};
	};
// Trigger
	case "createAction" : {
		_params params [["_logic",objNull,[objNull]]];

		if (isNull _logic) exitWith {};
		if !(isNull (_logic getVariable ["MPSF_missionConsole_Trigger",objNull])) exitWith {};

		if (hasInterface) then {
			private _trigger = createTrigger ["EmptyDetector",_logic,false];
			_trigger setTriggerArea [4,4,getDir _logic,false];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateAction',[thisTrigger,thisList]] call PO4_fnc_missionConsole;"]
				,format["['deactivateAction',[thisTrigger]] call PO4_fnc_missionConsole;"]
			];
			_trigger attachTo [_logic,[0,0,0]];
			_logic setVariable ["MPSF_missionConsole_Trigger",_trigger];
		};
	};
	case "activateAction" : {
		_params params [["_trigger",objNull],["_list",[],[[]]]];

		if !(player in _list) exitWith {};
		if !(leader group player isEqualTo player) exitWith {};

		private _logic = attachedTo _trigger;
		[format["MPSF_MissionConsole_%1_Action",_logic call BIS_fnc_netId],_logic,"Access Mission Console",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ([] call BIS_fnc_displayMission) createDisplay "RscDisplayMissionConsoleMenu"; }
			,{}
			,1,false,101
		],[],"vehicle player isEqualTo player && player distance2D _target < 4"
		,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
	};
	case "deactivateAction" : {
		_params params [["_trigger",objNull],["_list",[],[[]]]];
		private _logic = attachedTo _trigger;
		["MPSF_MissionConsole_Action",_logic] call MPSF_fnc_removeAction;
	};
// Init
	case "initConsole" : {
		_params params [["_logic",objNull,[objNull,[]]]];
		["createAction",[_logic]] call PO4_fnc_missionConsole;
	};
    case "postInit" : {
		if (isServer) then {
			["MPSF_MissionConsole_onPO4IntelTaskRequest_EH","onPO4IntelTaskRequest",{
				params [["_taskTypeID",-1,[0]],["_taskText","",[""]],["_areaID","",[""]]];

				if (_taskTypeID < 0 || _areaID isEqualTo "") exitWith {["Intel Task Type %1 could not be created at %2",str _taskTypeID,str _areaID] call BIS_fnc_error; false};

				private _encounters = (["getTasksByID",[_taskTypeID]] call MPSF_fnc_getCfgTasks) select {(missionNamespace getVariable [format [_timeVar,_x],0]) < MISSIONTIME};
				if (count _encounters isEqualTo 0) exitWith {["Intel Task %1 not found for %2",str _taskTypeID,str _areaID] call BIS_fnc_error; false;};

				[selectRandom _encounters,_areaID] call MPSF_fnc_createCfgTask;
			}] call MPSF_fnc_addEventhandler;
		};
    };
};