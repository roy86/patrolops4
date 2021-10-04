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
#define ICONACTIONREPAIR	"framework\data\holdactions\holdAction_repair_ca.paa"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "canLogistics" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		true;
	};
	case "canLift" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		if (isNull _vehicleTarget) exitWith { false };
		private _liftTypes = ["getCfgLiftTypes",[_vehicleTarget,true]] call MPSF_fnc_logistics;
		count _liftTypes > 0;
	};
	case "canCarryLoad" : {
		_params params [["_vehicleTarget",objNull,[objNull]]];
		if (isNull _vehicleTarget) exitWith { false };
		private _loadTypes = ["getCfgLoadTypes",[_vehicleTarget,true]] call MPSF_fnc_logistics;
		count _loadTypes > 0 || vehicleCargoEnabled _vehicleTarget;
	};
// Loading
	case "load" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];
		private _canLoad = ["canLoad",[_vehicle,_target]] call MPSF_fnc_logistics;
		private _vehicleTarget = _vehicle getVariable ["loadedTarget",objNull];
		private _targetTarget = _target getVariable ["loadedTarget",objNull];
		private _isBIDTransport = _target in (getVehicleCargo _vehicle) && ((isVehicleCargo _target) isEqualTo _vehicle);
		private _isLoaded = (_vehicle isEqualTo _targetTarget) && (_target isEqualTo _vehicleTarget);
		if !(_isLoaded || _isBIDTransport) then {
			if !(_canLoad) exitWith {false};
			["loadObject",[_vehicle,_target]] call MPSF_fnc_logistics;
		} else {
			["unloadObject",[_vehicle,_target]] call MPSF_fnc_logistics;
		};
	};
	case "loadObject" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];

		if !(["canLoad",[_vehicle,_target]] call MPSF_fnc_logistics) exitWith {};

		private _BISVehicleTransport = (_vehicle canVehicleCargo _target) param [0,false];
		private _loadTypes = ["getCfgLoadTypes",[_vehicle]] call MPSF_fnc_logistics;
		private _cfgVehicleTransport = (getVehicleCargo _vehicle isEqualTo []) && count (_loadTypes select {_target isKindof _x}) > 0;

		switch (true) do {
			case (vehicleCargoEnabled _vehicle && _BISVehicleTransport) : {_vehicle setVehicleCargo _target; };
			case (_cfgVehicleTransport && count (getVehicleCargo _vehicle) isEqualTo 0) : {
				private _loadOffset = ["getLoadOffset",[_vehicle,_target]] call MPSF_fnc_logistics;
				private _direction = switch (true) do {
					case (_target isKindOf "Air");
					case (_target isKindOf "LandVehicle") : { 180 };
					case (_target isKindOf "B_supplyCrate_F");
					case (_target isKindOf "Slingload_base_F");
					case (_target isKindOf "Cargo_base_F") : { 90 };
					default { 0 };
				};

				_target attachTo [_vehicle,_loadOffset];
				_target setDir _direction;

				_vehicle setVariable ["loadedTarget",_target,true];
				_target setVariable ["loadedTarget",_vehicle,true];
			};
			default {false};
		};
		
		player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],format ["%1 loaded onto %2",[_target] call MPSF_fnc_getCfgText,[_vehicle] call MPSF_fnc_getCfgText]];
	};
	case "unloadObject" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];
		if !(isNull (isVehicleCargo _target)) then {
			objNull setVehicleCargo _target;
		} else {
			if (isNull _vehicle) then { _vehicle = _target getVariable ["loadedTarget",objNull]};

			detach _target;

			private _dimension_max = (((boundingBox _target select 1 select 1) max (-(boundingBox _target select 0 select 1))) max ((boundingBox _target select 1 select 0) max (-(boundingBox _target select 0 select 0))));
			_target setPos [
				(getPos _vehicle select 0) - ( (_dimension_max + 1.5 - (boundingBox _vehicle select 0 select 1) ) * sin(getDir _vehicle) ),
				(getPos _vehicle select 1) - ( (_dimension_max + 1.5 - (boundingBox _vehicle select 0 select 1) ) * cos(getDir _vehicle) ),
				0
			];
			_target setVelocity [0, 0, 0];

			_vehicle setVariable ["loadedTarget",nil,true];
			_target setVariable ["loadedTarget",nil,true];
		};
		player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],format ["%1 unloaded from %2",[_target] call MPSF_fnc_getCfgText,[_vehicle] call MPSF_fnc_getCfgText]];
	};
	case "getLoadOffset" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];

		private _varY = 0;
		switch (true) do {
			case (_vehicle isKindOf "Truck_01_base_F") : {
				switch (true) do {
					case (_target isKindOf "Slingload_base_F");
					case (_target isKindOf "Cargo_base_F") : { _varY = -1.8 };
					default { _varY = 0 };
				};
			};
			case (_vehicle isKindOf "Truck_02_base_F") : {
				switch (true) do {
					case (_target isKindOf "APC_Tracked_02_base_F") : { _varY = 0 };
					default { _varY = -1.4 };
				};
			};
			case (_target isKindof "B_supplyCrate_F") : { _varY = -20; };
			default { _varY = 0 };
		};

		private _varZ = 0;
		switch (true) do {
			case (_target isKindof "B_supplyCrate_F") : { _varZ = -11.8; };
			default { _varZ = 0 };
		};

		private _bbr = boundingBoxReal _vehicle;
		private _p1 = _bbr select 0;
		private _p2 = _bbr select 1;
		private _maxWidth = abs ((_p2 select 0) - (_p1 select 0)) / 2;
		private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
		private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));

		[0,(_maxLength/2*(-1))+(_varY),(_maxHeight/2)-0.7+(_varZ)];
		[0,_varY,_varZ]
	};
	case "canLoad" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];

		if (isNull _vehicle) exitWith {false};

		private _loadTypes = ["getCfgLoadTypes",[_vehicle]] call MPSF_fnc_logistics;
		if (isNull _target) then {
			count _loadTypes > 0 || vehicleCargoEnabled _vehicle;
		} else {
			private _vehicleIsEmpty = isNull (_vehicle getVariable ["loadedTarget",objNull]);
			private _targetIsEmpty = isNull (_target getVariable ["loadedTarget",objNull]);
			private _BISVehicleTransport = (_vehicle canVehicleCargo _target) param [0,false];
			private _cfgVehicleTransport = (getVehicleCargo _vehicle isEqualTo []) && count (_loadTypes select {_target isKindof _x}) > 0;

			(_vehicleIsEmpty) && (_targetIsEmpty) && (_BISVehicleTransport || _cfgVehicleTransport)
		};
	};
	case "isLoaded" : {
		_params params [["_vehicle",objNull,[objNull]]];
		!(getVehicleCargo _vehicle isEqualTo []) || !(isNull (_vehicle getVariable ["loadedTarget",objNull])) || !(isNull isVehicleCargo _vehicle)
	};
