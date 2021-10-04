/*
	Author: RoyEightySix (https://www.roy86.com.au)
	Date: 2020-12-14
	
	Description:
		No description added yet.
	
	Parameter(s):
		_localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
	
	Returns:
		Function reached the end [BOOL]
*/
#define OPERATIONIDS	[2,3,4,5,6,7,8,9]
#define TASKSIDS		[10,11,12,13,14,15,16,17,18,19]
#define ENCOUNTERIDS	[100,101,102,103,104,105,106,107,108,109]
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})
#define TIMEVAR "PO4_Encounter_%1_lastTime"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "registerGroupStartPatrol" : {
		_params params [["_target",objNull,[objNull]]];

		if (isNull _target) exitWith {};
		private _groupID = group _target;

		if (isServer) then {};
		if (hasInterface) then {
			// Movement Event Handlers
			["PO4_Encounter_onMove_EH","HasMoved",{ _this spawn {
				params [["_oldPos",[0,0,0],[[]]],["_newPos",[0,0,0],[[]]],["_totalDistance",1,[0]],["_distance",0,[0]]];
				if !(leader group player isEqualTo player) exitWith {};
				missionNamespace setVariable ["PO4_lastMovedTime",MISSIONTIME+60];
				if !(((missionNamespace getVariable ["PO4_lastEncounterTime",MISSIONTIME]) - MISSIONTIME) <= 0) exitWith {};
				if !(["logRegBeta",_newPos,_oldPos getDir _newPos,_distance] call PO4_fnc_logreg) exitWith {};
				[player,_newPos,_distance,_oldPos getDir _newPos,speed player] call PO4_fnc_encounter;
			};}] call MPSF_fnc_addEventHandler;

			// Inactive Attacks
			["PO4_Encounter_onEachFrame_EH","onEachFrame",{
				if !(leader group player isEqualTo player) exitWith {};
				if !(((missionNamespace getVariable ["PO4_lastEncounterTime",MISSIONTIME]) - MISSIONTIME) <= 0) exitWith {};

				private _timeStill = (missionNamespace getVariable ["PO4_lastMovedTime",MISSIONTIME]) - MISSIONTIME;
				if (_timeStill <= 0) then {
					private _safeZones = (([(["side","FactionTypeBLU"] call MPSF_fnc_getCfgFaction)] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x});
					if ({player distance2D _x > 500} count _safeZones > 0) exitWith {
						missionNamespace setVariable ["PO4_lastMovedTime",MISSIONTIME+120];
					};

					private _existingTasks = ([] call MPSF_fnc_getCfgTaskModules) select {player distance2D _x < 1000};
					if (count (_existingTasks) > 0) exitWith {
						missionNamespace setVariable ["PO4_lastMovedTime",MISSIONTIME+120];
					};

					missionNamespace setVariable ["PO4_lastMovedTime",MISSIONTIME+120];
					if !(["logRegBeta",_newPos,_oldPos getDir _newPos,_distance] call PO4_fnc_logreg) exitWith {};

					private _stationaryEncountersTimer = (["CfgMission","Encounters","stationaryEncountersTimer"] call MPSF_fnc_getCfgDataNumber) max 300;
					missionNamespace setVariable ["PO4_lastMovedTime",MISSIONTIME+_stationaryEncountersTimer];
					["onEncounterAttackRequest",[player,position player],2] call MPSF_fnc_triggerEventHandler;
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
/* Init */
	case "initNewstarterUIX" : {
		if (["missionDebugMode"] call MPSF_fnc_getCfgDataBool) exitWith { false; };
		if !(["enableNewStarterUI"] call MPSF_fnc_getCfgDataBool) exitWith { false; };

		[([] call BIS_fnc_displayMission),"RscDisplayNewStarterUI"] call MPSF_fnc_createCtrl;

		if !(count units group player > 1) then {
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step1_Icon",controlNull]) ctrlSetTextColor [1,0.78,0,1];
			["PO4_newStarter_step1_EH","onEachFrame",{
				if (count units group player > 1) then {
					["PO4_newStarter_step1_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
					(uiNamespace getVariable ["RscDisplayNewStarterUI_Step1_Icon",controlNull]) ctrlSetTextColor [0.3,0.3,0.3,0.8];
					(uiNamespace getVariable ["RscDisplayNewStarterUI_Step1_Title",controlNull]) ctrlSetStructuredText parseText "";
				};
			}] call MPSF_fnc_addEventHandler;
		} else {
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step1_Icon",controlNull]) ctrlSetTextColor [0.3,0.3,0.3,0.8];
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step1_Title",controlNull]) ctrlSetStructuredText parseText "";
		};

		if (currentWeapon player isEqualTo "") then {
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step2_Icon",controlNull]) ctrlSetTextColor [1,0.78,0,1];
			["PO4_newStarter_step2_EH","arsenalClosed",{
				if !(currentWeapon player isEqualTo "") then {
					["PO4_newStarter_step2_EH","arsenalClosed"] call MPSF_fnc_removeEventHandler;
					(uiNamespace getVariable ["RscDisplayNewStarterUI_Step2_Icon",controlNull]) ctrlSetTextColor [0.3,0.3,0.3,0.8];
					(uiNamespace getVariable ["RscDisplayNewStarterUI_Step2_Title",controlNull]) ctrlSetStructuredText parseText "";
				};
			}] call MPSF_fnc_addEventHandler;
		} else {
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step2_Icon",controlNull]) ctrlSetTextColor [0.3,0.3,0.3,0.8];
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step2_Title",controlNull]) ctrlSetStructuredText parseText "";
		};

		(uiNamespace getVariable ["RscDisplayNewStarterUI_Step3_Icon",controlNull]) ctrlSetTextColor [1,0.78,0,1];
		["PO4_newStarter_step3_EH","onPO4StartLeftBase",{
			["PO4_newStarter_step3_EH","onPO4StartLeftBase"] call MPSF_fnc_removeEventHandler;
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step3_Icon",controlNull]) ctrlSetTextColor [0.3,0.3,0.3,0.8];
			(uiNamespace getVariable ["RscDisplayNewStarterUI_Step3_Title",controlNull]) ctrlSetStructuredText parseText "";
			["RscDisplayNewStarterUI"] call MPSF_fnc_destroyCtrl;
		}] call MPSF_fnc_addEventHandler;
	};
	case "postInit" : {
		private _missionParamOpsCount = ["PO4MissionOpCount",0] call BIS_fnc_getParamValue;
		private _missionParamEncounters = ["PO4MissionEncounters",0] call BIS_fnc_getParamValue;
		private _missionParamType = ["PO4MissionType",0] call BIS_fnc_getParamValue;

		private _radius = 1500;

		if (isServer) then {
			// Encounters
			if (_missionParamType in [0,2]) then {
				["PO4_Server_onEncounterRequest_EH","onEncounterRequest",{
					params [["_requestor",objNull,[objNull]],["_encounter",[],[[]]],["_force",false,[false]]];
					if (((missionNamespace getVariable ["PO4_lastEncounterTime",MISSIONTIME]) - MISSIONTIME) <= 0 || _force) then {
						missionNamespace setVariable ["PO4_lastEncounterTime",MISSIONTIME+100];
						publicVariable "PO4_lastEncounterTime";
						_encounter spawn MPSF_fnc_createCfgTask;
					} else {
						systemChat str ["Too Early Time",((missionNamespace getVariable ["PO4_lastEncounterTime",MISSIONTIME]) - MISSIONTIME),"s"];
					};
				}] call MPSF_fnc_addEventHandler;

				["PO4_Server_onEncounterAttackRequest_EH","onEncounterAttackRequest",{
					params [["_requestor",objNull,[objNull]],["_position",[0,0,0],[[]]],["_force",false,[false]]];
					if (((missionNamespace getVariable ["PO4_lastEncounterTime",MISSIONTIME]) - MISSIONTIME) <= 0 || _force) then {
						missionNamespace setVariable ["PO4_lastEncounterTime",MISSIONTIME+100];
						publicVariable "PO4_lastEncounterTime";
						private _encounters = (["getTasksByID",[100]] call MPSF_fnc_getCfgTasks) select {(missionNamespace getVariable [format [TIMEVAR,_x],0]) < MISSIONTIME};
						if (count _encounters > 0) then {
							[selectRandom _encounters,_position] spawn MPSF_fnc_createCfgTask;
						};
					} else {
						systemChat str ["Too Early Time",((missionNamespace getVariable ["PO4_lastEncounterTime",MISSIONTIME]) - MISSIONTIME),"s"];
					};
				}] call MPSF_fnc_addEventHandler;

				["PO4_Server_onIntelAnalyse_EH","onIntelAnalyse",{
					params [["_target",objNull,[objNull]]];
					private _intelScore = ["getScore",[_target]] call MPSF_fnc_intel;
					private _operations = (["taskIDs"] call MPSF_fnc_getCfgTasks) select { (["CfgMissionTasks",_x,"typeID"] call MPSF_fnc_getCfgDataNumber) in OPERATIONIDS };
					_operations = _operations select { ["CfgMissionTasks",_x,"minIntelScore"] call MPSF_fnc_getCfgDataNumber <= _intelScore };
					private _existingTasks = ([] call MPSF_fnc_getCfgTaskModules) apply {_x getVariable ["CfgTaskID",""];};
					private _remainingOps = _operations select {!(_x in _existingTasks)};
					if (count _operations isEqualTo 0) exitWith {
						["onIntelAnalyseFailed",[_target],0] call MPSF_fnc_triggerEventHandler;
					};
					if (count (_remainingOps) == 0) then {
						_remainingOps =+ _operations;
					};
					systemChat str _remainingOps;
					if (count _remainingOps > 0) then {
						private _operation = selectRandom _remainingOps;
						private _taskLogic = [_operation] call MPSF_fnc_addCfgTask;
						private _intelCost = (missionNamespace getVariable [_operation,objNull]) getVariable ["taskScore",0];
						if !(_intelCost isEqualTo 0) then {
							["setScore",[_target,-1*_intelCost]] call MPSF_fnc_intel;
						};
						["onIntelAnalyseSuccess",[_target,_taskLogic],0] call MPSF_fnc_triggerEventHandler;
					} else {
						["onIntelAnalyseFailed",[_target],0] call MPSF_fnc_triggerEventHandler;
					};
				}] call MPSF_fnc_addEventHandler;
			} else {
				missionNamespace setVariable ["MPSF_Intel_Enabled",false];
				publicVariable "MPSF_Intel_Enabled";
			};

			/* ["PO4_Ambush_onTriggerIED_EH","onTriggerIED",{
				params [["_ied",objNull,[objNull]],["_size",0,[0]]];
				private _position = _ied call BIS_fnc_position;

			}] call MPSF_fnc_addEventHandler; */

			// Create/Activate Operation
			["PO4_onRequestOperation_EH","onRequestOperation",{
				params [["_target",objNull,[objNull]],["_taskData",[],[[]]]];
				if (isNull _target) exitWith {};
				_taskData params [["_taskID","",[""]],["_cfgTaskID","",[""]]];
				if (_taskID isEqualTo "") then {
					[_cfgTaskID] call MPSF_fnc_createCfgTask;
				} else {
					private _intelCost = (missionNamespace getVariable [_taskID,objNull]) getVariable ["taskScore",0];
					if !(_intelCost isEqualTo 0) then {
						["setScore",[_target,-1*_intelCost]] call MPSF_fnc_intel;
					};
					[[_taskID,_cfgTaskID]] call MPSF_fnc_createCfgTask;
				};
			}] call MPSF_fnc_addEventHandler;

			// Create Safezone Rings
			private _safeArea = ["MPSF_Param_BaseGriefProtection",0] call BIS_fnc_getParamValue;
			if (_safeArea isEqualTo 0) then {_safeArea = 200};
			{
				private _markerPos = _x;
				{
					_x params ["_markerID","_markerSize","_markerColor","_markerBrush","_markerAlpha"];
					[format["%1_%2",_markerID,_forEachIndex],_markerPos,0,"ELLIPSE",_markerBrush,_markerColor,_markerSize,"",_markerAlpha] call MPSF_fnc_createMarker;
				} forEach [
					["safeRing1",[_safeArea*1,_safeArea*1],"ColorBlack","SolidBorder",0.3]
					,["safeRing2",[_safeArea*1.25,_safeArea*1.25],"ColorBLUFOR","SolidBorder",0.3]
				];
			} forEach (([(["side","FactionTypeBLU"] call MPSF_fnc_getCfgFaction)] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x});
		};

		if (hasInterface) then {

			[] spawn PO4_fnc_introSequence;

			if (hasInterface) then {
				waitUntil { !(isNull player) };
			};

			[] spawn PO4_fnc_missionFlowPlayer;

			["PO4_initNewstarterUI_onIntroComplete_EH","onIntroComplete",{
				["initNewstarterUI"] call PO4_fnc_patrolops;
			}] call MPSF_fnc_addEventHandler;

			["PO4_Client_advhint_onIntelPickup_EH","onIntelPickup",{
				[["PatrolOps4","PO4BeginIntel"]] call BIS_fnc_advHint;
				[["PatrolOps4","PO4BeginIntel"],nil,nil,nil,nil,nil,true,nil,nil] call BIS_fnc_advHint;
			}] call MPSF_fnc_addEventHandler;

			["PO4_Client_onIntelAnalyseSuccess_EH","onIntelAnalyseSuccess",{
				params [["_target",objNull,[objNull]],["_taskLogic",objNull,[objNull]]];
				if (side _target isEqualTo side player) then {
					["PO4_NewOperation"] call BIS_fnc_showNotification;
				};
				if (_target isEqualTo player) then {
					private _ctrl = uiNamespace getVariable ["RscControlMissionConsoleIntelCompile",controlNull];
					_ctrl ctrlEnable false;
					_ctrl ctrlSetText "New Operations are Available";
					["updateAvailableIntelScore"] call PO4_fnc_missionConsoleUI;
					["updateActiveOpsListbox"] call PO4_fnc_missionConsoleUI;
					["updateAvailableOpsListbox"] call PO4_fnc_missionConsoleUI;
					["switchControlGroup",["MissionConsoleAvailableOps","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet;
				};
			}] call MPSF_fnc_addEventHandler;

			["PO4_Client_onIntelAnalyseFailed_EH","onIntelAnalyseFailed",{
				params [["_target",objNull,[objNull]]];
				if (_target isEqualTo player) then {
					private _ctrl = uiNamespace getVariable ["RscControlMissionConsoleIntelCompile",controlNull];
					_ctrl ctrlEnable false;
					_ctrl ctrlSetText "Insufficent Intel Gathered";
				};
			}] call MPSF_fnc_addEventHandler;

			[] spawn {
				sleep 0.1;
				// Briefing Notes for Patrol Ops
				["Diary","Diary","Conducting Operations"
					,format["<font size='16' face='PuristaLight'>Weapon Holstering</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>If you wish to holster your weapon, you can press the weapon selecter action for 1 second while holding that weapon to holster it.<br/><br/>%1<br/>%2<br/>%3"
					,format ["- Primary Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchPrimary",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchPrimary",1]}]
					,format ["- Handgun Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchHandgun",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchHandgun",1]}]
					,format ["- Secondary Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchSecondary",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchSecondary",1]}]
				]] call MPSF_fnc_createDiaryNote;

				// Briefing Notes for Patrol Ops
				["Diary","Diary","Gathering Intel"
					,format["<font size='16' face='PuristaLight'>Weapon Holstering</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>If you wish to holster your weapon, you can press the weapon selecter action for 1 second while holding that weapon to holster it.<br/><br/>%1<br/>%2<br/>%3"
					,format ["- Primary Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchPrimary",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchPrimary",1]}]
					,format ["- Handgun Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchHandgun",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchHandgun",1]}]
					,format ["- Secondary Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchSecondary",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchSecondary",1]}]
				]] call MPSF_fnc_createDiaryNote;

				// Briefing Notes for Patrol Ops
				["Diary","Diary","Conducting a Patrol"
					,format["<font size='16' face='PuristaLight'>Overview</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>If you wish to holster your weapon, you can press the weapon selecter action for 1 second while holding that weapon to holster it.<br/><br/>%1<br/>%2<br/>%3"
					,format ["- Primary Weapon: <font color='#ffC600'>%1</font>","Patrol Operations is a co-operative mission game mode for Bohemia Interactive Studio's ARMA Series designed on the Real Virtuality engine. The mission is set on various terrains and is configured for different sides with a diverse and randomly tasks."]
					,format ["- Handgun Weapon: <font color='#ffC600'>%1</font>","Patrol Ops allows players to work as a team to engage in scale-able tactical missions that are scaled in difficulty to the number of players connected. It is designed to randomise locations, enemy forces and scenarios to ensure players have a new and different experience every time the mission is played."]
				]] call MPSF_fnc_createDiaryNote;

				// Briefing Notes for Patrol Ops
				["Diary","Diary","Patrol Operations"
					,format["<font size='16' face='PuristaLight'>Overview</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>%1<br/><br/>%2<br/>%3"
					,format ["%1","Patrol Operations is a co-operative mission game mode for Bohemia Interactive Studio's ARMA Series designed on the Real Virtuality engine. The mission is set on various terrains and is configured for different sides with a diverse and randomly tasks."]
					,format ["%1","Patrol Ops allows players to work as a team to engage in scale-able tactical missions that are scaled in difficulty to the number of players connected. It is designed to randomise locations, enemy forces and scenarios to ensure players have a new and different experience every time the mission is played."]
				]] call MPSF_fnc_createDiaryNote;
			};
		};

		["PO4_Mission_startPlayer_EH","onPO4StartLeftBase",{ ["registerGroupStartPatrol",_this] call PO4_fnc_patrolops; }] call MPSF_fnc_addEventHandler;
	};
};