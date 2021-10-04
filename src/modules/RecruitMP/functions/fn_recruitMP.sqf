#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#define BANNERPO4BLK "framework\data\titles\patrolops_banner_b_co.paa"
#define BANNERPO4WHT "framework\data\titles\patrolops_banner_co.paa"
#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Event Handlers
	case "arsenalOpened" : {
		_params params [["_display",displayNull,[displayNull]],["_index",false,[false]]];

		uiNamespace setVariable ["MPSF_RecruitMP_ArsenalDisplay",_display];

		private _ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		private _ctrlButtonRandom = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM;
		_ctrlButtonRandom ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonRandom ctrlSetText "";
		_ctrlButtonRandom ctrlSetTooltip "";
		_ctrlButtonRandom ctrlEnable false;

		private _ctrlButtonSave = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonSave ctrlSetText "";
		_ctrlButtonSave ctrlSetTooltip "";
		_ctrlButtonSave ctrlEnable false;

		/*private _ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonLoad ctrlSetText "";
		_ctrlButtonLoad ctrlSetTooltip "";
		_ctrlButtonLoad ctrlEnable false;*/

		private _ctrlButtonExport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonExport ctrlSetText "";
		_ctrlButtonExport ctrlSetTooltip "";
		_ctrlButtonExport ctrlEnable true;

		private _ctrlButtonImport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonImport ctrlSetText "";
		_ctrlButtonImport ctrlSetTooltip "";
		_ctrlButtonImport ctrlEnable false;

		private _ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlButtonOK ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonOK ctrlAddEventhandler ["buttonclick",format ["with missionNamespace do { disableSerialization; ['onButtonClick',['recruit']] call MPSF_fnc_RecruitMP; };"]];
		_ctrlButtonOK ctrlSetText "Recruit Unit";
		_ctrlButtonOK ctrlSetTooltip "Recruit the unit with the current loadout";
		_ctrlButtonOK ctrlEnable true;

		private _ctrl = _display ctrlCreate ["RscPictureKeepAspect",-1];
		_ctrl ctrlSetPosition [
			(safezoneW/2) - 7.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)
			,0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)
			,15 * (((safezoneW / safezoneH) min 1.2) / 40)
			,8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
		];
		(date call BIS_fnc_sunriseSunsetTime) params ["_min","_max"];
		if ((date select 3) > _min && (date select 3) < _max) then {
			_ctrl ctrlSetText BANNERPO4BLK;
		} else {
			_ctrl ctrlSetText BANNERPO4WHT;
			_intensity = 1;
			_light = "#lightpoint" createvehicle position player;
			_light setLightBrightness _intensity;
			_light setLightAmbient [1,1,1];
			_light setLightColor [0,0,0];
			_light lightAttachObject [player,[0,0,-_intensity * 7]];
			missionNamespace setVariable ["MPSF_VirtualArmoury_lightpoint",_light];
		};
		_ctrl ctrlSetFade 0.2;
		_ctrl ctrlCommit 0;
		["updateButton"] call MPSF_fnc_RecruitMP;
	};
	case "arsenalClosed" : {
		private _light = missionNamespace getVariable ["MPSF_VirtualArmoury_lightpoint",objNull];
		if !(isNull _light) then {deleteVehicle _light;};
	};
	case "onButtonClick" : {
		_params params [["_action","",[""]]];
		switch (_action) do {
			case "recruit" : {
				private _target = missionNamespace getVariable ["MPSF_RecruitMP_Target",objNull];
				if (player isEqualTo leader group player) then {
					private _recruitTarget = (group player) createunit [typeOf player,(position player) getPos [2,180-(getDir player)],[],0,"none"];
					_recruitTarget setUnitLoadout [getUnitLoadout _target,true];

					if !(isNull _recruitTarget) then {
						[format["MPSF_RecruitMP_DismissAction_%1",_recruitTarget call BIS_fnc_netId],_recruitTarget,format["Dismiss %1",name _recruitTarget],[
							["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
							,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
							,{
								params ["_target", "_caller", "_actionId", "_arguments"];
								["MPSF_RecruitRemove",[name _target]] call BIS_fnc_showNotification;
								[_target] joinSilent grpNull;
								deleteVehicle _target;
							}
							,{}
							,2,false,101
						],[]
						,"vehicle player isEqualTo player && _this distance _target < 4 && alive _target"
						,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
					};

					private _assignedItems = (assigneditems _recruitTarget apply {_x call BIS_fnc_itemType}) apply {tolower (_x select 1)};
					if (count (["toolkit"] arrayIntersect _assignedItems) > 0) then { _recruitTarget setUnitTrait ["engineer",true] };
					if (count (["minedetector"] arrayIntersect _assignedItems) > 0) then { _recruitTarget setUnitTrait ["explosiveSpecialist",true] };
					if (count (["medikit"] arrayIntersect _assignedItems) > 0) then { _recruitTarget setUnitTrait ["medic",true] };
					if (count (["b_uavterminal","o_uavterminal","i_uavterminal"] arrayIntersect _assignedItems) > 0) then { _recruitTarget setUnitTrait ["UAVHacker",true] };

					["MPSF_RecruitAdd",[name _recruitTarget]] call BIS_fnc_showNotification;
					["updateButton"] call MPSF_fnc_RecruitMP;
				};
			};
		};
	};
	case "updateButton" : {
		private _display = uiNamespace getVariable ["MPSF_RecruitMP_ArsenalDisplay",displayNull];
		private _limit = ["getCfgSquadLimit"] call MPSF_fnc_RecruitMP;
		if (_limit < 0) exitWith {};
		private _canRecruit = (count (units group player)) < _limit;
		private _ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		if (_canRecruit) then {
			_ctrlButtonOK ctrlRemoveAllEventHandlers "buttonclick";
			_ctrlButtonOK ctrlAddEventhandler ["buttonclick",format ["with missionNamespace do { disableSerialization; ['onButtonClick',['recruit']] call MPSF_fnc_RecruitMP; };"]];
			_ctrlButtonOK ctrlSetText format ["Recruit Unit (%1 Remaining)",_limit - (count (units group player))];
			_ctrlButtonOK ctrlSetTooltip "Recruit the unit with the current loadout";
			_ctrlButtonOK ctrlEnable true;
		} else {
			_ctrlButtonOK ctrlRemoveAllEventHandlers "buttonclick";
			_ctrlButtonOK ctrlSetText "Limit Reached";
			_ctrlButtonOK ctrlSetTooltip "Unable to recruit any more units";
			_ctrlButtonOK ctrlEnable false;
		};
	};
	case "startRecruit" : {
		private _radius = worldsize * 0.5;
		private _condition = if (random 1 < 0.1) then {"(waterDepth interpolate [0,1,1,0])"} else {"(waterDepth interpolate [0,1,1,0]) * (1 - forest)"};
		private _position = (selectbestplaces [[_radius,_radius,0],_radius,_condition,200,1]) select 0 select 0;
		private _group = createGroup (player call BIS_fnc_objectSide);
		private _target = _group createunit [typeOf player,_position,[],0,"none"];
		missionNamespace setVariable ["MPSF_RecruitMP_Target",_target];
		missionNamespace setVariable ["MPSF_RecruitMP_TargetGroup",_group];

		_target setpos _position;
		_target setdir ([_position,player] call bis_fnc_dirto);
		_target dowatch position player;
		_target addrating -10e10;
		_target setunitpos "up";
		_target setbehaviour "careless";
		_target setcombatmode "blue";
		_target setspeedmode "limited";
		_target disableai "target";
		_target disableai "autotarget";
		_target allowfleeing 0;
		_target setspeaker "base";
		_target spawn {_this setspeaker "base";};
		_target switchmove "amovpercmstpslowwrfldnon";

		["Open",[true,nil,_target]] call BIS_fnc_arsenal;
	};
	case "endRecruit" : {
		deleteVehicle (missionNamespace getVariable ["MPSF_RecruitMP_Target",objNull]);
		deleteGroup (missionNamespace getVariable ["MPSF_RecruitMP_TargetGroup",grpNull]);
	};
// Trigger
	case "createAction" : {
		_params params [["_logic",objNull,[objNull]]];

		if (isNull _logic) exitWith {};
		if !(isNull (_logic getVariable ["MPSF_RecruitMP_Trigger",objNull])) exitWith {};

		if (hasInterface) then {
			private _trigger = createTrigger ["EmptyDetector",_logic,false];
			_trigger setTriggerArea [4,4,getDir _logic,false];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateAction',[thisTrigger,thisList]] call MPSF_fnc_RecruitMP;"]
				,format["['deactivateAction',[thisTrigger]] call MPSF_fnc_RecruitMP;"]
			];
			_trigger attachTo [_logic,[0,0,0]];
			_logic setVariable ["MPSF_RecruitMP_Trigger",_trigger];
		};
	};
	case "activateAction" : {
		_params params [["_trigger",objNull],["_list",[],[[]]]];

		if !(player in _list) exitWith {};
		if !(leader group player isEqualTo player) exitWith {};

		private _logic = attachedTo _trigger;
		["MPSF_RecruitMP_RecruitAction",player,"Recruit AI",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ["startRecruit"] call MPSF_fnc_RecruitMP; }
			,{}
			,0.5,false,101
		],[],"speed vehicle player isEqualTo 0 && vehicle player isEqualTo player && leader group player isEqualTo player"
		,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};

		if (hasInterface) then {
			["MPSF_VirtualArmoury_arsenalOpened_EH","arsenalOpened",{
				["arsenalOpened",_this] call MPSF_fnc_RecruitMP;
			}] call MPSF_fnc_addEventHandler;
			["MPSF_RecruitMP_arsenalClosed_EH","arsenalClosed",{
				["arsenalClosed"] call MPSF_fnc_RecruitMP;
				["endRecruit"] call MPSF_fnc_RecruitMP;
			}] call MPSF_fnc_addEventHandler;
		};
	};
	case "deactivateAction" : {
		["MPSF_RecruitMP_RecruitAction",player] call MPSF_fnc_removeAction;
		["MPSF_VirtualArmoury_arsenalOpened_EH","arsenalOpened"] call MPSF_fnc_removeEventHandler;
		["MPSF_RecruitMP_arsenalClosed_EH","arsenalClosed"] call MPSF_fnc_removeEventHandler;
	};
// Configuration
	case "getCfgSquadLimit" : {
		["MPSFRecruitMPSize",["CfgRecruitMP","limit"] call MPSF_fnc_getCfgDataNumber] call MPSF_fnc_getCfgParam;
	};
// Init
	case "init" : {
		_params params [
			["_logic",objNull,[objNull,[]]]
			,["_classNames",[],[[]]]
		];

		_logic setVariable ["classNames",_classNames];
		["createAction",[_logic]] call MPSF_fnc_RecruitMP;
	};
};