/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_simulCiv.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Civilian Simulation System

	Parameter(s):
		0: Object - Description

	Returns:
		Bool - True when done
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

//#define CLASSNAMES []
#define CLASSNAMES (["CfgSides","Civilian_Malden","Crowd24"] call BIS_fnc_getCfgDataArray)

switch (_mode) do {
/* TRIGGER AREAS */
	case "createTriggerArea" : {
		if (isServer) then {
			_params params [["_areaID","",[""]]];

			if (_areaID isEqualTo "") exitWith {};

			private _areaLogic = missionNamespace getVariable [_areaID,objNull];
			if (isNull _areaLogic) then {
				private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
				_areaLogic = [_areaPos] call MPSF_fnc_createLogic;
				_areaLogic setVariable ["MPSF_Module_Area_F",true,true];
				_areaLogic setVariable ["areaActive",false,true];
				_areaLogic setVariable ["areaType",["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData,true];
				_areaLogic setVehicleVarName _areaID;
				missionNamespace setVariable [_areaID,_areaLogic];
				publicVariable _areaID;
			};

			private _areaType = ["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData;

			private _checkRadius = 400;
			private _trigger = createTrigger ["EmptyDetector",_areaLogic,false];
			_trigger setTriggerArea [_checkRadius,_checkRadius,getDir _areaLogic,false,50];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["this"
				,format["['activateArea',[thisTrigger,%1]] call MPSF_fnc_simulCiv;",str _areaType]
				,format["['deactivateArea',[thisTrigger]] call MPSF_fnc_simulCiv;"]
			];
			_trigger attachTo [_areaLogic,[0,0,0]];
			_areaLogic setVariable ["VirtualDepot_Trigger",_trigger];
		};
	};
	case "activateArea" : {
		_params params [["_trigger",objNull],["_areaType","",[""]]];

		private _areaLogic = attachedTo _trigger;
		if (isNull _areaLogic) exitWith { ["Unable to retrieve area logic attached to trigger"] call BIS_fnc_error; };

		if (toLower _areaType in ["city","town","village","house"]) then {
			// Create Groups
			if ([] call MPSF_fnc_isHeadlessClientPresent) then {
				["onSpawnCivCommand",[_areaLogic,str _areaLogic],[] call MPSF_fnc_getHeadlessClient] call MPSF_fnc_triggerEventHandler;
			} else {
				["createCivAgentPopulation",[_areaLogic,str _areaLogic]] call MPSF_fnc_simulCiv;
			};
		};
	};
	case "deactivateArea" : {
		_params params [["_trigger",objNull]];
		private _areaLogic = attachedTo _trigger;
		if (isNull _areaLogic) exitWith {};
		{ deleteVehicle _x; } forEach (_areaLogic getVariable ["MPSF_CivPop_var_groupID",[]]);
	};
/* CREATE Fuctions */
	case "createCivPopulation" : {
		_params params [["_civLogic",objNull,[objNull,""]],["_areaID","",[""]]];

		if (typeName _civLogic isEqualTo typeName "") then { _civLogic = missionNamespace getVariable [_civLogic,objNull]; };
		if (isNull _civLogic) exitWith {[]};

		private _areaType = ["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData;
		if (isClass (["CfgMissionFramework","CivilianSimulation",_areaType] call BIS_fnc_getCfg)) then {
			private _civInit = ["CfgMissionFramework","CivilianSimulation","init"] call MPSF_fnc_getCfgDataText;
			private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaBuildingCount = ["getAreaBuildingCount",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaSize = ["getAreaOrientation",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _groupTypes = ["CfgMissionFramework","CivilianSimulation",_areaType,"classNames"] call MPSF_fnc_getCfgDataArray;
			_areaSize params ["_sizeX","_sizeY","_rotation"];
			private _varData = [];
			if (count _groupTypes > 0) then {
				private _groupData = [_areaPos,"FactionTypeCIV",(selectRandom _groupTypes)] call MPSF_fnc_createAgentGroup;
				if !(isNull _groupData) then {
					["setAgentCrowd",[_groupData,_areaPos,_sizeX max _sizeY]] call MPSF_fnc_simulCiv;
					{
						if !(_civInit isEqualTo "") then {_x call compile _civInit;};
						_x removeWeaponGlobal secondaryWeapon _x;
						_x removeWeaponGlobal handgunWeapon _x;
						if (random 1 < 0.8) then {
							_x removeWeaponGlobal primaryWeapon _x;
						} else {
							_x action ["WeaponOnBack", _x];
						};
					} forEach _groupData;
					if (["CfgMission","Encounters","enableSVIDs"] call MPSF_fnc_getCfgDataBool) then {
						[selectRandom _groupData,_areaPos,150] call MPSF_fnc_setGroupSIED;
					};
					_varData append units _groupData;
				};
			};
			_civLogic setVariable ["MPSF_CivPop_var_groupID",_varData,true];
		};
	};
	case "createCivAgentPopulation" : {
		_params params [["_civLogic",objNull,[objNull,""]],["_areaID","",[""]]];

		if (typeName _civLogic isEqualTo typeName "") then { _civLogic = missionNamespace getVariable [_civLogic,objNull]; };
		if (isNull _civLogic) exitWith {[]};

		private _areaType = ["getAreaType",[_areaID]] call MPSF_fnc_getCfgMapData;
		if (isClass (["CfgMissionFramework","CivilianSimulation",_areaType] call BIS_fnc_getCfg)) then {
			private _civInit = ["CfgMissionFramework","CivilianSimulation","init"] call MPSF_fnc_getCfgDataText;
			private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaBuildingCount = ["getAreaBuildingCount",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _areaSize = ["getAreaOrientation",[_areaID]] call MPSF_fnc_getCfgMapData;
			private _groupTypes = ["CfgMissionFramework","CivilianSimulation",_areaType,"classNames"] call MPSF_fnc_getCfgDataArray;
			_areaSize params ["_sizeX","_sizeY","_rotation"];
			private _varData = [];
			if (count _groupTypes > 0) then {
				private _groupData = [_areaPos,"FactionTypeCIV",(selectRandom _groupTypes)] call MPSF_fnc_createAgentGroup;
				if (count _groupData > 0) then {
					["setAgentCrowd",[_groupData,_areaPos,_sizeX max _sizeY]] call MPSF_fnc_simulCiv;
					{
						if !(_civInit isEqualTo "") then {_x call compile _civInit;};
						_x removeWeaponGlobal secondaryWeapon _x;
						_x removeWeaponGlobal handgunWeapon _x;
						if (random 1 < 0.8) then {
							_x removeWeaponGlobal primaryWeapon _x;
						} else {
							_x action ["WeaponOnBack", _x];
						};
					} forEach _groupData;
					[selectRandom _groupData,_areaPos,150] call MPSF_fnc_setGroupSIED;
					_varData append _groupData;
				};
			};

			private _vehicleTypes = ["CfgMissionFramework","CivilianSimulation",_areaType,"vehicles"] call MPSF_fnc_getCfgDataArray;
			if (count _vehicleTypes > 0) then {
				private _vehicleData = [_areaPos,"FactionTypeCIV",(selectRandom _vehicleTypes),"Crowd4"] call MPSF_fnc_createAgentVehicle;
				_vehicleData params [["_vehicle",objNull,[objNull]],["_units",[],[[]]]];
				if (count _units > 0) then {
					["setDrive",[[driver _vehicle],_areaPos,_sizeX max _sizeY]] call MPSF_fnc_simulCiv;
					_varData append [_vehicle];
					_varData append _units;
				};
			};

			_civLogic setVariable ["MPSF_CivPop_var_groupID",_varData,true];
		};
	};
/* Behaviour Functions */
	case "setAgentCrowd" : {
		_params params [["_groupUnits",[],[[]]],["_position",[0,0,0],[[]]],["_radius",0,[0]]];

		if (count _groupUnits == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupUnits,mapGridPosition _position] call BIS_fnc_error;*/ false };

		private _movePositions = [_position,_radius,true] call MPSF_fnc_getNearbyBuildings;
		if (count _movePositions < 10) then {
			private _wpcount = (round(_radius / 15) max 5) min 10;
			private _inc = 360/_wpcount;
			for "_i" from 0 to _wpcount do {
				private _ang = _inc * _i;
				private _a = (_position select 0)+(sin(_ang)*_radius);
				private _b = (_position select 1)+(cos(_ang)*_radius);
				if !(surfaceIsWater [_a,_b]) then{
					_movePositions pushBack [_a,_b,0];
				};
			};
			if (count _movePositions == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupUnits,mapGridPosition _position] call BIS_fnc_error;*/ false; };
		};

		{
			_x setVariable ["crowdData",_movePositions];
			_x setPosATL (selectRandom _movePositions);
			_x setSpeedMode "LIMITED";
			_x setBehaviour "CARELESS";
			_x forceSpeed (_x getSpeed "Slow");
			_x action ["WeaponOnBack", _x];
		} forEach _groupUnits;

		["MPSF_SimulCiv_Crowd_EH","onEachFrame",{
			if (count agents > 0) then {
				private _agent = agents select (diag_frameno % count agents);
				if (_agent getVariable ["inConversation",false]) exitWith {
					(agent _agent) moveTo (position agent _agent);
				};
				{
					private _unit = agent _x;// getVariable ["agentObject",objNull];
					_movePositions = _x getVariable ["crowdData",[]];
					if (count _movePositions > 0) then {
						if (currentCommand _unit isEqualTo "") then {
							_unit moveTo (selectRandom _movePositions);
						};
					};
				} forEach [_agent];
			};
		}] call MPSF_fnc_addEventHandler;
	};
	case "setDrive" : {
		_params params [["_groupUnits",[],[[]]],["_position",[0,0,0],[[]]],["_radius",0,[0]]];

		//if (count _groupUnits == 0) exitWith { /*["Unable to assign waypoints to group %1 in %2",_groupUnits,mapGridPosition _position] call BIS_fnc_error;*/ false };

		private _movePositions = [];
		private _wpcount = (round(_radius / 15) max 5) min 10;
		private _inc = 360/_wpcount;
		for "_i" from 0 to _wpcount do {
			private _ang = _inc * _i;
			private _a = (_position select 0)+(sin(_ang)*_radius);
			private _b = (_position select 1)+(cos(_ang)*_radius);
			if !(surfaceIsWater [_a,_b]) then{
				_movePositions pushBack [_a,_b,0];
			};
		};

		if (count _movePositions == 0) exitWith {
			["Unable to assign waypoints to group %1 in %2",_groupUnits,mapGridPosition _position] call BIS_fnc_error;
			false;
		};

		{
			_x setVariable ["crowdData",_movePositions];
			_x setSpeedMode "LIMITED";
			_x forceSpeed (_x getSpeed "NORMAL");
		} forEach _groupUnits;

		["MPSF_SimulCiv_Crowd_EH","onEachFrame",{
			if (count agents > 0) then {
				private _agent = agents select (diag_frameno % count agents);
				if (_agent getVariable ["inConversation",false]) exitWith {
					(agent _agent) moveTo (position agent _agent);
				};
				{
					private _unit = agent _x;// getVariable ["agentObject",objNull];
					_movePositions = _x getVariable ["crowdData",[]];
					if (count _movePositions > 0) then {
						if (currentCommand _unit isEqualTo "") then {
							_unit moveTo (selectRandom _movePositions);
						};
					};
				} forEach [_agent];
			};
		}] call MPSF_fnc_addEventHandler;
	};
/* Initialise */
	case "init" : {
		if (isServer) then {
			private _areas = ["getNearbyAreas",[[worldSize/2,worldSize/2,0],["Town","Village","City","Farm"],worldSize]] call MPSF_fnc_getCfgMapData;
			{
				["createTriggerArea",[_x]] call MPSF_fnc_simulCiv;
			} forEach _areas;
		};
		if !(isServer || hasInterface) then { // Headless Client
			["MPSF_CivlianPopulation_HLC_onSpawnCommand_EH","onSpawnCivCommand",{
				params [["_areaLogic",objNull,[objNull]],["_areaID","",[""]]];
				if !(isNull _areaLogic) then {
					["createCivAgentPopulation",[_areaLogic,_areaID]] call MPSF_fnc_simulCiv;
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
};