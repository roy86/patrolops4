/*
	Author: RoyEightySix (https://www.roy86.com.au)
	Date: 2021-02-14
	
	Description:
		No description added yet.
	
	Parameter(s):
		_localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
	
	Returns:
		Function reached the end [BOOL]
*/
#define MARKER_SIZE 		0.65
#define COLOURWHITE			[1,1,1,1]
#define COLOURTEAL			[1,0.3,0.3,0.7]
#define MISSIONTIME			(if (isMultiplayer) then {serverTime} else {time})
#define ICONEMPTY			"#(argb,8,8,3)color(0,0,0,0)"
#define ICONBACK			"\a3\ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa"
#define ICONREFUEL			"\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa"
#define ICONRELOAD			"\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa"
#define ICONREPAIR			"\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa"
#define ICONCONTAINER		"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\container_ca.paa"
#define ICONADD				"\a3\ui_f\data\GUI\Rsc\RscDisplayArsenal\cargoMisc_ca.paa"
#define ICONPOINTER			"\A3\ui_f\data\IGUI\Cfg\simpleTasks\interaction_pointer2_ca.paa"
#define ICONSELECTORF		"\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "mouseMoving" : {
		params ["_ctrl", "_mX", "_mY"];
		MPSF_UI_mouse = [_mX,_mY];
	};
	case "getNearestObjects" : {
		(nearestObjects [vehicle player,["Landvehicle","Cargo_Base_F","Slingload_base_F"],20]) select {
			[vehicle player,_x] params ["_vehicle","_target"];
			!(_target isEqualTo _vehicle)
			&& (
				["canLoad",[_vehicle,_target]] call MPSF_fnc_logistics
				|| ["canTow",[_vehicle,_target]] call MPSF_fnc_logistics
			)
		};
	};
	case "getNearestObject" : {
		private _nearbyObjects = ["getNearestObjects"] call MPSF_fnc_logisticsUI;
		[_nearbyObjects,vehicle player] call MPSF_fnc_getNearestObject;
	};
	case "ctrlButtonSelectHardpoint" : {
		_params params ["_hardpointType","_netID"];
		missionNamespace setVariable [format["MPSF_Logistics_%1_ObjectSelect",_hardpointType],_netID];
	};
	case "getButtonSelectHardpoint" : {
		_params params ["_hardpointType"];
		missionNamespace getVariable [format["MPSF_Logistics_%1_ObjectSelect",_hardpointType],""];
	};
	case "ctrlButtonSelect" : {
		_params params [["_index",0,[0,controlNull]],["_data",[],[[]]]];
		if (_index isEqualType controlNull) then {_index = ctrlIDC _index};
		switch (_index) do {
			case 3002 : {
				private _vehicle = vehicle player;
				private _vehicleAction = ["getButtonSelectHardpoint",["ownerVehicle"]] call MPSF_fnc_logisticsUI;
				private _targetSelected = ["getButtonSelectHardpoint",["targetVehicle"]] call MPSF_fnc_logisticsUI;
				private _target = _targetSelected call BIS_fnc_objectFromNetId;

				if (isNull _target) exitWith { ["Invalid Logistics Selections"] call BIS_fnc_error; false };
				if !(isNull isVehicleCargo _target) then {_vehicle = isVehicleCargo _target; _vehicleAction = "load"};

				["onAttachObject",[player,_vehicle,_target,_vehicleAction],0] call MPSF_fnc_triggerEventhandler;

				["ctrlButtonSelectHardpoint",["ownerVehicle",""]] call MPSF_fnc_logisticsUI;
				["ctrlButtonSelectHardpoint",["targetVehicle",""]] call MPSF_fnc_logisticsUI;

				true;
			};
			case 3003 : {
				(uiNamespace getVariable ["RscDisplayActive",displayNull]) closeDisplay 0;
			};
			default {systemChat str _index};
		};
	};
	case "getPointTarget" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["MPSF_Logistics_target",objNull];
	};
	case "getPointAction" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["MPSF_Logistics_action",""];
	};
	case "setPointTarget" : {
		_params params [["_target",objNull,[objNull]],["_linkedObject",objNull,[objNull]],["_action","",[""]]];
		_target setVariable ["MPSF_Logistics_target",_linkedObject,true];
		_target setVariable ["MPSF_Logistics_action",_action,true];
	};
	case "onLoadLogisticsUI" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayActive",(_display)];
		[_display,"RscDisplayLogistics"] call MPSF_fnc_loadCfgDisplayVariables;

		private _ctrlTitleLogo = uiNamespace getVariable ["RscLogisticsCtrlTitleLogo",controlNull];
		_ctrlTitleLogo ctrlEnable false;
		_ctrlTitleLogo ctrlSetFade 0.2;
		_ctrlTitleLogo ctrlCommit 0;

		//(uiNamespace getVariable ["RscLogisticsMouseArea",controlNull]) ctrladdeventhandler ["mousebuttonclick","['ctrlButtonSelect',[]] call MPSF_fnc_virtualDepot;"];

		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscLogisticsButtonVehicleSave","buttonClick",{['ctrlButtonSelect',_this] call MPSF_fnc_logisticsUI;}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscLogisticsButtonCloseUI","buttonClick",{['ctrlButtonSelect',_this] call MPSF_fnc_logisticsUI;}]] call MPSF_fnc_itemAmrelTablet;

		["start",[
			_display
			,(uiNamespace getVariable ["RscLogisticsMouseArea",controlNull])
			,(uiNamespace getVariable ["RscLogisticsMouseBlock",controlNull])
			,vehicle player
		]] call (missionNamespace getVariable ["MPSF_fnc_CameraUI",{}]);

		["onEachFrame"] call MPSF_fnc_logisticsUI;

		[] spawn {
			waitUntil {
				if (isNull (uiNamespace getVariable ["RscDisplayActive",displayNull])) exitWith {true};
				!(alive player)
			};
			["onUnloadLogisticsUI"] call MPSF_fnc_logisticsUI;
		};
	};
	case "onUnloadLogisticsUI" : {
		["end"] call (missionNamespace getVariable ["MPSF_fnc_CameraUI",{/*["No Namespace Function %1 Found",str "MPSF_fnc_CameraUI"] call BIS_fnc_error;*/}]);
	};
	case "onEachFrame" : {
		["MPSF_Logistics_UI_onEachFrame_EH","onEachFrame",{
			private _ctrlBackgroundName = "RscLogisticsIconBack%1";
			private _ctrlIconName = "RscLogisticsIcon%1";
			private _ctrl = controlNull;
			private _vehicle = vehicle player;
			private _bbr = boundingBoxReal _vehicle;
			private _p1 = _bbr select 0;
			private _p2 = _bbr select 1;
			private _maxWidth = abs ((_p2 select 0) - (_p1 select 0)) / 2;
			private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
			private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
			private _vehicleLoaded = count (getVehicleCargo _vehicle) > 0;
			private _vehicleSelected = ["getButtonSelectHardpoint",["ownerVehicle"]] call MPSF_fnc_logisticsUI;
			private _targetSelected = ["getButtonSelectHardpoint",["targetVehicle"]] call MPSF_fnc_logisticsUI;
			private _targetVehicle = _targetSelected call BIS_fnc_objectFromNetId;

			private _targets = ["getNearestObjects"] call MPSF_fnc_logisticsUI;
			_targets append (getVehicleCargo _vehicle);

			for "_i" from 3 to 19 do {
				private _ctrlMoved = false;
				if ((_i - 3) < count _targets) then {
					private _target = _targets param [_i-3,objNull];
					if !(isNull _target) then {
						private _targetNetID = _target call BIS_fnc_netId;

						private _targetCanLoad = _vehicle canVehicleCargo _target;

						private _pos = _target modelToWorldVisual [0,0,0];
						_uiPos = worldtoscreen _pos;
						if (count _uiPos > 0 && !(_pos isEqualTo [0,0,0])) then {
							_ctrlMoved = true;
							_fade = _fade min (_uiPos distance getMousePosition);
							_ctrlPos = [];
							_ctrl = controlNull;
							{
								_ctrl = uiNamespace getVariable [format [_x,_i],controlNull];
								_ctrlPos = ctrlposition _ctrl;
								_ctrlPos set [0,(_uiPos select 0) - (_ctrlPos select 2) * 0.5];
								_ctrlPos set [1,(_uiPos select 1) - (_ctrlPos select 3) * 0.5];
								_ctrl ctrlsetposition _ctrlPos;
								_ctrl ctrlcommit 0;
							} foreach [_ctrlBackgroundName,_ctrlIconName];

		 					if !((["getButtonSelectHardpoint",["targetVehicle"]] call MPSF_fnc_logisticsUI) isEqualTo _targetNetID) then {
								_ctrl ctrlSetEventHandler ["buttonClick",format ["['ctrlButtonSelectHardpoint',['targetVehicle',%1]] call MPSF_fnc_logisticsUI;",str _targetNetID]];
								_ctrl ctrlSetTooltip format ["%1","Select ",[_target] call MPSF_fnc_getCfgText];
								_ctrl ctrlSetText ICONADD;
							} else {
								_ctrl ctrlSetEventHandler ["buttonClick",format ["['ctrlButtonSelectHardpoint',['targetVehicle',%1]] call MPSF_fnc_logisticsUI;",str ""]];
								_ctrl ctrlSetTooltip "Cancel";
								_ctrl ctrlSetText ICONCONTAINER;
							};
						};
					};
				};

				if !(_ctrlMoved) then {
					{
						_ctrl = uiNamespace getVariable [format [_x,_i],controlNull];
						_ctrl ctrlSetEventHandler ["buttonClick",""];
						_ctrl ctrlsetposition [-1,-1];
						_ctrl ctrlcommit 0;
					} foreach [_ctrlBackgroundName,_ctrlIconName];
				};
			};
			if (count _targets > 0) then {
				{
					_x params ["_hardpointType","_hardpoints"];
					private _indexID = _forEachIndex;
					if (count _hardpoints == 3) then {
						private _pos = _vehicle modelToWorldVisual _hardpoints;
						_uiPos = worldtoscreen _pos;
						if (count _uiPos > 0 && !(_pos isEqualTo [0,0,0])) then {
							_ctrlMoved = true;
							_fade = _fade min (_uiPos distance getMousePosition);
							_ctrlPos = [];
							_ctrl = controlNull;
							{
								_ctrl = uiNamespace getVariable [format [_x,_indexID],controlNull];
								_ctrlPos = ctrlposition _ctrl;
								_ctrlPos set [0,(_uiPos select 0) - (_ctrlPos select 2) * 0.5];
								_ctrlPos set [1,(_uiPos select 1) - (_ctrlPos select 3) * 0.5];
								_ctrl ctrlsetposition _ctrlPos;
								_ctrl ctrlcommit 0;
							} foreach [_ctrlBackgroundName,_ctrlIconName];

							if !((["getButtonSelectHardpoint",["ownerVehicle"]] call MPSF_fnc_logisticsUI) isEqualTo _hardpointType) then {
								_ctrl ctrlSetEventHandler ["buttonClick",format ["['ctrlButtonSelectHardpoint',[%1,%2]] call MPSF_fnc_logisticsUI;",str "ownerVehicle",str _hardpointType]];
								_ctrl ctrlSetTooltip format ["Set %1 Point",_hardpointType];
								_ctrl ctrlSetText ICONADD;
							} else {
								_ctrl ctrlSetEventHandler ["buttonClick",format ["['ctrlButtonSelectHardpoint',[%1]] call MPSF_fnc_logisticsUI;",str "ownerVehicle"]];
								_ctrl ctrlSetTooltip "Cancel";
								_ctrl ctrlSetText ICONREPAIR;
							};
						};
					};
				} forEach [
				//	["tow",if (["canTow",[_vehicle]] call MPSF_fnc_logistics) then {[0,-(_maxLength/3),0]} else {[0,10,0]}],
					["load",if (["canLoad",[_vehicle]] call MPSF_fnc_logistics) then {[0,-(_maxLength/10),1]} else {[]}]
				//	["lift",if (_vehicle isKindOf "Helicopter") then {[0,0,-1]} else {[]}]
				];
			};

			switch (true) do {
				case !(isNull isVehicleCargo _targetVehicle) : { ["setCtrlText",["RscLogisticsButtonVehicleSave",format ["%1 %2","Unload",[_targetVehicle] call MPSF_fnc_getCfgText]]] call MPSF_fnc_itemAmrelTablet; };
				case !(_vehicleSelected isEqualTo "" || _targetSelected isEqualTo "") : { ["setCtrlText",["RscLogisticsButtonVehicleSave",format ["%1 %2",toUpper _vehicleSelected,[_targetVehicle] call MPSF_fnc_getCfgText]]] call MPSF_fnc_itemAmrelTablet; };
				case (count _targets == 0) : { ["setCtrlText",["RscLogisticsButtonVehicleSave","No Objects or Vehicles Nearby"]] call MPSF_fnc_itemAmrelTablet; };
				default { ["setCtrlText",["RscLogisticsButtonVehicleSave","Select an Object to Load"]] call MPSF_fnc_itemAmrelTablet; };
			};

			private _display = uiNamespace getVariable ["RscDisplayActive",displayNull];
			if (isNull _vehicle || !(alive player) || isNull _display) exitWith {
				["MPSF_Logistics_UI_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			};
		}] call MPSF_fnc_addEventHandler;
	};
};