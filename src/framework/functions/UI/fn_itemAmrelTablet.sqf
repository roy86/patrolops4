/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-09
    
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

disableSerialization;

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
/* Interface Controls */
	case "onMove" : {
		_params params [["_ctrl",controlNull,[controlNull]]];
		(ctrlposition _ctrl) params ["_ctrlX","_ctrlY"];
		uiNamespace setVariable ["Roy86_IGUI_AmrelTablet_X",_ctrlX - safeZoneX];
		uiNamespace setVariable ["Roy86_IGUI_AmrelTablet_Y",_ctrlY - safeZoneY];
	};
	case "setCtrlAction" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_event","",[""]],["_script","",[{},""]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (isNull _ctrl || _event isEqualTo "") exitWith {false};
		_ctrl ctrlRemoveAllEventHandlers _event;
		if (_script isEqualTo {} || _script isEqualTo "") exitWith {false};
		_ctrl ctrlAddEventHandler [_event,_script];
		true;
	};
	case "setCtrlText" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_text","",[""]],["_tooltip","",[""]],["_type","text",[""]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (isNull _ctrl) exitWith {false};
		if (toLower _type isEqualTo "structuredtext") then {
			_ctrl ctrlSetStructuredText parseText _text;
		} else {
			_ctrl ctrlSetText _text;
		};
		_ctrl ctrlSetTooltip _tooltip;
		true;
	};
	case "setCtrlFocus" : {
		_params params [["_ctrl",controlNull,[controlNull,""]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (isNull _ctrl) exitWith {false};
		ctrlSetFocus _ctrl;
	};
	case "setCtrlEnable" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_enable",false,[false]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (isNull _ctrl) exitWith {false};
		_ctrl ctrlEnable _enable;
		true;
	};
	case "forceMapBackground" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]]];
		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (isNull _ctrlMap) exitWith {false};
		_ctrlMap ctrlAddEventHandler ["setfocus",{
			_this spawn {
				disableserialization;
				(_this select 0) ctrlenable false;
				(_this select 0) ctrlenable true;
			};
		}];
		true;
	};
	case "switchControlGroup" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_parentDisplay","",[""]],["_delay",0,[0]]];
		{
			["hideControlGroup",[_x,0]] call MPSF_fnc_itemAmrelTablet;
		} forEach ([_parentDisplay,"displayGroups"] call MPSF_fnc_getCfgDataArray);
		["showControlGroup",[_ctrl,_delay]] call MPSF_fnc_itemAmrelTablet;
		uiNamespace setVariable ["MPSF_Display_CurrentControlGroup",_ctrl];
		true;
	};
	case "showControlGroup" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_delay",0,[0]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (isNull _ctrl) exitWith {false};
		_ctrl ctrlEnable true;
		_ctrl ctrlSetFade 0;
		_ctrl ctrlCommit _delay;
		ctrlSetFocus _ctrl;
	};
	case "hideControlGroup" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_delay",0,[0]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (isNull _ctrl) exitWith {false};
		_ctrl ctrlEnable false;
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit _delay;
		ctrlSetFocus _ctrl;
	};
	case "switchDisplay" : {
		_params params [["_screenID","",[""]]];
		(uiNamespace getVariable ["RscDisplayAmrelTabletActive",displayNull]) closeDisplay 1;
		if !(_screenID isEqualTo "") then {
			_screenID spawn {
				_diagFrameNo = diag_frameNo;
				waitUntil {_diagFrameNo < diag_frameNo};
				([] call BIS_fnc_displayMission) createDisplay _this;
				["blurBackground",[_this]] call MPSF_fnc_itemAmrelTablet;
			};
		} else {
			["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
		};
	};
	case "setCrtlMenu" : {
		private _buttons = [
			"RscControlAmrelTabletButton_Fnc1"
			,"RscControlAmrelTabletButton_Fnc2"
			,"RscControlAmrelTabletButton_Fnc3"
			,"RscControlAmrelTabletButton_Fnc4"
			,"RscControlAmrelTabletButton_Fnc5"
			,"RscControlAmrelTabletButton_Fnc6"
			,"RscControlAmrelTabletButton_Fnc7"
			,"RscControlAmrelTabletButton_Fnc8"
			,"RscControlAmrelTabletButton_Fnc9"
			,"RscControlAmrelTabletButton_FncX"
			,"RscControlAmrelTabletButton_FncY"
			,"RscControlAmrelTabletButton_FncZ"
		];

		private _menuArray = _params apply { if !(_x isEqualType []) then {["",_x]} else {_x}; };
		_menuArray resize 6;
		_menuArray append [
			["Shutdown",{["switchDisplay",[""]] call MPSF_fnc_itemAmrelTablet;}]
			,["S1",{["executeAction",["S1"]] call MPSF_fnc_itemAmrelTablet;}]
			,["S2",{["executeAction",["S2"]] call MPSF_fnc_itemAmrelTablet;}]
			,["Cancel Action",{["cancelAction"] call MPSF_fnc_itemAmrelTablet;}]
			,["Open Settings",{["switchDisplay",["RscDisplayAmrelTabletSettings"]] call MPSF_fnc_itemAmrelTablet;}]
			,["Return to Menu",{["switchDisplay",["RscDisplayAmrelTabletMenu"]] call MPSF_fnc_itemAmrelTablet;}]
		];

		{
			_x params [["_tooltip","",[""]],["_script",{},[{}]]];
			["setCtrlAction",[_buttons select _foreachIndex,"ButtonClick",_script]] call MPSF_fnc_itemAmrelTablet;
			["setCtrlText",[_buttons select _foreachIndex,"",_tooltip]] call MPSF_fnc_itemAmrelTablet;
		} forEach _menuArray;
	};
	case "blurBackground" : {
		_params params [["_displayID","",[""]]];

		private _blurScript = missionNamespace getVariable ["MPSF_Screen_Effect_blurScript",scriptNull];
		if !(isNull _blurScript) then {terminate _blurScript};

		missionNamespace setVariable ["MPSF_Screen_Effect_blurScript",[_displayID] spawn {
			params [["_displayID","",[""]]];
			if (_displayID isEqualTo "") exitWith {};
			// PPEffect Create
			private _handle = missionNamespace getVariable "MPSF_Screen_Effect";
			if (isNil "_handle") then {
				_handle = ppEffectCreate ["DynamicBlur", 961];
				_handle ppEffectEnable true;
				_handle ppEffectAdjust [8];
				_handle ppEffectCommit 0;
				missionNamespace setVariable ["MPSF_Screen_Effect",_handle];
			};

			inGameUISetEventHandler ["PrevAction", format["if !(isNull (uiNamespace getVariable [%1,displayNull])) then {true}",str _displayID]];
			inGameUISetEventHandler ["NextAction", format["if !(isNull (uiNamespace getVariable [%1,displayNull])) then {true}",str _displayID]];

			waitUntil{isNull (uiNamespace getVariable ["RscDisplayAmrelTabletActive",displayNull])};
			uiSleep 0.125;
			// PPEffect Destroy
			if (!(isNil "_handle") && isNull (uiNamespace getVariable ["RscDisplayAmrelTabletActive",displayNull])) then {
				_handle ppEffectEnable false;
				ppEffectDestroy _handle;
				missionNamespace setVariable ["MPSF_Screen_Effect",nil];
			};
		}];
	};
	case "centerMap" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]],["_positions",[],[[]]]];

		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (_ctrlMap isEqualTo controlNull) exitWith {};

		if (_positions isEqualTo []) exitWith {
			_ctrlMap ctrlMapAnimAdd [0.2,ctrlmapscale _ctrlMap min 0.3,position player];
			ctrlMapAnimCommit _ctrlMap;
		};

		if (count _positions < 2) exitWith {
			_ctrlMap ctrlMapAnimAdd [0.2,0.3,(_positions select 0) call BIS_fnc_position];
			ctrlMapAnimCommit _ctrlMap;
		};

		private _posXmin = 1e10;
		private _posXmax = 0;
		private _posYmin = 1e10;
		private _posYmax = 0;

		{
			if !(_x isEqualTo []) then {
				private _xPos = _x call BIS_fnc_position;
				if !(_x isEqualTo [0,0,0]) then {
					_posXmin = _posXmin min (_xPos select 0);
					_posXmax = _posXmax max (_xPos select 0);
					_posYmin = _posYmin min (_xPos select 1);
					_posYmax = _posYmax max (_xPos select 1);
				};
			};
		} foreach _positions;

		private _posW =  _posXmax - _posXmin;
		private _posH = _posYmax - _posYmin;
		private _posX = _posXmin + _posW / 2;
		private _posY = _posYmin + _posH / 2;
		private _mapPosMax = _ctrlMap ctrlmapworldtoscreen [_posXmax,_posYmax];
		private _mapPosMin = _ctrlMap ctrlmapworldtoscreen [_posXmin,_posYmin];
		private _mapPosW = ((_mapPosMax select 0) - (_mapPosMin select 0));
		private _mapPosH = ((_mapPosMin select 1) - (_mapPosMax select 1));

		private _mapZoom = if (_mapPosW > 0 && _mapPosH > 0) then {
			private _mapScale = ctrlmapscale _ctrlMap;
			private _mapScaleW = _mapScale / ((ctrlposition _ctrlMap select 2) / _mapPosW);
			private _mapScaleH = _mapScale / ((ctrlposition _ctrlMap select 3) / _mapPosH);
			(_mapScaleW) * 3
		} else {
			ctrlmapscale _ctrlMap
		};

		_ctrlMap ctrlMapAnimAdd [0,_mapZoom,[_posX,_posY]];
		ctrlMapAnimCommit _ctrlMap;
		true;
	};
