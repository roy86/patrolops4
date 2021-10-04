/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "requestAirdropSupply" : {
		_params params [["_target",objNull,[objNull]],["_dropPos",[0,0,0],[[]]],["_dropDir",0,[0]],["_cargo",[],[[]]]];

		if (isNull _target || _dropPos isEqualTo [0,0,0] || _cargo isEqualTo []) exitWith {};
		if !(["addAirdropRequest",_params] call MPSF_fnc_supportAirdrop) exitWith {};

		["MPSF_ClientAdd_onSmokeThrown_EH","onSmokeThrown",{
			params [["_target",objNull,[objNull]],["_smokeClass","",[""]],["_position",[0,0,0],[[]]]];
			if (["hasAirdropRequest",[_target]] call MPSF_fnc_supportAirdrop) then {
				private _request = ["getAirdropRequest",[_target]] call MPSF_fnc_supportAirdrop;
				if (_request isEqualTo []) exitWith { player sideChat "Failed to find data for Airdrop"; };
				_request params ["_group","_requestor","_dropPos","_dropDir","_cargo","_requestTime","_requestAvailable","_requestExpiry"];

				if !(_position distance2D _dropPos < 100) exitWith {
					player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"Need to deploy smoke within the drop zone"];
				};

				["MPSF_ClientAdd_onSmokeThrown_EH","onSmokeThrown"] call MPSF_fnc_removeEventHandler;
				//(["CfgMissionSupports","SupplyDrop","Vehicles",str side player] call MPSF_fnc_getCfgDataArray) params [["_vehicleType","",[""]]];

				private _vehicleType = (["CfgMissionSupports","SupplyDrops","Vehicles"] call MPSF_fnc_getCfgDataArray) param [(side player) call BIS_fnc_sideID,"",[""]];
				if !(_vehicleType isEqualTo "") then {
					["onRequestSupplyDrop",[_target,_position,_dropDir - 180,_cargo,_vehicleType],2] call MPSF_fnc_triggerEventhandler;
					player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"Support Request Airdop sent. Stand by!"];
				} else {
					["No Classnames for configured for vehicle supplydrop"] call BIS_fnc_error;
				};
				["removeAirdropRequest",[_target]] call MPSF_fnc_supportAirdrop;
			} else {
				player sideChat "No Supply Request Avaiable";
			};
		}] call MPSF_fnc_addEventHandler;

		player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"Throw smoke in drop zone to signal the drop."];
		true;
	};
	case "addAirdropRequest" : {
		_params params [["_target",objNull,[objNull]],["_dropPos",[0,0,0],[[]]],["_dropDir",0,[0]],["_cargo",[],[[]]]];

		if (["hasAirdropRequest",[_target]] call MPSF_fnc_supportAirdrop) exitWith {
			["removeAirdropRequest",[_target]] call MPSF_fnc_supportAirdrop;
		};

		private _requests =+ (missionNamespace getVariable ["MPSF_SuportRequests_SupplyDrops",[]]);
		_requests pushBack [
			group _target
			,_target
			,_dropPos
			,_dropDir
			,_cargo
			,MISSIONTIME
			,MISSIONTIME + 60
			,MISSIONTIME + 600
		];
		missionNamespace setVariable ["MPSF_SuportRequests_SupplyDrops",_requests];
		publicVariable "MPSF_SuportRequests_SupplyDrops";
		true;
	};
	case "getAirdropRequest" : {
		_params params [["_target",objNull,[objNull]]];
		private _requests =+ (missionNamespace getVariable ["MPSF_SuportRequests_SupplyDrops",[]]);
		private _request = [];
		{
			if ((_x select 0) isEqualTo (group _target)) exitWith {_request = _x};
		} forEach  _requests;
		_request;
	};
	case "hasAirdropRequest" : {
		_params params [["_target",objNull,[objNull]]];
		if (isNull _target) exitWith {false};
		private _requests = (missionNamespace getVariable ["MPSF_SuportRequests_SupplyDrops",[]]) apply {_x select 0};
		(group _target) in (_requests)
	};
	case "removeAirdropRequest" : {
		_params params [["_target",objNull,[objNull]]];
		private _requests =+ (missionNamespace getVariable ["MPSF_SuportRequests_SupplyDrops",[]]);
		{
			if ((_x select 0) isEqualTo (group _target)) exitWith {
				_requests deleteAt _forEachIndex;
				missionNamespace setVariable ["MPSF_SuportRequests_SupplyDrops",_requests];
				publicVariable "MPSF_SuportRequests_SupplyDrops";
			};
		} forEach  _requests;
	};
	case "airdrop" : {
		_params params [["_requestor",objNull,[objNull]],["_centre",[],[[]]],["_direction",0,[0]],["_dropTypes",[],[[]]],["_className","",[""]]];

		if (_centre isEqualTo [] || count _dropTypes isEqualTo 0 || _className isEqualTo "") exitWith {objNull};

		private _ingressPos = _centre getPos [5000,_direction - 180];
		private _egressPos = _centre getPos [3000,_direction];
		private _flyInHeight = 120;
		private _faction = (getNumber(configFile >> "CfgVehicles" >> _className >> "side")) call BIS_fnc_sideType;
		private _classNameSupplyBoxes = (["CfgMissionSupports","SupplyDrops","Ammoboxes"] call MPSF_fnc_getCfgDataArray) param [(side player) call BIS_fnc_sideID,"",[""]];

		_ingressPos set [2,_flyInHeight];
		_egressPos set [2,_flyInHeight];

		([_ingressPos,_faction,_className,_direction,true] call MPSF_fnc_createVehicle) params [["_targetPlane",objNull,[objNull]],["_targetCrew",[],[[]]]];
		_targetPlane flyInHeight _flyInHeight;
		_targetPlane setcaptive true;
		_targetPlane disableai "target";
		_targetPlane disableai "autotarget";
		_targetPlane setcombatmode "blue";
		//_targetPlane animatedoor ['Door_1_source',1];
		driver _targetPlane forceSpeed 80;

		_dropTypes = _dropTypes apply {
			private _cargo = [_x,position player getPos [10,_direction],0] call MPSF_fnc_createObject; //_cargo = [_x,[0,0,100],0] call MPSF_fnc_createObject;
			if (_targetPlane setVehicleCargo _cargo) then {_cargo} else {deletevehicle _cargo; objNull};
		};
		_dropTypes apply {
			if (typeOf _x in _classNameSupplyBoxes) then {
				["onNewAmmoBox",[_x],0] call MPSF_fnc_triggerEventhandler;
			};
		};

		if !(count (_dropTypes select {!(isNull _x)}) > 0) exitWith {
			{_targetPlane deletevehiclecrew _x;} foreach crew _targetPlane;
			deletevehicle _targetPlane;
			objNull
		};

		private _targetPlaneID = _targetPlane call BIS_fnc_netID;
		_wp0 = (group _targetPlane) addWaypoint [_centre,0];
		_wp0 setWaypointStatements ["true",format ["(%1 call BIS_fnc_objectFromNetID) animatedoor ['Door_1_source',1];",str _targetPlaneID]];
		_wp1 = (group _targetPlane) addWaypoint [_centre,0];
		_wp1 setWaypointStatements ["true",format ["(%1 call BIS_fnc_objectFromNetID) setVehicleCargo objnull;",str _targetPlaneID]];
		_wp2 = (group _targetPlane) addWaypoint [_egressPos,0];
		_wp2 setWaypointStatements ["true",format ["['MPSF_%1_EH','onEachFrame'] call MPSF_fnc_removeEventhandler; _vehicle = %1 call BIS_fnc_objectFromNetID; {_vehicle deletevehiclecrew _x;} foreach crew _vehicle; deletevehicle _vehicle;",str _targetPlaneID]];

		_targetPlane;
	};
	case "init" : {
		if (isServer) then {
			["MPSF_Server_onRequestSupplyDrop_EH","onRequestSupplyDrop",{
				params [["_requestor",objNull,[objNull]]];
				if (isNull _requestor) exitWith {};
				if ((missionNamespace getVariable ["MPSF_SupplyDrop_lastTime",MISSIONTIME]) <= MISSIONTIME) then {
					missionNamespace setVariable ["MPSF_SupplyDrop_lastTime",MISSIONTIME + 600];
					publicVariable "MPSF_SupplyDrop_lastTime";
					["airdrop",_this] call MPSF_fnc_supportAirdrop;
					["onRequestSupplyDropResponses",[_requestor,true],0] call MPSF_fnc_triggerEventhandler;
				} else {
					["onRequestSupplyDropResponses",[_requestor,false],0] call MPSF_fnc_triggerEventhandler;
				};
			}] call MPSF_fnc_addEventHandler;
		};
        if (hasInterface) then {
			["MPSF_Client_onStartSupplyDropRequest_EH","onStartSupplyDropRequest",{
				private _className = (["CfgMissionSupports","SupplyDrops","Ammoboxes"] call MPSF_fnc_getCfgDataArray) param [(side player) call BIS_fnc_sideID,"",[""]];
				if !(_className isEqualTo "") then {
					["requestAirdropSupply",[player,position player,round random 360,[_className]]] call MPSF_fnc_supportAirdrop;
				} else {
					["No Classnames for configured for supplydrop"] call BIS_fnc_error;
				};
			}] call MPSF_fnc_addEventhandler;
			["MPSF_Client_onRequestSupplyDropResponses_EH","onRequestSupplyDropResponses",{
				params [["_requestor",objNull,[objNull]],["_state",false,[false]]];
				if !(_requestor isEqualTo player) exitWith {};
				switch (true) do {
					case (_state) : {
						player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"Support Request Airdrop is inbound. Stand by for drop!"];
					};
					default {
						player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"Support Request Airdrop is not available at this time."];
					};
				};
			}] call MPSF_fnc_addEventHandler;
		};
	};
};