// Towing
	case "tow" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];
		private _canTow = ["canTow",[_vehicle,_target]] call MPSF_fnc_logistics;
		private _vehicleTarget = _vehicle getVariable ["towTarget",objNull];
		private _targetTarget = _target getVariable ["towTarget",objNull];
		private _isTowing = (_vehicle isEqualTo _targetTarget) && (_target isEqualTo _vehicleTarget);
		if !(_isTowing) then {
			if !(_canTow) exitWith {false};
			["towObject",[_vehicle,_target]] call MPSF_fnc_logistics;
		} else {
			["detachObject",[_vehicle,_target]] call MPSF_fnc_logistics;
		};
	};
	case "towObject" : {
		["attachRopes",_params] call MPSF_fnc_towing;
	};
	case "detachObject" : {};
	case "canTow" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];

		if (isNull _vehicle) exitWith {false};
		private _towTypes = ["getCfgTowTypes",[_vehicle]] call MPSF_fnc_logistics;
		private _vehicleTarget = _vehicle getVariable ["towTarget",objNull];
		private _targetTarget = _target getVariable ["towTarget",objNull];
		if (isNull _target) then {
			if (_vehicle isKindOf "LandVehicle") exitWith {
				canMove _vehicle && !(isEngineOn _vehicle)
			};
			false
		} else {
			private _cfgVehicleTransport = count (_towTypes select {_target isKindof _x}) > 0;
			(isNull _vehicleTarget) && (isNull _targetTarget) && _cfgVehicleTransport
		};
	};