/* Menu */
	case "onLoadMenu": {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayAmrelTabletMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayAmrelTabletMenu"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["blurBackground",["RscDisplayAmrelTabletMenu"]] call MPSF_fnc_itemAmrelTablet;

		["setCrtlMenu",[
			["ForceTrack",{["switchDisplay",["RscDisplayAmrelTabletForceTrack"]] call MPSF_fnc_itemAmrelTablet;}]
			,["Squad Manager",{["switchDisplay",["RscDisplayAmrelTabletSquad"]] call MPSF_fnc_itemAmrelTablet;}]
			,["Support",{["switchDisplay",["RscDisplayAmrelTabletSupport"]] call MPSF_fnc_itemAmrelTablet;}]
			,["Operations",{
				if ([player] call MPSF_fnc_isAdmin) then {["switchDisplay",["RscDisplayMissionConsoleMenu"]] call MPSF_fnc_itemAmrelTablet;};
			}]
			,["",{}]
			,["",{}]
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc1","F1: ForceTrack"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc2","F2: Squads"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc3","F3: Support"]] call MPSF_fnc_itemAmrelTablet;
		if ([player] call MPSF_fnc_isAdmin) then {
			["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4: Operations"]] call MPSF_fnc_itemAmrelTablet;
		} else {
			["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4:"]] call MPSF_fnc_itemAmrelTablet;
		};
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc5","F5:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc6","F6:"]] call MPSF_fnc_itemAmrelTablet;

		onMapSingleClick "true";

		true
	};
	case "init" : {
		if (hasInterface) then {
			[] spawn {
				waitUntil { !(isNull player) };
				["initViewDistance"] call MPSF_fnc_itemAmrelTablet;
			
				// MPSF AMREL PDA
				/* ["MPSF_openAmrelPDA",player,"<t color='#ffC600'>Amrel PDA</t>",{
					private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelPDA";
				},[],"vehicle player isEqualTo player",true,false,0] spawn {sleep 0.2; _this call MPSF_fnc_addAction}; */

				// MPSF AMREL TABLET
				["MPSF_openAmrelTablet",player,"<t color='#ffC600'>Amrel Tablet</t>",{
					private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelTabletMenu";
				},[],"alive _target",true,false,0] spawn { sleep 0.2; _this call MPSF_fnc_addAction };
			};
		};
	};
