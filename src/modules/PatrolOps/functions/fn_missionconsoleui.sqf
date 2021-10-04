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
#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"
#define ICONNATO(natoIcon)	("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
#define ICONSELECTORM		"\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa"
#define ICONSELECTED		"\A3\ui_f\data\map\groupicons\selector_selected_ca.paa"
#define ICONPARACHUTE		"\A3\ui_f\data\Map\VehicleIcons\iconParachute_ca.paa"
#define ICONBADGE			"\A3\ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa"
#define ICONMOVEWARNING		"\A3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa"
#define ICONMOVE			"\A3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa"
#define OPERATIONIDS	[10,11,12,13,14,15,16,17,18,19]
#define TASKIDS			[20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99]
#define ENCOUNTERIDS	[100,101,102,103,104,105,106,107,108,109]
#define SAFEZONEAREA	(500 max worldsize min 500)

disableSerialization;

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "onLoad" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayMissionConsoleMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayMissionConsoleMenu"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["onUnload",["RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet;
		["blurBackground",["RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet;

		["setCrtlMenu",[
			 ["View Intel Options",{ ["switchControlGroup",["MissionConsoleIntel","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet; }]
			,["View Available Operations",{ ["switchControlGroup",["MissionConsoleAvailableOps","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet; }]
			,["View Active Operations",{ ["switchControlGroup",["MissionConsoleActiveOps","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet; }]
			,["View Player Scores",{ ["switchControlGroup",["","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet; }]
			,["",{}]
			,["View Map",{ ["switchControlGroup",["","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet; }]
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc1","F1: Intelligence"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc2","F2: Available Ops"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc3","F3: Active Ops"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4: Scores"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc5","F5:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc6","F6: View Map"]] call MPSF_fnc_itemAmrelTablet;

		onMapSingleClick "";
		["onMapDraw",["MissionConsoleMap"]] call PO4_fnc_missionConsoleUI;
		["centerMap",["MissionConsoleMap"]] call MPSF_fnc_itemAmrelTablet;
		["forceMapBackground",["MissionConsoleMap"]] call MPSF_fnc_itemAmrelTablet;
		["MissionConsoleMap",true] call MPSF_fnc_mapDrawSquadMarkers;
		["updateUIs"] call PO4_fnc_missionConsoleUI;
		["MPSF_MissionConsole_onTaskCreate_EH","onTaskCreate",{
			["updateUIs"] spawn {sleep 1; _this call PO4_fnc_missionConsoleUI;};
		}] call MPSF_fnc_addEventHandler;

		["hideControlGroup",["MissionConsoleIntelOrders"]] call MPSF_fnc_itemAmrelTablet;
		["switchControlGroup",["MissionConsoleIntel","RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet;

		true
	};
	case "onUnload" : {
		_params spawn {
			params [["_displayID","",[""]]];
			if (_displayID isEqualTo "") exitWith {};

			waitUntil{isNull (uiNamespace getVariable [_displayID,displayNull])};

			missionNamespace setVariable ["MPSF_Mission_var_IntelSelectedPosition",nil];
			missionNamespace setVariable ["MPSF_Mission_var_IntelSelectedPosition",nil];
			missionNamespace setVariable ["MPSF_MissionConsole_var_intelTaskParams",nil];
		};
	};/*
	case "onMapDraw" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]]];

		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (_ctrlMap isEqualTo controlNull) exitWith {["Unable to find respawn interface map"] call BIS_fnc_error;};

		_ctrlMap ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MPSF_FT_MAP_CURSORPOS",(_this select 0) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];}];
		_ctrlMap ctrlAddEventHandler ["MouseButtonClick",{ ['onMapClick',_this] call PO4_fnc_missionConsoleUI; }];

		_ctrlMap ctrlAddEventHandler ["Draw",{
			params ["_ctrlMap"];

			private _currentScreen = uiNamespace getVariable ["MPSF_Display_CurrentControlGroup",""];
			private _assignedItems = (assigneditems player apply {_x call BIS_fnc_itemType}) apply {toLower (_x select 1)};
			if !(count (["gps","uavterminal"] arrayIntersect _assignedItems) > 0 || (getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1) exitWith {};

			private _cursorPos = missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0,0]];
			private _curstorDistance = (60-(60/((ctrlMapScale _ctrlMap)*100))) max 10;
			private _cursorHover = false;
			private _colorDanger = ["IGUI","WARNING_RGB"] call BIS_fnc_displayColorGet;
			_colorDanger set [3, 1];

			private _zoom = (8 * 0.15) * 10^(abs log (ctrlMapScale _ctrlMap));
			private _size = 36 min _zoom;

			if (_currentScreen isEqualTo "MissionConsoleIntel") then {
				private _selectedTarget = missionNamespace getVariable ["MPSF_Mission_var_IntelSelectedPosition","NONE"];
				{					
					(["area",[_x]] call MPSF_fnc_getCfgMapData) params ["_areaID","_areaPos","_areaOrientation","_areaType","_areaSector","_areaBuildings"];
					switch (true) do {
						case (_areaID isEqualTo _selectedTarget) : {
							_ctrlMap drawIcon [ICONSELECTORM,[1,0.66,0,1],_areaPos,32,32,(diag_frameNo%360)*4,"",1,0.03,'PuristaMedium','right'];
							_ctrlMap drawIcon [ICONMOVE,[1,1,1,1],_areaPos,24,24,0,"",1,0.03,'PuristaMedium','right'];
						};
						case ({ alive _x && {side group _x == side group player} && {_x distance _areaPos <= 350} } count allUnits > 0) : {
						//	_ctrlMap drawicon [ICONSELECTED,_iconColour,_areaPos,30,30,0,"",1];
						//	_ctrlMap drawicon [ICONMOVEWARNING,_colorDanger,_areaPos,30,30,0,"",1];
						};
						default {
							private _alpha = 1-((_areaPos distance2D _cursorPos)/1000);
							private _iconColour = [1,1,1,_alpha];

							if (_cursorPos distance2D _areaPos < _curstorDistance && !_cursorHover) then {
								missionNamespace setVariable ["MPSF_Mission_var_IntelHighlightedPosition",_areaID];
								_cursorHover = true;
								_iconColour =+ _colorDanger;
							} else {
								if !(_cursorHover) then {
									missionNamespace setVariable ["MPSF_Mission_var_IntelHighlightedPosition",nil];
								};
							};

							_ctrlMap drawicon ["\a3\ui_f\data\Map\Markers\Military\unknown_CA.paa",_iconColour,_areaPos,30,30,0,"",1];
							if ((getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1) then {
								_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",_iconColour,_areaPos,24,24,0,_areaID,1,0.03,'PuristaMedium','right'];
							};
						};
					};
				} forEach (["getNearbyAreas",[_cursorPos,["Town","Village","City","Farm"],1500]] call MPSF_fnc_getCfgMapData);
			};

			//systemChat str [diag_frameNo,_size,_zoom];
		}];
	};
	case "onMapClick" : {
		_params params ["_ctrlMap", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

		["hideControlGroup",["MissionConsoleIntelOrders"]] call MPSF_fnc_itemAmrelTablet;

		if (_button == 1) exitWith {
			missionNamespace setVariable ["MPSF_Mission_var_IntelSelectedPosition",nil];
		};

		private _cursorPos = missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0,0]];
		private _areaID = missionNamespace getVariable ["MPSF_Mission_var_IntelHighlightedPosition",""];

		switch (true) do {
			case !(_areaID isEqualTo "") : {
				missionNamespace setVariable ["MPSF_Mission_var_IntelSelectedPosition",_areaID];
				["onSelectIntelTask",[_areaID]] call PO4_fnc_missionConsoleUI;
				_ctrlMap ctrlMapAnimAdd [0.125,0.04 min (ctrlMapScale _ctrlMap),_cursorPos];
				ctrlMapAnimCommit _ctrlMap;
			};
		};
	};*/
	case "onSelectIntelTask" : {
		_params params [["_area","",[""]]];

		private _ctrlTask = uiNamespace getVariable ["RscControlMissionConsoleIntelOrdersTaskText",controlNull];
		private _ctrlButton = uiNamespace getVariable ["RscControlMissionConsoleIntelOrdersButton",controlNull];

		["showControlGroup",["MissionConsoleIntelOrders"]] call MPSF_fnc_itemAmrelTablet;

		(["area",[_area]] call MPSF_fnc_getCfgMapData) params ["_areaID","_areaPos","_areaOrientation","_areaType","_areaSector","_areaBuildings"];

		private _taskParams = switch (toLower _areaType) do {
			case "city" : {[40,"Send orders to secure the area after a suspicious report",_areaID]};
			case "town" : {[41,"Send orders to speak with locals about any intel they have",_areaID]};
			case "village" : {[42,"Send orders to conduct a patrol of the local area.",_areaID]};
			default {[]};
		};

		if (_taskParams isEqualTo []) exitWith {
			["setCtrlAction",[_ctrlButton,"MouseButtonClick",{}]] call MPSF_fnc_itemAmrelTablet;
			_ctrlButton ctrlEnable false;
		};

		missionNamespace setVariable ["MPSF_MissionConsole_var_intelTaskParams",_taskParams];

		_ctrlTask ctrlSetStructuredText parseText format ["<t font='PuristaMedium' size='1' shadow='0'>%1</t>",_taskParams select 1];

		["setCtrlAction",[_ctrlButton,"MouseButtonClick",{
			private _taskParams = missionNamespace getVariable ["MPSF_MissionConsole_var_intelTaskParams",[]];
			if !(_taskParams isEqualTo []) then {
				["onPO4IntelTaskRequest",_taskParams,2] call MPSF_fnc_triggerEventhandler;
			};
		}]] call MPSF_fnc_itemAmrelTablet;

		_ctrlButton ctrlEnable true;
	};
	case "updateUIs" : {
		["updateAvailableIntelScore"] call PO4_fnc_missionConsoleUI;
		["updateActiveOpsListbox"] call PO4_fnc_missionConsoleUI;
		["updateAvailableOpsListbox"] call PO4_fnc_missionConsoleUI;
	};
	case "updateAvailableIntelScore" : {
		["setCtrlText",["RscControlMissionConsoleIntelCount",format ["<t size='4' shadow='0' align='center'>%1</t>",["getScore",[player]] call MPSF_fnc_intel],"","StructuredText"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlMissionConsoleOPsCount",format ["<t size='1.1' shadow='0' align='center'>%1 Ops Available</t>",count ([nil,false] call MPSF_Fnc_getCfgTaskModules)],"","StructuredText"]] call MPSF_fnc_itemAmrelTablet;
		
		["setCtrlAction",["RscControlMissionConsoleIntelCompile","MouseButtonClick",{
			["onIntelAnalyse",[player],2] call MPSF_fnc_triggerEventHandler
		}]] call MPSF_fnc_itemAmrelTablet;
	};
	case "updateAvailableOpsListbox" : {
		private _ctrl = uiNamespace getVariable ["RscControlMissionConsoleAvailableOpsList",controlNull];
		if (isNull _ctrl) exitWith {};

		private _operations = ([nil,false] call MPSF_Fnc_getCfgTaskModules) apply {
			[
				_x getVariable ["cfgTaskID",""]
				,_x getVariable ["taskID",""]
				,_x getVariable ["taskTitle",""]
				,_x getVariable ["taskDesc",""]
				,_x getVariable ["taskScore",1]
			]
		};

		lbClear _ctrl;
		_ctrl ctrlsetfontheight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
		if (count (_operations select {!(_x select 2 isEqualTo "")}) > 0) then {
			private _currentIntelScore = ["getScore",[player]] call MPSF_fnc_intel;
			{
				_x params ["_cfgTaskID","_taskID","_taskTitle","_taskDesc","_taskIntel"];
				if !(_taskTitle isEqualTo "") then {
					private _icon = [(["TaskDetails",[_taskID,"iconType"]] call MPSF_fnc_getCfgTasks)] call MPSF_fnc_getCfgText;
					private _icon2 = [(["TaskDetails",[_taskID,"iconType2"]] call MPSF_fnc_getCfgTasks)] call MPSF_fnc_getCfgText;
					// List Record
					private _lbAdd = _ctrl lbadd _taskTitle;
					_ctrl lbsetpicture [_lbAdd,_icon];
					_ctrl lbSetTextRight [_lbAdd,str _taskIntel];
					_ctrl lbsetpictureright [_lbAdd,_icon2];
					if (_currentIntelScore >= _taskIntel || (getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1) then {
						_ctrl lbSetData [_lbAdd,str [_taskID,_cfgTaskID]];
					} else {
						_ctrl lbSetColor [_lbAdd, [0.7,0.7,0.7,0.7]];
						_ctrl lbSetColorRight [_lbAdd, [1,0.7,0,1]];
						_ctrl lbSetPictureColor [_lbAdd, [0.7,0.7,0.7,0.7]];
					};

					private _tooltip = ["summary",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
					_ctrl lbSetValue [_lbAdd,_forEachIndex];
					_ctrl lbSetTooltip [_lbAdd,format ["%1 - %2",_taskTitle,if (_taskIntel > 0) then {format["%2 (INTEL:%1)",_taskIntel,_tooltip]} else {_tooltip}]];
				};
			} forEach _operations;
		}else {
			private _icon = ["Intel"] call MPSF_fnc_getCfgText;
			private _lbAdd = _ctrl lbadd "No Operations Available";
			_ctrl lbSetTooltip [_lbAdd,"Retrieve Intel to Unlock Operations"];
			_ctrl lbsetpicture [_lbAdd,_icon];
			_ctrl lbsetpictureright [_lbAdd,_icon];
		};
		lbsort _ctrl;

		["setCtrlAction",[_ctrl,"LBDblClick",{
			params [["_ctrl",controlNull,[controlNull,""]],["_index",-1,[0]]];
			if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
			if (isNull _ctrl) exitWith {["No Control Found for Operation Selection"] call BIS_fnc_error; false;};
			private _lbdata = call compile (_ctrl lbData _index);
			["onRequestOperation",[player,_lbdata],2] call MPSF_fnc_triggerEventhandler;
		}]] call MPSF_fnc_itemAmrelTablet;
	};
	case "updateActiveOpsListbox" : {
		private _ctrl = uiNamespace getVariable ["RscControlMissionConsoleActiveOpsList",controlNull];
		if (isNull _ctrl) exitWith {};

		private _operations = ([nil,true] call MPSF_Fnc_getCfgTaskModules) apply {
			[
				_x getVariable ["cfgTaskID",""]
				,_x getVariable ["taskID",""]
				,_x getVariable ["taskTitle",""]
				,_x getVariable ["taskDesc",""]
				,_x getVariable ["taskScore",1]
			]
		};

		private _currentIntelScore = ["getScore",[player]] call MPSF_fnc_intel;

		lbClear _ctrl;
		_ctrl ctrlsetfontheight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
		if (count (_operations select {!(_x select 2 isEqualTo "")}) > 0) then {
			{
				_x params ["_cfgTaskID","_taskID","_taskTitle","_taskDesc","_taskIntel"];
				if !(_taskTitle isEqualTo "") then {
					private _icon = [(["TaskDetails",[_taskID,"iconType"]] call MPSF_fnc_getCfgTasks)] call MPSF_fnc_getCfgText;
					private _icon2 = [(["TaskDetails",[_taskID,"iconType2"]] call MPSF_fnc_getCfgTasks)] call MPSF_fnc_getCfgText;
					// List Record
					private _lbAdd = _ctrl lbadd _taskTitle;
					_ctrl lbsetpicture [_lbAdd,_icon];
					_ctrl lbSetTextRight [_lbAdd,str _taskIntel];
					_ctrl lbsetpictureright [_lbAdd,_icon2];
					if (_currentIntelScore >= _taskIntel || (getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1) then {
						_ctrl lbSetData [_lbAdd,str [_taskID,_cfgTaskID]];
					} else {
						_ctrl lbSetColor [_lbAdd, [0.7,0.7,0.7,0.7]];
						_ctrl lbSetColorRight [_lbAdd, [1,0.7,0,1]];
						_ctrl lbSetPictureColor [_lbAdd, [0.7,0.7,0.7,0.7]];
					};
					_ctrl lbSetValue [_lbAdd,_forEachIndex];
					_ctrl lbSetTooltip [_lbAdd,format ["%1%2",_taskTitle,if (_taskIntel > 0) then {format[" (INTEL:%1)",_taskIntel]} else {""}]];
				};
			} forEach _operations;
		}else {
			private _icon = ["Intel"] call MPSF_fnc_getCfgText;
			private _lbAdd = _ctrl lbadd "No Operations Underway";
			_ctrl lbsetpicture [_lbAdd,_icon];
			_ctrl lbsetpictureright [_lbAdd,_icon];
		};
		lbsort _ctrl;

		["setCtrlAction",[_ctrl,"MouseButtonClick",{
			params [["_ctrl",controlNull,[controlNull,""]],["_index",-1,[0]]];
			if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
			if (isNull _ctrl) exitWith {["No Control Found for Operation Selection"] call BIS_fnc_error; false;};
			private _lbdata = call compile (_ctrl lbData (lbcursel _ctrl));
			private _childTasks = [_lbData select 0] call BIS_fnc_taskChildren;
			_childTasks = _childTasks apply {
				(missionNamespace getVariable [_x,objNull]) getVariable ["position",[]];
			};
			["centerMap",["MissionConsoleMap",_childTasks]] call MPSF_fnc_itemAmrelTablet;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",[_ctrl,"LBDblClick",{
			params [["_ctrl",controlNull,[controlNull,""]],["_index",-1,[0]]];
			if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
			if (isNull _ctrl) exitWith {["No Control Found for Operation Selection"] call BIS_fnc_error; false;};
			private _lbdata = call compile (_ctrl lbData _index);
			//["onRequestOperation",_lbdata,2] call MPSF_fnc_triggerEventhandler;
		}]] call MPSF_fnc_itemAmrelTablet;
	};
	case "onCtrlClick" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_index",-1,[0]]];


	};
};