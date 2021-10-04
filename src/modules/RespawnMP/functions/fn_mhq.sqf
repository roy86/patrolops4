/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-01-05
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "canDeployMHQ" : {
		_params params [["_target",objNull,[objNull]]];
		!(["isMHQdeployed",[_target,false]] call MPSF_fnc_mhq)
		&& alive _target
		&& count (crew _target) == 0
	};
	case "canUndeployMHQ" : {
		_params params [["_target",objNull,[objNull]]];
		(["isMHQdeployed",[_target,false]] call MPSF_fnc_mhq)
		&& alive _target
		&& count (crew _target) == 0
	};
	case "setMHQdeployed" : {
		_params params [["_target",objNull,[objNull]],["_state",false,[false]]];
		_target setVariable ["MPSF_RespawnMP_MHQstate",_state,true];
		true;
	};
	case "isMHQdeployed" : {
		_params params [["_target",objNull,[objNull]],["_default",false,[false]]];
		private _return = _target getVariable ["MPSF_RespawnMP_MHQstate",_default];
		_return;
	};
	case "isMHQfriendly" : {
		_params params [["_target",objNull,[objNull]],["_unit",player,[objNull]]];
		private _sideMHQ = _target getVariable ["MPSF_RespawnMP_MHQside",-1];
		if (_sideMHQ < 0) exitWith { true };
		private _sideUnit = (side group _unit) call BIS_fnc_sideID;
		(_sideMHQ isEqualTo _sideUnit);
	};
	case "activate" : {
		_params params [["_trigger",objNull]];

		private _vehicle = attachedTo _trigger;
		if (isNull _vehicle) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };

		// Deploy MHQ
		[format ["MPSF_%1_Respawn_DeployMHQ_Action",_vehicle call BIS_fnc_netId],_vehicle,"Deploy MHQ",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ["onDeployMHQ",[_target,_caller],0] spawn MPSF_fnc_triggerEventHandler; }
			,{}
			,3,false,103
		],[],"(['canDeployMHQ',[_target]] call MPSF_fnc_mhq)"
		,true] spawn { sleep 0.1; _this call MPSF_fnc_addAction; };

		// Undeploy MHQ
		[format ["MPSF_%1_Respawn_UndeployMHQ_Action",_vehicle call BIS_fnc_netId],_vehicle,"Pack Up MHQ",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ["onUndeployMHQ",[_target,_caller],0] spawn MPSF_fnc_triggerEventHandler; }
			,{}
			,3,false,102
		],[],"(['canUndeployMHQ',[_target]] call MPSF_fnc_mhq)"
		,true] spawn { sleep 0.2; _this call MPSF_fnc_addAction; };

		// Player Redeploy Menu
		[format ["MPSF_%1_Respawn_RedeployMHQ_Action",_vehicle call BIS_fnc_netId],_vehicle,"Redploy Soldier",[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayRespawnMPMenu"; }
			,{}
			,3,false,101
		],[],"(['isMHQdeployed',[_target]] call MPSF_fnc_mhq) && (vehicle player isEqualTo player)"
		,true] spawn {sleep 0.3; _this call MPSF_fnc_addAction;};

		// Player Mission Menu
		if !(isNil {missionNamespace getVariable "PO4_fnc_operations"}) then {
			[format ["MPSF_%1_Respawn_MissionyMHQ_Action",_vehicle call BIS_fnc_netId],_vehicle,"Access Command Centre",[
				["mpsf\data\holdactions\holdAction_map.paa",{}]
				,["mpsf\data\holdactions\holdAction_map.paa",{}]
				,{["openUI"] call (missionNamespace getVariable ["PO4_fnc_operations",{}])}
				,{}
				,3,false,101
			],[],"(['isMHQdeployed',[_target]] call MPSF_fnc_mhq) && (vehicle player isEqualTo player)"
			,true] spawn {sleep 0.3; _this call MPSF_fnc_addAction;};
		};
	};
	case "deactivate" : {
		_params params [["_trigger",objNull],["_target",objNull,[[],objNull]]];
		private _vehicle = attachedTo _trigger;
		if (isNull _vehicle) exitWith { /*["Unable to retrieve depot logic attached to trigger"] call BIS_fnc_error;*/ };
		[format ["MPSF_%1_Respawn_DeployMHQ_Action",_vehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
		[format ["MPSF_%1_Respawn_UndeployMHQ_Action",_vehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
		[format ["MPSF_%1_Respawn_RedeployMHQ_Action",_vehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
		[format ["MPSF_%1_Respawn_MissionyMHQ_Action",_vehicle call BIS_fnc_netId],player] call MPSF_fnc_removeAction;
	};
	case "init" : {
		_params params [["_vehicle",objNull,[objNull]],["_sideID",-1,[0]]];

		if (isNull _vehicle) exitWith { /*["Vehicle is not valid: ObjNull"] call BIS_fnc_error;*/ };

		if (_sideID < 0) then {
			_sideID = getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle >> "side");
		};

		if (isServer) then {
			_vehicle setVariable ["MPSF_RespawnMP_MHQ",true,true];
			_vehicle setVariable ["MPSF_RespawnMP_MHQside",_sideID,true];
		};

		if (hasInterface) then {
			if !(isNull (_vehicle getVariable ["MPSF_RespawnMP_MHQ_Trigger",objNull])) exitWith {};

			["MPSF_RespawnMP_onRespawnOnGetIn_EH","onGetIn",{
				params [["_unit",objNull,[objNull]],["_position","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];
				if (["isMHQdeployed",[_vehicle]] call MPSF_fnc_mhq) then {
					_unit action ["getOut",_vehicle];
					_unit action ["Eject",_vehicle];
				};
			}] call MPSF_fnc_addEventHandler;

			private _trigger = createTrigger ["EmptyDetector",_vehicle,false];
			_trigger setTriggerArea [6,6,getDir _vehicle,false,4];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activate',[thisTrigger]] call MPSF_fnc_mhq;"]
				,format["['deactivate',[thisTrigger]] call MPSF_fnc_mhq;"]
			];
			_trigger attachTo [_vehicle,[0,0,0]];
			_vehicle setVariable ["MPSF_RespawnMP_MHQ_Trigger",_trigger];

			if (_sideID >= 0) then {
				_vehicle setVariable ["VirtualDepot_Side",_sideID];
			};

			if (time > 0) then {
				["MPSF_Respawn_MHQCreated",[
					format["%1 MHQ Available.",[_vehicle] call MPSF_fnc_getCfgText],
					[player,true,"hq"] call MPSF_fnc_getCfgIconNATO
				]] call BIS_fnc_showNotification;
			};

			private _flagTexture = switch (_sideID) do {
				case 0 : {"\a3\data_f\flags\flag_red_co.paa"};
				case 1 : {"\a3\data_f\flags\flag_blue_co.paa"};
				case 2 : {"\a3\data_f\flags\flag_green_co.paa"};
				case 3 : {"\a3\data_f_orange\flags\flag_IDAP_CO.paa"};
				default {"\a3\data_f\flags\flag_white_co.paa"};
			};
			_vehicle forceFlagTexture _flagTexture;
		};

		true;
	};
	case "postInit" : {
		{ ["init",[_x]] call MPSF_fnc_mhq; } forEach (vehicles select { _x getVariable ["MPSF_RespawnMP_MHQ",false]; });

		["MPSF_RespawnMP_onMHQinit_EH","onMHQinit",{
			["init",_this] call MPSF_fnc_mhq;
		}] call MPSF_fnc_addEventHandler;

		["MPSF_RespawnMP_onDeployMHQ_EH","onDeployMHQ",{
			params [["_target",objNull,[objNull]],["_caller",objNull,[objNull]]];

			if (local _target) then {
				_target allowDamage false;
				_target lock 2;
				["setMHQdeployed",[_target,true]] call MPSF_fnc_mhq;
			};

			if (isServer) then {
				private _side = (_target getVariable ["MPSF_RespawnMP_MHQside",-1]) call BIS_fnc_sideType;
				private _handlerID = [_side,_target,format["MHQ #%1",mapGridPosition _target]] call BIS_fnc_addRespawnPosition;
				_target setVariable ["RespawnPositionID",_handlerID,true];
			};

			if (hasInterface) then {
				if (["isMHQfriendly",[_target,player]] call MPSF_fnc_mhq) then {
					["MPSF_Respawn_MHQDeployed",[
						format["%1 MHQ Deployed at #2.",[_target] call MPSF_fnc_getCfgText,mapGridPosition _target],
						[player,true,"hq"] call MPSF_fnc_getCfgIconNATO
					]] call BIS_fnc_showNotification;
					[sideunknown,"SentGenBaseUnlockRespawn"] call BIS_fnc_sayMessage;
				};
			};
			true;
		}] call MPSF_fnc_addEventHandler;

		["MPSF_RespawnMP_onUndeployMHQ_EH","onUndeployMHQ",{
			params [["_target",objNull,[objNull]],["_caller",objNull,[objNull]]];

			if (local _target) then {
				_target allowDamage true;
				_target lock 0;
				["setMHQdeployed",[_target,false]] call MPSF_fnc_mhq;
			};

			if (isServer) then {
				private _side = (_target getVariable ["MPSF_RespawnMP_MHQside",-1]) call BIS_fnc_sideType;
				(_target getVariable ["RespawnPositionID",[_side,-1]]) call BIS_fnc_removeRespawnPosition;
			};

			if (hasInterface) then {
				if (["isMHQfriendly",[_target,player]] call MPSF_fnc_mhq) then {
					["MPSF_Respawn_MHQUnDeployed",[
						format["%1 MHQ Undeployed at #2.",[_target] call MPSF_fnc_getCfgText,mapGridPosition _target],
						[player,true,"hq"] call MPSF_fnc_getCfgIconNATO
					]] call BIS_fnc_showNotification;
				};
			};

			true;
		}] call MPSF_fnc_addEventHandler;
	};
};