// Lifting
	case "lift" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];
		if !(isLifting) then {
			["liftObject",[_vehicle,_target]] call MPSF_fnc_logistics;
		} else {
			["dropObject",[_vehicle,_target]] call MPSF_fnc_logistics;
		};
	};
	case "liftObject" : {};
	case "dropObject" : {};
// Configuration
	case "getCfgTowEnabled" : { ["CfgMissionFramework","Logistics","enableTow"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgTowTypes" : {
		_params params [["_vehicle",objNull,[objNull]],["_resolve",true,[false]]];
		if (isNull _vehicle) exitWith { [] };
		["landvehicle","plane"]
	};
	case "getCfgLiftEnabled" : { ["CfgMissionFramework","Logistics","enableLift"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgLiftTypes" : {
		_params params [["_vehicle",objNull,[objNull]],["_resolve",true,[false]]];
		if (isNull _vehicle) exitWith { [] };
		private _cfgParents = [configFile >> "CfgVehicles" >> typeOf _vehicle,true] call BIS_fnc_returnParents;
		_cfgParents = _cfgParents apply { [_x,["CfgMissionFramework","Logistics",_x,"liftTypes"] call MPSF_fnc_getCfgDataArray]; };
		_cfgParents = _cfgParents select { count (_x select 1) > 0};
		if (_resolve && count _cfgParents > 0) then {
			_cfgParents = (_cfgParents select 0) select 1;
		};
		_cfgParents;
	};
	case "getCfgLoadEnabled" : { ["CfgMissionFramework","Logistics","enableLoad"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgLoadTypes" : {
		_params params [["_vehicle",objNull,[objNull]],["_resolve",true,[false]]];
		if (isNull _vehicle) exitWith { [] };
		["Cargo_Base_F","Slingload_base_F"]
	};
// Init
	case "preInit" : {};
	case "postInit" : {
		[] spawn {
			waitUntil {!(isNull player)};
			["MPSF_Logistics_openUIAction_EH","onGetIn",{
				params [["_unit",objNull,[objNull]],["_position","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];
				["MPSF_Logistics_openUI",_vehicle,format["<t color='#ffC600'>%1</t>","Vehicle Logistics Menu"], // TODO: STRING
					{ ([] call BIS_fnc_displayMission) createDisplay "RscDisplayLogistics"; },
					[],
					"(['canLogistics',[_target]] call MPSF_fnc_logistics)"
					+ " && (driver vehicle player isEqualTo driver _target)"
					+ " && (speed _target < 0.1)"
					+ " && (damage _target < 0.8)"
					,true,false,105
				] spawn {sleep 0.1; _this call MPSF_fnc_addAction};
			}] call MPSF_fnc_addEventHandler;
		};
		if (isServer) then {
			//
		};
		if (hasInterface) then {
			//
		};
		["MPSF_Logistics_onAttachObject_EH","onAttachObject",{
			params [["_requestor",objNull,[objNull]],["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]],["_action","",[""]]];
			if (local _vehicle) then {
				[_action,[_vehicle,_target]] call MPSF_fnc_logistics;
			};
		}] call MPSF_fnc_addEventhandler;
	};
	case "init" : {};
};