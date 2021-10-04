#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"
#define ICONNATO(natoIcon)	("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
#define ICONSELECTORM		"\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa"
#define ICONSELECTED		"\A3\ui_f\data\map\groupicons\selector_selected_ca.paa"
#define ICONPARACHUTE		"\A3\ui_f\data\Map\VehicleIcons\iconParachute_ca.paa"
#define ICONBADGE			"\A3\ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa"
#define ICONMOVEWARNING		"\A3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa"
#define ICONMOVE			"\A3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa"

disableSerialization;

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "onLoad" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayRespawnMPMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayRespawnMPMenu"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["blurBackground",["RscDisplayRespawnMPMenu"]] call MPSF_fnc_itemAmrelTablet;

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

		onMapSingleClick "";
		/* ["setForceTrackMapDraw",["RespawnMPMap"]] call (missionNamespace getVariable ["MPSF_fnc_forcetracker",{}]); */
		["onMapDraw",["RespawnMPMap"]] call MPSF_fnc_respawnUI;
		["centerMap",["RespawnMPMap"]] call MPSF_fnc_itemAmrelTablet;
		["forceMapBackground",["RespawnMPMap"]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlRespawnMPCommitButton","MouseButtonClick",{
			['onMouseClick',_this] call MPSF_fnc_respawnUI;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlRespawnMPHaloCommitButton","MouseButtonClick",{
			['onMouseClick',_this] call MPSF_fnc_respawnUI;
		}]] call MPSF_fnc_itemAmrelTablet;

		["MPSF_Respawn_ButtonUpdate_EH","onEachFrame",{
			if (isNull (uiNamespace getVariable ["RscDisplayRespawnMPMenu",displayNull])) exitWith {
				["MPSF_Respawn_ButtonUpdate_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
		}] call MPSF_fnc_addEventHandler;

		private _ctrlHaloSlider = uiNamespace getVariable ["RscControlRespawnMPHALOslider",controlNull];
		_ctrlHaloSlider sliderSetRange [500,10000];
		_ctrlHaloSlider sliderSetSpeed [100,100];
		["onMouseClick",[_ctrlHaloSlider,0]] call MPSF_fnc_respawnUI;
		["setCtrlAction",[_ctrlHaloSlider,"SliderPosChanged",{
			["onMouseClick",_this] call MPSF_fnc_respawnUI;
		}]] call MPSF_fnc_itemAmrelTablet;

		["switchControlGroup",["","RscDisplayRespawnMPMenu"]] call MPSF_fnc_itemAmrelTablet;

		true
	};
	case "onMapDraw" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]]];

		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (_ctrlMap isEqualTo controlNull) exitWith {["Unable to find respawn interface map"] call BIS_fnc_error;};

		_ctrlMap ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MPSF_FT_MAP_CURSORPOS",(_this select 0) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];}];
		_ctrlMap ctrlAddEventHandler ["MouseButtonClick",{ ['onMapClick',_this] call MPSF_fnc_respawnUI; }];

		_ctrlMap ctrlAddEventHandler ["Draw",{
			params ["_ctrlMap"];

			private _currentScreen = uiNamespace getVariable ["MPSF_Display_CurrentControlGroup",""];
			private _assignedItems = (assigneditems player apply {_x call BIS_fnc_itemType}) apply {toLower (_x select 1)};

			(missionNamespace getVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",[]]) params [["_selectedTarget",objNull,[objNull,"",[]]],["_selectedName","",[""]],["_selectedHalo",false,[false]]];

			private _cursorPos = missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0,0]];
			private _curstorDistance = (60-(60/((ctrlMapScale _ctrlMap)*100))) max 10;
			private _cursorHover = false;
			private _colorDanger = ["IGUI","WARNING_RGB"] call BIS_fnc_displayColorGet;
			_colorDanger set [3, 1];

			private _zoom = (8 * 0.15) * 10^(abs log (ctrlMapScale _ctrlMap));
			private _size = 36 min _zoom;

			if (_size >= 30) then {
				_ctrlMap drawRectangle [[worldSize/2,worldSize/2,0],worldSize/2,worldSize/2,0,[1,1,1,0.42],"\A3\Ui_f\data\GUI\Rsc\RscDisplayStrategicMap\cross_ca.paa"];
			};

			{
				_x params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];

				private _iconColour = [1,1,1,0.8];
				private _drawPos = _target call BIS_fnc_position;
				if (_displayName isEqualTo "") then { _displayName = format ["#%1",mapGridPosition _drawPos]; };
				if (_size >= 24) then {
					_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",_iconColour,_drawPos,_size,_size,0,format[" %1",_displayName],2,(_size/1000),'PuristaMedium','right'];
				};

				if (_cursorPos distance2D _drawPos < _curstorDistance && !_cursorHover) then {
					missionNamespace setVariable ["MPSF_itemAmrelTablet_var_respawnMPHighlightedPosition",_x];
					_cursorHover = true;
					_iconColour =+ _colorDanger;
				} else {
					if !(_cursorHover) then {
						missionNamespace setVariable ["MPSF_itemAmrelTablet_var_respawnMPHighlightedPosition",nil];
					};
				};

				switch (true) do {
					case (_target isEqualTo _selectedTarget) : {
						_ctrlMap drawIcon [ICONSELECTORM,[1,0.66,0,1],_drawPos,32,32,(diag_frameNo%360)*4,"",1,0.03,'PuristaMedium','right'];
						_ctrlMap drawIcon [ICONMOVE,[1,1,1,1],_drawPos,24,24,0,"",1,0.03,'PuristaMedium','right'];
					};
					case ({ alive _x && {side group _x != side group player} && {_x distance _drawPos <= 250} } count allUnits > 0) : {
						_ctrlMap drawicon [ICONSELECTED,_iconColour,_drawPos,30,30,0,"",1];
						_ctrlMap drawicon [ICONMOVEWARNING,_colorDanger,_drawPos,30,30,0,"",1];
					};
					default {
						private _image = [0,1,2,3,4,5,6,5,4,3,2,1] select (((diag_frameNo + _forEachIndex*2)/5)%11);
						_ctrlMap drawicon [format[ICONBADGE,_image],_iconColour,_drawPos,30,30,0,"",1];
					};
				};
			} forEach (["getRespawnPositions",[player]] call MPSF_fnc_respawnMP);

			if (_selectedHalo) then {
				_ctrlMap drawIcon [ICONSELECTORM,[1,0.66,0,1],_selectedTarget,32,32,(diag_frameNo%360)*4,"",1,0.03,'PuristaMedium','right'];
				_ctrlMap drawIcon [ICONPARACHUTE,[1,1,1,1],_selectedTarget,24,24,0,"",1,0.03,'PuristaMedium','right'];
				_ctrlMap drawIcon ["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_selectedTarget,24,24,0," Parachute",1,0.03,'PuristaMedium','right']; // Todo: Localise
			};

			//systemChat str [diag_frameNo,_size,_zoom];
		}];
	};
	case "centerMap" : {
		_params params [["_ctrlMap",controlNull,[controlNull,""]],["_position",[],[[]]]];

		if (_ctrlMap isEqualType "") then { _ctrlMap = uiNamespace getVariable [_ctrlMap,controlNull]; };
		if (_ctrlMap isEqualTo controlNull) exitWith {};

		if (count _position > 0) exitWith {
			_position params ["_posX","_posY"];
			_ctrlMap ctrlMapAnimAdd [0.2,ctrlmapscale _ctrlMap min 0.3,[_posX,_posY]];
			ctrlMapAnimCommit _ctrlMap;
		};

		private _respawnAreas = ["getRespawnPositions",[player]] call MPSF_fnc_respawnMP;
		if (count _respawnAreas > 0) then {
			private _posXmin = 1e10;
			private _posXmax = 0;
			private _posYmin = 1e10;
			private _posYmax = 0;
			{
				_x params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];
				private _xPos = (_target) call BIS_fnc_position;
				_posXmin = _posXmin min (_xPos select 0);
				_posXmax = _posXmax max (_xPos select 0);
				_posYmin = _posYmin min (_xPos select 1);
				_posYmax = _posYmax max (_xPos select 1);
			} foreach _respawnAreas;
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
				(_mapScaleW max _mapScaleH) * 2
			} else {
				ctrlmapscale _ctrlMap
			};
			_ctrlMap ctrlMapAnimAdd [0,_mapZoom,[_posX,_posY]];
		} else {
			_ctrlMap ctrlMapAnimAdd [0,0.1,[worldSize/2,worldSize/2,0]];
		};
		ctrlMapAnimCommit _ctrlMap;
		true;
	};
	case "onMapClick" : {
		_params params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

		if (_button == 1) exitWith {
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",nil];
			["switchControlGroup",["","RscDisplayRespawnMPMenu"]] call MPSF_fnc_itemAmrelTablet;
		};

		(missionNamespace getVariable ["MPSF_itemAmrelTablet_var_respawnMPHighlightedPosition",[]]) params [["_target",objNull,[objNull,"",[]]],["_displayName","",[""]],["_halo",false,[false]]];
		switch (true) do {
			case (_target isEqualType objNull && !(_target isEqualTo objNull));
			case (_target isEqualType [] && !(_target isEqualTo []));
			case (_target isEqualType "" && !(_target isEqualTo "")) : {
				missionNamespace setVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",[_target,_displayName,_halo]];
				["setCtrlText",["RscControlRespawnMPCommitButton",format["Redploy to %1",_displayName]]] call MPSF_fnc_itemAmrelTablet;
				["switchControlGroup",["RespawnMPMenu","RscDisplayRespawnMPMenu"]] call MPSF_fnc_itemAmrelTablet;
			};
			default {
				if ([player,"HALO"] call MPSF_fnc_getUnitTrait) then {
					missionNamespace setVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",[
						missionNamespace getVariable ["MPSF_FT_MAP_CURSORPOS",[0,0,0]],
						"HALO",
						true
					]];
					['onMouseClick',["RscControlRespawnMPHALOslider",0]] call MPSF_fnc_respawnUI;
					["switchControlGroup",["RespawnMPHalo","RscDisplayRespawnMPMenu"]] call MPSF_fnc_itemAmrelTablet;
				};
			};
		};
	};
	case "onMouseClick" : {
		_params params [["_ctrl",controlNull,["",controlNull]],["_value","",["",0]]];

		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (_ctrl isEqualTo controlNull) exitWith {};

		switch (ctrlIDC _ctrl) do {
			case 86203 : {
				_altitude = _params param [1,0,[0]];
				_altitude = 500 max ((round(_altitude/100)) * 100);
				_ctrl sliderSetPosition _altitude;
				["updateHaloText",[_altitude]] call MPSF_fnc_respawnUI;
			};
			case 86206;
			case 86208 : {
				(missionNamespace getVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",[]]) params [["_selectedTarget",objNull,[objNull,"",[]]],["_selectedName","",[""]],["_selectedHalo",false,[false]]];

				if (_selectedHalo) then {
					_selectedTarget = _selectedTarget call BIS_fnc_position;
					_selectedTarget set [2,sliderPosition (uiNamespace getVariable ["RscControlRespawnMPHALOslider",controlNull])];
				};

				if (["isLoaded",[vehicle player]] call (missionNamespace getVariable ["MPSF_Fnc_logistics",{false}])) exitWith {
					player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"You cannot Jump with a loaded vehicle!"];
				};

				private _units = [player];
				if !(vehicle player isEqualTo player) then {
					_units pushBackUnique vehicle player;
				};

				if (leader group player isEqualTo player) then {
					{
						if ((_x distance2D player) < 50) then {
							if !(isPlayer _x) then {
								if !(vehicle _x isEqualTo _x) then {
									_units pushBackUnique vehicle _x;
								};
								_units pushBackUnique _x;
							};
						};
					} forEach (units group player);
				};

				["MPSF_RespawnMP_Action",vehicle player] call MPSF_fnc_removeAction;
				["onRedeploy",[_units,_selectedTarget],0] call MPSF_fnc_triggerEventHandler;
				(uiNamespace getVariable ["RscDisplayRespawnMPMenu",displayNull]) closeDisplay 1;
			};
		};

		true;
	};
	case "updateHaloText" : {
		_params params [["_altitude",0,[0]]];

		(missionNamespace getVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",[]]) params [["_selectedTarget",objNull,[objNull,"",[]]],["_selectedName","",[""]],["_selectedHalo",false,[false]]];

		if (_selectedTarget isEqualTo objNull || _selectedTarget isEqualTo "") exitWith {};

		private _distance = player distance2D (_selectedTarget call BIS_fnc_position);
		private _ctrlText = uiNamespace getVariable ["RscControlRespawnMPHALOTextDist",controlNull];
		private _stringFormat = "<t size='0.8' shadow='0'>%1</t><br/><t size='1.2' shadow='0'>%2</t><br/><t size='0.8'>%3</t>";

		private _distance = if (_distance < 1000) then {
			[format ["%1m",round(_distance)],format ["%1ft",round(_distance*3.28084)]];
		} else {
			[format ["%1km",round(_distance/100)/10],format ["%1mi",round((_distance*0.621371)/100)/10]];
		};
		_distance params ["_distanceMetric","_distanceImperial"];
		private _stringText = format[_stringFormat,"Dist. Base",_distanceMetric,_distanceImperial];
		_ctrlText ctrlSetStructuredText parseText _stringText;

		private _ctrlText = uiNamespace getVariable ["RscControlRespawnMPHALOTextAlt",controlNull];
		private _stringFormat = "<t size='0.8' shadow='0'>%1</t><br/><t size='1.2' shadow='0'>%2</t><br/><t size='0.8'>%3</t>";
		private _altJump = _altitude < 4500;
		private _altitude = if (_altitude < 1000) then {
			[format ["%1m",round(_altitude)],format ["%1ft",round(_altitude*3.28084)]];
		} else {
			[format ["%1km",round(_altitude/100)/10],format ["%1mi",round((_altitude*0.621371)/100)/10]];
		};
		_altitude params ["_heightMetric","_heightImperial"];
		private _stringText = format[_stringFormat,if (_altJump) then {"Jump Alt."} else {"HALO Alt."},_heightMetric,_heightImperial];
		_ctrlText ctrlSetStructuredText parseText _stringText; // Todo: Localise
	};
};