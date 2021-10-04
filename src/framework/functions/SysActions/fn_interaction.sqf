/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_interaction.sqf
	Author(s): see mpsf\credits.txt

	Description:
		INTERACTION Framework
*/
#include "\A3\ui_f\hpp\defineDIKCodes.inc"
params [["_mode","",[""]],["_params",[]]];

switch (_mode) do {
	case "addAction" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[]]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
			,["_priority",0,[0]]
		];

		if ((_object getVariable [_actionID,-1]) >= 0) then {
			[_actionID,_object] call MPSF_fnc_eventOnRemoveAction;
		};

		private _type = if (_object isEqualTo player) then {"Self"} else {"Else"};
		switch (true) do {
		// ADD ACE and CBA Interaction Support
		//	case ([["ace_main"],false] call MPSF_fnc_checkMods) : { [format["ACE_addAction%1",_type],_params] call MPSF_fnc_Interaction; };
		//	case (isClass(configFile >> "CfgPatches" >> "cba_main_a3")) : { [format["CBA_addAction%1",_type],_params] call MPSF_fnc_Interaction; };
			case (typeName _script isEqualTo typeName []) : { ["BIS_addActionHold",_params] call MPSF_fnc_Interaction; };
			default { ["BIS_addAction",_params] call MPSF_fnc_Interaction; };
		};
	};
	/* Interaction: BIS Menu */
	case "BIS_addAction" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[]]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
			,["_priority",100,[0]]

		];
		_object setVariable [_actionID,
			_object addAction [_displayText,_script,_arguments,_priority,true,true,"",_condition,15]
		,false];
	};
	case "BIS_addActionHold" : {
		_params params [
			["_actionID","",[""]]
			,["_object",objNull,[objNull]]
			,["_displayText","Interact",[""]]
			,["_script",{},[{},[]]]
			,["_arguments",[],[[],objNull]]
			,["_condition","true",[""]]
			,["_draw3D",false,[false]]
			,["_priority",100,[0]]
		];
		_script params [
			["_onStart",{},[[],{}]]
			,["_onProgress",{},[[],{}]]
			,["_codeCompleted",{},[{}]]
			,["_codeInterrupted",{},[{}]]
			,["_duration",5,[0]]
			,["_removeCompleted",false,[false]]
		];
		if !(typeName _onStart isEqualTo typeName []) then { _onStart = ["",_onStart]; };
		if !(typeName _onProgress isEqualTo typeName []) then { _onProgress = ["",_onProgress]; };
		_onStart params [["_holdIconStart","",[""]],["_codeStart",{},[{}]]];
		_onProgress params [["_holdIconProgress","",[""]],["_codeProgress",{},[{}]]];
		if (_codeProgress isEqualTo {}) then {
			_codeProgress = {
				private _progressTick = _this select 4;
				if (_progressTick % 2 == 0) exitwith {};
				playsound3d [((getarray (configfile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0,""]) + ".wss",player,false,getposasl player,1,0.9 + 0.2 * _progressTick / 24];
			};
		};
		_object setVariable [_actionID,
			[_object,_displayText,_holdIconStart,_holdIconProgress,_condition,"true",_codeStart,_codeProgress,_codeCompleted,_codeInterrupted,_arguments,_duration,_priority,_removeCompleted] call BIS_fnc_holdActionAdd
		,false];
	};
	/* Interaction: ACE Menu */
	case "ACE_addActionElse" : {
		if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		//	http://forums.unitedoperations.net/index.php/topic/25042-ace-custom-interactions/
		//	_action = ["vip_brofist", "Brofist", "", {systemChat format["%1 does not wish to brofist.", name (_this select 0)]}, {true}] call ace_interact_menu_fnc_createAction;
		//	[typeOf player, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		//	[bob, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
		};
	};
	case "ACE_addActionSelf" : {
		if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		//	_action = ["vip_cyanide", "Take Cyanide Capsule", "", {player setDamage 1}, {true}] call ace_interact_menu_fnc_createAction;
		//	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
		};
	};
	/* Interaction: CBA Menu */
	case "CBA_KeyBind" : {
		if (isClass(configFile >> "CfgPatches" >> "cba_main_a3")) then {
		//	["MPSF", "MyKey", ["My Pretty Key Name", "My Pretty Tool Tip"], { systemChat str _this; }, { systemChat str _this; }, [DIK_TAB, [false, false, false]]] call cba_fnc_addKeybind;
		//	["MPSF", "MyOtherKey", "My Other Pretty Key Name", { systemChat str _this; }, { systemChat str _this; }, [DIK_K, [false, false, false]]] call cba_fnc_addKeybind;
		//	["MPSF", "MyOtherKey2", "My Pretty Name", { systemChat str _this; }, { systemChat str _this; }, [DIK_SPACE, [false, false, false]]] call cba_fnc_addKeybind;
		};
	};
	case "init" : {
		if (hasInterface) then {
        	waitUntil {!isNull player && alive player};

			{ _x call MPSF_fnc_eventOnAddAction; } forEach (missionNamespace getVariable ["MPSF_InterAction_globalActions",[]]);
			{ _x call MPSF_fnc_eventOnAddAction; } forEach (missionNamespace getVariable ["MPSF_InterAction_localActions",[]]);
			{ _x set [1,player]; _x call MPSF_fnc_eventOnAddAction; } forEach (missionNamespace getVariable ["MPSF_InterAction_playerActions",[]]);

			// Replace body with BodyBag (LAWS DLC)
			[] call MPSF_fnc_actionBodyBag;
			// INTEL Body Searching
			[] call MPSF_fnc_actionBodySearch;

			//["MPSF_Interaction_onKilled_reSync_EH","onKilled",{["init"] spawn MPSF_fnc_interaction}] call MPSF_fnc_addEventHandler;
			//["MPSF_Interaction_onKilled_reSync_EH","onRespawn",{["init"] spawn MPSF_fnc_interaction}] call MPSF_fnc_addEventHandler;
		};
	};
};