/* Settings Menu */
	case "onLoadSettingsMenu" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayAmrelTabletMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayAmrelTabletSettings"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["setCrtlMenu",[
			["",{}]
			,["",{}]
			,["",{}]
			,["",{}]
			,["",{}]
			,["",{}]
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc1","F1:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc2","F2:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc3","F3:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc5","F5:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc6","F6:"]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSettings_Btn1","ButtonClick",{["onSettingsChange",[1]] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSettings_Btn2","ButtonClick",{["onSettingsChange",[2]] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSettings_Btn3","ButtonClick",{["onSettingsChange",[3]] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;

		(["getCfgViewDistance",[]] call MPSF_fnc_itemAmrelTablet) params [["_sliderMin",500,[0]],["_sliderMax",10000,[0]]];

		private _ctrlViewDistanceSlider = uiNamespace getVariable ["RscControlAmrelTabletSettings_SliderVD",controlNull];
		_ctrlViewDistanceSlider sliderSetRange [_sliderMin,_sliderMax];
		_ctrlViewDistanceSlider sliderSetPosition viewDistance;

		private _ctrlViewDistanceEdit = uiNamespace getVariable ["RscControlAmrelTabletSettings_EditVD",controlNull];
		_ctrlViewDistanceEdit ctrlSetText str (viewDistance);

		private _ctrlDrawDistanceSlider = uiNamespace getVariable ["RscControlAmrelTabletSettings_SliderDD",controlNull];
		_ctrlDrawDistanceSlider sliderSetRange [_sliderMin,_sliderMax];
		_ctrlDrawDistanceSlider sliderSetPosition (getObjectViewDistance select 0);

		private _ctrlDrawDistanceEdit = uiNamespace getVariable ["RscControlAmrelTabletSettings_EditDD",controlNull];
		_ctrlDrawDistanceEdit ctrlSetText str (getObjectViewDistance select 0);

		private _ctrlTerrainListbox = uiNamespace getVariable ["RscControlAmrelTabletSettings_TerrainList",controlNull];
		lnbClear _ctrlTerrainListbox;
		{
			_ctrlTerrainListbox lbAdd (_x select 0);
			_ctrlTerrainListbox lbSetValue [_forEachIndex,(_x select 1)];
		} forEach [["None",0],["Low",1],["Medium",2],["High",3],["Ultra",4]];
		_ctrlTerrainListbox lbSetCurSel (["getTerrainGrid",[missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"]]] call MPSF_fnc_itemAmrelTablet);

		["setCtrlAction",["RscControlAmrelTabletSettings_SliderVD","SliderPosChanged",{["onSettingsChange",_this] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSettings_EditVD","KillFocus",{["onSettingsChange",_this + [call compile (ctrlText (_this select 0))]] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSettings_SliderDD","SliderPosChanged",{["onSettingsChange",_this] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSettings_EditDD","KillFocus",{["onSettingsChange",_this + [call compile (ctrlText (_this select 0))]] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSettings_TerrainList","LBSelChanged",{["onSettingsChange",_this + [call compile (ctrlText (_this select 0))]] call MPSF_fnc_itemAmrelTablet}]] call MPSF_fnc_itemAmrelTablet;

		true
	};
	case "onSettingsChange" : {
		_params params [["_ctrl",controlNull,[controlNull,0]]];
		private _idc = if !(_ctrl isEqualType controlNull) then { _ctrl } else { ctrlIDC _ctrl };
		switch (_idc) do {
			case 86073 : {
				missionNamespace setVariable ["MPSF_VisualSettings_vehicle","Land"];
				["onSettingsChange",[86077]] call MPSF_fnc_itemAmrelTablet;
				["onSettingsChange",[86080]] call MPSF_fnc_itemAmrelTablet;
			};
			case 86074 : {
				missionNamespace setVariable ["MPSF_VisualSettings_vehicle","Sea"];
				["onSettingsChange",[86077]] call MPSF_fnc_itemAmrelTablet;
				["onSettingsChange",[86080]] call MPSF_fnc_itemAmrelTablet;
			};
			case 86075 : {
				missionNamespace setVariable ["MPSF_VisualSettings_vehicle","Air"];
				["onSettingsChange",[86077]] call MPSF_fnc_itemAmrelTablet;
				["onSettingsChange",[86080]] call MPSF_fnc_itemAmrelTablet;
			};
			case 86077;
			case 86078 : {
				private _value = _params param [1,-1,[0]];
				private _return = ["setViewDistance",[_value,(missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"])]] call MPSF_fnc_itemAmrelTablet;
				(uiNamespace getVariable ["RscControlAmrelTabletSettings_SliderVD",controlNull]) sliderSetPosition viewDistance;
				(uiNamespace getVariable ["RscControlAmrelTabletSettings_EditVD",controlNull]) ctrlSetText str (viewDistance);
				(uiNamespace getVariable ["RscControlAmrelTabletSettings_SliderDD",controlNull]) sliderSetPosition (getObjectViewDistance select 0);
				(uiNamespace getVariable ["RscControlAmrelTabletSettings_EditDD",controlNull]) ctrlSetText str (getObjectViewDistance select 0);
			};
			case 86080;
			case 86081 : {
				_value = _params param [1,-1,[0]];
				private _return = ["setObjectViewDistance",[_value,(missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"])]] call MPSF_fnc_itemAmrelTablet;
				(uiNamespace getVariable ["RscControlAmrelTabletSettings_SliderDD",controlNull]) sliderSetPosition (getObjectViewDistance select 0);
				(uiNamespace getVariable ["RscControlAmrelTabletSettings_EditDD",controlNull]) ctrlSetText str (getObjectViewDistance select 0);
			};
			case 86083 : {
				_value = _params param [1,-1,[0]];
				private _return = ["setTerrainGrid",[_value,(missionNamespace getVariable ["MPSF_VisualSettings_vehicle","Default"])]] call MPSF_fnc_itemAmrelTablet;
			};
		};
	};
	case "setViewDistance" : {
		_params params [["_distance",-1,[0]],["_type","Default",[""]]];

		private _var = format ["viewDistance%1",_type];
		(["getCfgViewDistance",[_type]] call MPSF_fnc_itemAmrelTablet) params [
			["_min",500,[0]]
			,["_max",10000,[0]]
			,["_current",(profileNamespace getVariable [format ["MPSF_%1",_var],2500]),[0]]
		];

		if (_distance < 0) then { _distance = _current; };
		private _distance = _min max ((round(_distance/100))*100) min _max;

		setViewDistance _distance;
		profileNamespace setVariable [format ["MPSF_%1",_var],_distance];

		if (((getObjectViewDistance select 0) + 1) > _distance) then {
			["setObjectViewDistance",[_distance]] call MPSF_fnc_itemAmrelTablet;
		};

		viewDistance
	};
	case "setObjectViewDistance" : {
		_params params [["_distance",-1,[0]],["_type","Default",[""]]];

		private _var = format ["objectViewDistance%1",_type];
		(["getCfgViewDistance",[_type]] call MPSF_fnc_itemAmrelTablet) params [
			["_min",500,[0]]
			,["_max",10000,[0]]
			,["_current",(profileNamespace getVariable [format ["MPSF_%1",_var],2500]),[0]]
		];

		if (_distance < 0) then { _distance = _current; };
		private _distance = _min max ((round(_distance/100))*100) min (_max min viewDistance);

		setObjectViewDistance _distance;
		profileNamespace setVariable [format ["MPSF_%1",_var],_distance];

		getObjectViewDistance select 0;
	};
	case "setTerrainGrid" : {
		_params params [["_index",-1,[0]],["_type","Default",[""]]];

		private _var = format ["terrainGrid%1",_type];
		switch (_index) do {
			case 0 : { setTerrainGrid 50 };
			case 1 : { setTerrainGrid 25 };
			case 2 : { setTerrainGrid 12.5 };
			case 3 : { setTerrainGrid 6.25 };
			case 4 : { setTerrainGrid 3.125 };
			//case 5 : { setTerrainGrid 1.5625 };
		};

		if !(_index < 0) then {
			missionNamespace setVariable [format ["MPSF_%1",_var],_index];
			profileNamespace setVariable [format ["MPSF_%1",_var],_index];
		};

		getTerrainGrid
	};
	case "getTerrainGrid" : {
		params [["_type","Default",[""]]];
		private _var = format ["terrainGrid%1",_type];
		missionNamespace getVariable [format ["MPSF_%1",_var],
			profileNamespace getVariable [format ["MPSF_%1",_var],1]
		];
	};
	case "getCfgViewDistance" : {
		_params params [["_type","Default",[""]]];
		["CfgMissionFramework",format ["viewDistance",_type]] call MPSF_fnc_getCfgDataArray;
	};
	case "initViewDistance" : {
		["MPSF_Inerface_onGetIn_EH","onGetIn",{
			params [["_unit",objNull,[objNull]],["_role","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];
			private _type = switch (true) do {
				case (_vehicle isKindOf "Ship");
				case (_vehicle isKindOf "Helicopter") : {"Sea"};
				case (_vehicle isKindOf "Air") : {"Air"};
				default {"Land"};
			};
			//systemChat format ["Viewsettings Adjusted to %1",_type];
			["setViewDistance",[-1,_type]] call MPSF_fnc_itemAmrelTablet;
			["setObjectViewDistance",[-1,_type]] call MPSF_fnc_itemAmrelTablet;
		}] call MPSF_fnc_addEventHandler;
		["MPSF_Inerface_onGetOut_EH","onGetOut",{
			//systemChat format ["Viewsettings Adjusted to %1","Land"];
			["setViewDistance",[-1,"Land"]] call MPSF_fnc_itemAmrelTablet;
			["setObjectViewDistance",[-1,"Land"]] call MPSF_fnc_itemAmrelTablet;
		}] call MPSF_fnc_addEventHandler;
	};
};