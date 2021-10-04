/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-05
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"
#define ICONNATO(natoIcon) ("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
#define GRIDSIZE 8

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
/* UI */
	case "onLoadForceTrackMenu" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayAmrelTabletMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayAmrelTabletForceTrack"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["blurBackground",["RscDisplayAmrelTabletMenu"]] call MPSF_fnc_itemAmrelTablet;

		["setCrtlMenu",[
			["Overview",{ ["switchControlGroup",["AmrelTabletForceTrackOverview","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet; }]
			,["Groups",{ ["switchControlGroup",["AmrelTabletForceTrackGroups","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet; }]
			,["Reports",{ ["switchControlGroup",["AmrelTabletForceTrackReports","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet; }]
			,["Intelligence",{ ["switchControlGroup",["","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet; }]
			,["Live Feeds",{ ["switchControlGroup",["","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet; }]
			,["Map",{ ["switchControlGroup",["","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet; }]
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc1","F1: Overview"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc2","F2: Edit Groups"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc3","F3: Contact Reports"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4: "]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc5","F5: "]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc6","F6: "]] call MPSF_fnc_itemAmrelTablet;

		["setForceTrackMapDraw",["AmrelTabletForceTrackMap"]] call MPSF_fnc_forcetracker;
		["forceMapBackground",["AmrelTabletForceTrackMap"]] call MPSF_fnc_itemAmrelTablet;
		["updateForceTrackMap",["AmrelTabletForceTrackMap"]] call MPSF_fnc_forcetracker;

		["updateForceTrackReportOptionsSide"] call MPSF_fnc_forcetracker;

		private _ctrlMap = uiNamespace getVariable ["AmrelTabletForceTrackMap",controlNull];
		_ctrlMap ctrlAddEventHandler ["Draw",{false;}];
		_ctrlMap ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MPSF_FT_MAP_CURSORPOS",(_this select 0) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];}];
		_ctrlMap ctrlAddEventHandler ["MouseButtonClick",{ ['onMapClickForceTrack',_this] call MPSF_fnc_forcetracker; true; }];

		private _ctrlReportsDirSlider = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsDirSlider",controlNull];
		_ctrlReportsDirSlider sliderSetRange [0,360];
		_ctrlReportsDirSlider sliderSetSpeed [10,10];
		["updateForceTrackReportsDirSlider",[_ctrlReportsDirSlider,0]] call MPSF_fnc_forcetracker;
		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsDirSlider","SliderPosChanged",{
			["updateForceTrackReportLogic"] call MPSF_fnc_forcetracker;
			["updateForceTrackReportsDirSlider",_this] call MPSF_fnc_forcetracker;
		}]] call MPSF_fnc_itemAmrelTablet;

		private _ctrlReportsExpirySlider = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsExpirySlider",controlNull];
		_ctrlReportsExpirySlider sliderSetRange [10,120];
		_ctrlReportsExpirySlider sliderSetSpeed [10,10];
		["updateForceTrackReportsExpirySlider",[_ctrlReportsExpirySlider,20]] call MPSF_fnc_forcetracker;
		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsExpirySlider","SliderPosChanged",{
			["updateForceTrackReportLogic"] call MPSF_fnc_forcetracker;
			["updateForceTrackReportsExpirySlider",_this] call MPSF_fnc_forcetracker;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsUpdateButton","MouseButtonClick",{
			["updateForceTrackReportLogic",[true]] call MPSF_fnc_forcetracker;
			systemChat "Report Broadcasted";
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsDeleteButton","MouseButtonClick",{
			["hideControlGroup",["AmrelTabletForceTrackReportsMenu"]] call MPSF_fnc_itemAmrelTablet;
			private _logic = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackReportLogic",objNull];
			if (isNull _logic) exitWith {};
			deleteVehicle _logic;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletForceTrackGroupsUpdateButton","MouseButtonClick",{
			["updateForceTrackGroups"] call MPSF_fnc_forcetracker;
			systemChat "Squad Updated";
		}]] call MPSF_fnc_itemAmrelTablet;

		["switchControlGroup",["AmrelTabletForceTrackOverview","RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet;

		["updateForceTrackGroupsLeader",[group player]] call MPSF_fnc_forcetracker;
		["updateForceTrackGroupsType",[group player]] call MPSF_fnc_forcetracker;

		["hideControlGroup",["AmrelTabletForceTrackReportsMenu"]] call MPSF_fnc_itemAmrelTablet;
		["hideControlGroup",["AmrelTabletForceTrackGroupsMenu"]] call MPSF_fnc_itemAmrelTablet;

		true
	};
	case "setForceTrackMapDraw" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]]];

		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (_ctrlMap isEqualTo controlNull) exitWith {};

		missionNamespace setVariable ["MPSF_ForceTracker_Devices",(["CfgForcetracker","requiredDevices"] call MPSF_fnc_getCfgDataArray)];

		_ctrlMap ctrlAddEventHandler ["Draw",{
			params ["_ctrlMap"];

			//if (diag_fpsMin < 20) exitWith {};

			private _devices = missionNamespace getVariable ["MPSF_ForceTracker_Devices",[]];
			private _currentScreen = uiNamespace getVariable ["MPSF_Display_CurrentControlGroup",""];
			private _assignedItems = (assigneditems player apply {_x call BIS_fnc_itemType}) apply {toLower (_x select 1)};
			if !(count (_devices arrayIntersect _assignedItems) > 0 || count _devices == 0 || (getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1) exitWith {};

			private _cursorPos = ["getForceTrackCursorGroup"] call MPSF_fnc_forcetracker;
			private _curstorDistance = (60-(60/((ctrlMapScale _ctrlMap)*100))) max 10;
			private _cursorHover = false;
			private _cursorHoverLogic = false;

			private _zoom = (8 * 0.15) * 10^(abs log (ctrlMapScale _ctrlMap));
			private _size = 36 min _zoom;

			if (_size >= 30) then {
				_ctrlMap drawRectangle [[worldSize/2,worldSize/2,0],worldSize/2,worldSize/2,0,[1,1,1,0.42],"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"];
			};

			{
				if !(_x getVariable ["hideGroupIcon",false]) then {
					private _group = _x;
					private _leader = leader _group;
					private _mapPosition = _group getVariable ["forceTrackPos",[_group] call MPSF_fnc_getDispersionCentre];
					private _iconType = _group getVariable ["natoIconPath",[vehicle _leader] call MPSF_fnc_getCfgIconNATO];
					private _iconSize = [count units _group] call MPSF_fnc_getCfgIconNATOSize;
					private _iconColour = (configfile >> "CfgMarkerColors" >> ([[_leader] call BIS_fnc_objectSide,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;

					if (_cursorPos distance2D _mapPosition < _curstorDistance && !_cursorHover) then {
						missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedGroup",_group];
						_cursorHover = true;
						_iconColour = [1,1,1,0.8];
					} else {
						if !(_cursorHover) then {
							missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedGroup",grpNull];
						};
					};

					private _groupID = (groupID _group) splitString " ";
					private _groupSide = _groupID deleteAt 0;
					private _groupName = _groupID joinString " ";

					if (_size >= 30) then {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],_mapPosition,_size,_size,0,format ["%1 ",_groupSide],2,(_size/1000),"PuristaLight",'left'];
						_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],_mapPosition,_size,_size,0,format [" %1",_groupName],2,(_size/1000),"PuristaLight",'right'];
					};
					_ctrlMap drawIcon [_iconSize,_iconColour,_mapPosition,30*1.1,30*1.1,0,"",0,0.05,"PuristaLight",'center'];
					_ctrlMap drawIcon [_iconType,_iconColour,_mapPosition,30,30,0,"",0,0.05,"PuristaLight",'center'];
					/* if (_zoom >= 120 && _group isEqualTo group player) then {
						{
							private _unit = _x;
							private _icon = [_unit,"icon"] call MPSF_fnc_getCfgText;
							_ctrlMap drawIcon [_icon,_iconColour,getPosVisual _unit,_size,_size,getDir _unit,"",0,0.05,"PuristaLight",'center'];
						} forEach (units _group);
					}; */
				};
			} forEach (allGroups select {[side _x,side group player] call BIS_fnc_areFriendly && !(side _x isEqualTo civilian)});

			{
				private _iconType = ([_x getVariable ["ForceTrackType","o_unknown"],"texture"] call MPSF_fnc_getCfgText);
				private _iconColour = _x getVariable ["ForceTrackColour",[1,1,1,1]];
				private _iconComment = _x getVariable ["ForceTrackComment",""];
				private _iconDirection = _x getVariable ["ForceTrackDir",-1];
				private _iconTime = _x getVariable ["ForceTrackTime",-1];
				
				if (_currentScreen isEqualTo "AmrelTabletForceTrackReports") then {
					if (_cursorPos distance2D _x < _curstorDistance && !_cursorHoverLogic) then {
						missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedLogic",_x];
						_cursorHoverLogic = true;
						_iconColour = [1,1,1,0.8];
					} else {
						if !(_cursorHoverLogic) then {
							missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedLogic",objNull];
						};
					};
				} else {
					missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedLogic",objNull];
				};

				_ctrlMap drawIcon [_iconType,_iconColour,position _x,30,30,0,"",0,0.05,"PuristaLight",'center'];
				if (_size >= 30) then {
					if (_iconDirection >= 0) then {
						_ctrlMap drawIcon ["\A3\ui_f\data\map\markers\military\arrow_CA.paa",_iconColour,(position _x) getPos [1500*(ctrlMapScale _ctrlMap),_iconDirection],_size,_size,_iconDirection,"",0,0.05,"PuristaLight",'center'];
					};
					if !(_iconComment isEqualTo "") then {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],position _x,_size,_size,0,format [" %1",_iconComment],2,(_size/1000),"PuristaLight",'right'];
					};
					if !(_x getVariable ["ForceTrackCommitted",false]) then {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],position _x,_size,_size,0,format ["Pending: "],2,(_size/1000),"PuristaLight",'left'];
					} else {
						_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],position _x,_size,_size,0,format ["%1",[_iconTime,"HH:MM"] call BIS_fnc_timeToString],2,(_size/1000),"PuristaLight",'left'];
					};
				};
			} forEach (entities "Logic" select {_x getVariable ["MPSF_ForceTrack_Report_F",false]});

			private _iconColour = (configfile >> "CfgMarkerColors" >> ([[player] call BIS_fnc_objectSide,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;
			{
				_x params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];
				private _drawIcon = [player,true,"installation"] call MPSF_fnc_getCfgIconNATO;
				private _drawPos = _target call BIS_fnc_position;
				if (_displayName isEqualTo "") then { _displayName = format ["#%1",mapGridPosition _drawPos]; };
				if (_size >= 24) then {
					_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,0.8],_drawPos,_size,_size,0,format[" %1",_displayName],2,(_size/1000),'PuristaMedium','right'];
				};
				_ctrlMap drawIcon [_drawIcon,_iconColour,_drawPos,30,30,0,"",0,0.05,"PuristaLight",'center'];
			} forEach (["getRespawnPositions",[player]] call MPSF_fnc_respawnMP);
		}];
	};
	case "updateForceTrackMap" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]],["_position",getPos player,[[],"",objNull]],["_time",0,[0]]];
		
		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (_ctrlMap isEqualTo controlNull) exitWith { false };

		_ctrlMap ctrlMapAnimAdd [_time,0.04 min (ctrlMapScale _ctrlMap),_position];
		ctrlMapAnimCommit _ctrlMap;

		true;
	};
	case "updateForceTrackReportOptionsSide" : {
		_params params [["_curSel",4,[0]]];

		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsColourListCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsColourListCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_text","_side","_icon"];
			private _iconColour = (configfile >> "CfgMarkerColors" >> ([_side,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;
			_ctrl lbAdd format["%1",_text];
			_ctrl lbSetPicture [_foreachindex,format["\a3\ui_f\data\Map\Markers\NATO\%1.paa",_icon]];
			_ctrl lbSetPictureColor [_foreachindex,_iconColour];
			//_ctrl lbSetTooltip [_foreachindex,format["%1 (%2)",getText (_cfgx >> "displayName"),_vehicles]];
			_ctrl lbSetData [_foreachindex,str (_side call BIS_fnc_sideID)];
		} forEach [
			["OPFOR",East,"O_Unknown"],
			["BLUFOR",West,"B_Unknown"],
			["INDFOR",Independent,"N_Unknown"],
			["Civilian",Civilian,"N_Unknown"],
			["Unknown",sideUnknown,"N_Unknown"]
		];
		_ctrl lbSetCurSel _curSel;

		["updateForceTrackReportOptionsType",[4]] call MPSF_fnc_forcetracker;

		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsColourListCombo","LBSelChanged",{
			params [["_ctrlList",controlNull,[controlNull]]];

			private _cursel = lbcursel _ctrlList;
			if (_cursel < 0) exitwith {};

			private _lbData = call compile (_ctrlList lbData _cursel);
			["updateForceTrackReportOptionsType",[_lbData]] call MPSF_fnc_forcetracker;
			["updateForceTrackReportLogic"] call MPSF_fnc_forcetracker;
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "updateForceTrackReportOptionsType" : {
		_params params [["_sideID",-1,[0]],["_curSel",0,[0]]];

		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsTypeListCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsTypeListCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		private _cfgMarkers = "isClass _x && getText(_x >> 'markerClass') in ['NATO_BLUFOR','NATO_Civilian','NATO_Independent','NATO_OPFOR']" configClasses (configFile >> "CfgMarkers");
		if (_sideID in [0,1,2,3]) then {
			_cfgMarkers = _cfgMarkers select {['NATO_OPFOR','NATO_BLUFOR','NATO_Independent','NATO_Civilian'] find getText(_x >> 'markerClass') == _sideID};
		};

		lbClear _ctrl;
		{
			_ctrl lbAdd getText (_x >> "Name");
			_ctrl lbSetPicture [_forEachIndex,getText (_x >> "texture")];
			_ctrl lbSetTooltip [_forEachIndex,getText (_x >> "Name")];
			_ctrl lbSetData [_forEachIndex,configName _x];
			private _iconColour = (configfile >> "CfgMarkerColors" >> ([_sideID,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;
			_ctrl lbSetPictureColor [_foreachindex,_iconColour];
		} forEach _cfgMarkers;
		_ctrl lbSetCurSel _curSel;

		["setCtrlAction",["RscControlAmrelTabletForceTrackReportsTypeListCombo","LBSelChanged",{
			["updateForceTrackReportLogic"] call MPSF_fnc_forcetracker;
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "updateForceTrackReportsDirSlider" : {
		_params params ["_ctrlSlider","_value"];
		private _ctrlText = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsDirText",controlNull];
		//_value = _value - _value%10;
		_ctrlSlider sliderSetPosition _value;
		_ctrlText ctrlSetText format["Direction: %1",if (_value == 0) then {"None"} else {format["%1 Degrees",(round _value) % 360]}];
		_value
	};
	case "updateForceTrackReportsExpirySlider" : {
		_params params ["_ctrlSlider","_value"];
		private _ctrlText = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsExpiryText",controlNull];
		_value = _value - _value%10;
		_ctrlSlider sliderSetPosition _value;
		_ctrlText ctrlSetText format["Expires in: %1",if (_value == 120) then {"Never"} else {format["%1 mins",_value]}];
		_value
	};
	case "updateForceTrackReportLogic" : {
		_params params [["_public",false,[false]]];
		private _logic = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackReportLogic",objNull];
		if (isNull _logic) exitWith {};

		private _ctrlColour = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsColourListCombo",controlNull];
		private _lbData = call compile (_ctrlColour lbData (lbCurSel _ctrlColour));
		private _iconColour = (configfile >> "CfgMarkerColors" >> ([_lbData,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;
		_logic setVariable ["ForceTrackColourID",lbCurSel _ctrlColour,_public];
		_logic setVariable ["ForceTrackColour",_iconColour,_public];

		private _ctrlType = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsTypeListCombo",controlNull];
		_logic setVariable ["ForceTrackTypeID",lbCurSel _ctrlType,_public];
		_logic setVariable ["ForceTrackType",_ctrlType lbData (lbCurSel _ctrlType),_public];

		private _ctrlDirection = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsDirSlider",controlNull];
		_logic setDir (sliderPosition _ctrlDirection - 1);
		_logic setVariable ["ForceTrackDir",sliderPosition _ctrlDirection - 1,_public];

		private _ctrlExpiry = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsExpirySlider",controlNull];
		_logic setVariable ["ForceTrackExpiry",time + (sliderPosition _ctrlExpiry),_public];
		_logic setVariable ["ForceTrackTime",daytime,_public];

		private _ctrlComment = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsCommentEdit",controlNull];
		_logic setVariable ["ForceTrackComment",ctrlText _ctrlComment,_public];

		_logic setVariable ["ForceTrackCommitted",_public,_public];

		true;
	};
	case "createForceTrackReportsNew" : {
		["updateForceTrackReportOptionsSide"] call MPSF_fnc_forcetracker;
		["updateForceTrackReportOptionsType",[4]] call MPSF_fnc_forcetracker;

		private _ctrlReportsDirSlider = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsDirSlider",controlNull];
		["updateForceTrackReportsDirSlider",[_ctrlReportsDirSlider,0]] call MPSF_fnc_forcetracker;

		private _ctrlReportsExpirySlider = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsExpirySlider",controlNull];
		["updateForceTrackReportsExpirySlider",[_ctrlReportsExpirySlider,20]] call MPSF_fnc_forcetracker;

		["updateForceTrackMap",["AmrelTabletForceTrackMap",missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0]],0.125]] call MPSF_fnc_forcetracker;

		["setCtrlText",["RscControlAmrelTabletForceTrackReportsCommentEdit",""]] call MPSF_fnc_itemAmrelTablet;

		["showControlGroup",["AmrelTabletForceTrackReportsMenu"]] call MPSF_fnc_itemAmrelTablet;

		private _logic = [missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0]],0] call MPSF_fnc_createLogic;
		_logic setVariable ["MPSF_ForceTrack_Report_F",true,true];
		_logic setVariable ["MPSF_ForceTrack_Confirmed",false,false];
		missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackReportLogic",_logic];

		_logic;
	};
	case "createForceTrackReportsUpdate" : {
		private _logic = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackReportLogic",objNull];
		if (isNull _logic) exitWith {};

		["updateForceTrackReportOptionsSide",[
			_logic getVariable ["ForceTrackColourID",0]
		]] call MPSF_fnc_itemAmrelTablet;

		["updateForceTrackReportOptionsType",[
			_logic getVariable ["ForceTrackColourID",0],
			_logic getVariable ["ForceTrackTypeID",0]
		]] call MPSF_fnc_itemAmrelTablet;

		private _ctrlReportsDirSlider = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsDirSlider",controlNull];
		["updateForceTrackReportsDirSlider",[_ctrlReportsDirSlider,
			_logic getVariable ["ForceTrackDir",0]
		]] call MPSF_fnc_itemAmrelTablet;

		private _ctrlReportsExpirySlider = uiNamespace getVariable ["RscControlAmrelTabletForceTrackReportsExpirySlider",controlNull];
		["updateForceTrackReportsExpirySlider",[_ctrlReportsExpirySlider,
			10 max (time - (_logic getVariable ["ForceTrackExpiry",0]))
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletForceTrackReportsCommentEdit",_logic getVariable ["ForceTrackComment",""]]] call MPSF_fnc_itemAmrelTablet;

		["updateForceTrackMap",["AmrelTabletForceTrackMap",missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0]],0.125]] call MPSF_fnc_forcetracker;

		["showControlGroup",["AmrelTabletForceTrackReportsMenu"]] call MPSF_fnc_itemAmrelTablet;

		_logic;
	};
	case "openForceTrackGroup" : {
		_params params [["_groupID",grpNull,[grpNull]]];
		["updateForceTrackGroupsLeader",[_groupID]] call MPSF_fnc_forcetracker;
		["updateForceTrackGroupsType",[_groupID]] call MPSF_fnc_forcetracker;
		["updateForceTrackGroupsName",[_groupID]] call MPSF_fnc_forcetracker;
		["showControlGroup",["AmrelTabletForceTrackGroupsMenu"]] call MPSF_fnc_itemAmrelTablet;
	};
	case "updateForceTrackGroupsLeader" : {
		_params params [["_group",grpNull,[grpNull]],["_curSel",0,[0]]];

		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletForceTrackGroupsLeaderListCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletForceTrackGroupsLeaderListCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		private _curSel = 0;
		{
			private _name 				= format ["%1. %2 (%3)",[_x,"displayNameShort"] call BIS_fnc_rankParams,[_x] call BIS_fnc_getName,["getUnitRole",[_x]] call MPSF_fnc_squads];
			private _textureIcon		= ["GetPlayerIcon", [_x]] call DISPLAY;
			private _textureRank		= "a3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";
			private _isGroupLeader		= _x == leader group _x;
			private _texture 			= if (_isGroupLeader && ["IsGroupRegistered", [group _x]] call GROUPS) then { _textureRank } else { _textureIcon };
			private _sameGroup			= group player == group _x;
			private _isDead				= !alive _x;
			private _isIncapacitated	= alive _x && _x getVariable ["BIS_revive_incapacitated", false];
			private _color = switch (true) do {
				case (_isDead) : 		{ COLOR_DEAD };
				case (_isIncapacitated) : 	{ COLOR_INCAPACITATED };
				case (player == _x) : 		{ COLOR_SELF };
				case (_sameGroup) : 		{ COLOR_GROUP };
				default {COLOR_GROUP};
			};

			if (_isDead) then {
				_name = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
				_texture = ICON_KIA;
			} else {
				if (_isIncapacitated) then { _texture = ICON_REVIVE; };
			};

			_ctrl lbAdd _name;
			_ctrl lbSetData [_forEachIndex, _x call BIS_fnc_netId];
			_ctrl lbSetPicture [_forEachIndex, _texture];
			_ctrl lbSetColor [_forEachIndex, [1,1,1,1]];
			_ctrl lbSetPictureColor [_forEachIndex, _color];
			_ctrl lbSetPictureColorSelected [_forEachIndex, _color];

			if (_x == leader group _x) then { _curSel = _forEachIndex; };
		} forEach (units _group);
		_ctrl lbSetCurSel _curSel;
		
		["setCtrlAction",["RscControlAmrelTabletForceTrackGroupsLeaderListCombo","LBSelChanged",{
			params [["_ctrlList",controlNull,[controlNull]]];
			private _cursel = lbcursel _ctrlList;
			if (_cursel < 0) exitwith {};
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackGroupLeader",(_ctrlList lbData _cursel) call BIS_fnc_objectFromNetId]
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "updateForceTrackGroupsType" : {
		_params params [["_group",grpNull,[grpNull]],["_curSel",0,[0]]];

		private _sideID = (side _group) call BIS_fnc_sideID;
		private _currType = _group getVariable ["natoIcon",[vehicle leader _group,false] call MPSF_fnc_getCfgIconNATO];

		private _cfgMarkers = "isClass _x && getText(_x >> 'markerClass') in ['NATO_BLUFOR','NATO_Civilian','NATO_Independent','NATO_OPFOR']" configClasses (configFile >> "CfgMarkers");
		if (_sideID in [0,1,2,3]) then {
			_cfgMarkers = _cfgMarkers select {['NATO_OPFOR','NATO_BLUFOR','NATO_Independent','NATO_Civilian'] find getText(_x >> 'markerClass') == _sideID};
		};

		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletForceTrackGroupsTypeListCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletForceTrackGroupsTypeListCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_ctrl lbAdd getText (_x >> "Name");
			_ctrl lbSetPicture [_forEachIndex,getText (_x >> "texture")];
			_ctrl lbSetTooltip [_forEachIndex,getText (_x >> "Name")];
			_ctrl lbSetData [_forEachIndex,configName _x];
			private _iconColour = (configfile >> "CfgMarkerColors" >> ([_sideID,true] call BIS_fnc_sideColor) >> "color") call BIS_fnc_colorConfigToRGBA;
			_ctrl lbSetPictureColor [_foreachindex,_iconColour];
			if ((configName _x) isEqualTo _currType) then {_curSel = _forEachIndex;};
		} forEach _cfgMarkers;
		_ctrl lbSetCurSel _curSel;

		["setCtrlAction",["RscControlAmrelTabletForceTrackGroupsTypeListCombo","LBSelChanged",{
			params [["_ctrlList",controlNull,[controlNull]]];
			private _cursel = lbcursel _ctrlList;
			if (_cursel < 0) exitwith {};
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackGroupType",_ctrlList lbData _cursel];
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "updateForceTrackGroupsName" : {
		_params params [["_group",grpNull,[grpNull]],["_name","",[""]]];

		if (_name isEqualTo "") then {
			["setCtrlText",["RscControlAmrelTabletForceTrackGroupsNameEdit",groupID _group]] call MPSF_fnc_itemAmrelTablet;
		} else {
			["setCtrlText",["RscControlAmrelTabletForceTrackGroupsNameEdit",_name]] call MPSF_fnc_itemAmrelTablet;
		};

		true;
	};
	case "updateForceTrackGroups" : {
		private _group = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackSelectedGroup",grpNull];
		if (isNull _group) exitWith {};

		if !([player] call MPSF_fnc_isAdmin || leader _group isEqualTo player) exitWith {
			["You are not the Leader of the group or a server Administrator"] call BIS_fnc_error;
		};

		private _leader = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackGroupLeader",objNull];
		if !(isNull _leader) then {
			if !(leader _group isEqualTo _leader) then {
				//broadcast
			};
		};

		private _type = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackGroupType",""];
		["updateGroupIcon",[_group,_type]] call MPSF_fnc_forcetracker;

		private _groupID = ctrlText(uiNamespace getVariable ["RscControlAmrelTabletForceTrackGroupsNameEdit",controlNull]);
		if !(_groupID isEqualTo "") then {
			_group setGroupIdGlobal [_groupID];
		};

		true;
	};
	case "updateGroupIcon" : {
		_params params [["_group",grpNull,[grpNull]],["_type","",[""]]];
		if (isNull _group || _type isEqualTo "") exitWith { false };
		if !(_type isEqualTo "") then {
			switch (true) do {
				case (toLower _type IN ["b_unknown","o_unknown","n_unknown","c_unknown"]);
				case (_type isEqualTo "AUTO") : {
					_group setVariable ["natoIcon",nil,true];
					_group setVariable ["natoIconPath",nil,true];
				};
				default {
					_group setVariable ["natoIcon",_type,true];
					_group setVariable ["natoIconPath","\a3\ui_f\data\Map\Markers\NATO\" + _type + "" + ".paa",true];
				};
			};
		};
		true;
	};
	case "onMapClickForceTrack" : {
		_params params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

		private _currentScreen = uiNamespace getVariable ["MPSF_Display_CurrentControlGroup",""];
		private _highlightGroup = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedGroup",grpNull];
		private _highlightLogic = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedLogic",objNull];

		private _reportLogic = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackReportLogic",objNull];
		if !(isNull _reportLogic) then {
			if !(_reportLogic getVariable ["ForceTrackCommitted",false]) then {
				deleteVehicle _reportLogic;
			};
		};

		["hideControlGroup",["AmrelTabletForceTrackReportsMenu"]] call MPSF_fnc_itemAmrelTablet;
		["hideControlGroup",["AmrelTabletForceTrackGroupsMenu"]] call MPSF_fnc_itemAmrelTablet;

		switch (true) do {
			case (!(isNull _highlightGroup) && _currentScreen isEqualTo "AmrelTabletForceTrackGroups" && _button == 0) : {
				missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackSelectedGroup",_highlightGroup];
				["openForceTrackGroup",[_highlightGroup]] call MPSF_fnc_forcetracker;
			};
			case (!(isNull _highlightLogic) && _currentScreen isEqualTo "AmrelTabletForceTrackReports" && _button == 0) : {
				missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportForceTrackReportLogic",_highlightLogic];
				["createForceTrackReportsUpdate",[_highlightLogic]] call MPSF_fnc_forcetracker;
			};
			case (isNull _highlightGroup && _currentScreen isEqualTo "AmrelTabletForceTrackReports" && _button == 0) : {
				["createForceTrackReportsNew"] call MPSF_fnc_forcetracker;
			};
		};

		true;
	};
	case "getForceTrackHoverGroup" : {
		missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportForceTrackHighlightedGroup",grpNull];
	};
	case "getForceTrackCursorGroup" : {
		missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0]];
	};
/* Init */
	case "preInit" : {};
	case "postInit" : {
		if (hasInterface) then {
			["setForceTrackMapDraw",[findDisplay 12 displayCtrl 51]] call MPSF_fnc_forcetracker;

			// MPSF AMREL PDA
			if !(["MPSF_openAmrelPDA",player] call MPSF_fnc_hasAction) then {
				/* ["MPSF_openAmrelPDA",player,"<t color='#ffC600'>Amrel PDA</t>",{
					private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelPDA";
				},[],"vehicle player isEqualTo player",true,false,0] spawn {sleep 0.2; _this call MPSF_fnc_addAction}; */
			};

			// MPSF AMREL TABLET
			if !(["MPSF_openAmrelTablet",player] call MPSF_fnc_hasAction) then {
			//	["MPSF_openAmrelTablet",player,"<t color='#ffC600'>Amrel Tablet</t>",{
			//		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelTabletForceTrack";
			//	},[],"alive player",true,false,0] spawn { sleep 0.5; _this call MPSF_fnc_addAction };
			};
		};
    };
	case "init" : {};
};