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
#define RALLYTYPES ["Land_TentSolar_01_sand_F","Land_TentSolar_01_olive_F","Land_TentSolar_01_bluewhite_F","Land_TentSolar_01_redwhite_F"]

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
    case "isEnabled" : {
        if ((["MPSFRespawnMPRallypoints",1] call BIS_fnc_getParamValue) isEqualTo 0) exitWith { false };

        private _cfg = ["CfgRespawnMP","rallypointsEnable"] call BIS_fnc_getCfg;
        if (isNumber _cfg) exitWith {getNumber _cfg == 1};
        if (isText _cfg) exitWith {missionNamespace getVariable [getText _cfg,true]};
        true;
    };
	case "canDeploy" : {
		_params params [["_target",objNull,[objNull]]];

        if !(["isEnabled"] call MPSF_fnc_rallypoint) exitWith {};
        if !({_target distance2D ((_x select 0) call BIS_fnc_position) < 1000} count (["getRespawnPositions",[_target]] call MPSF_fnc_respawnMP) == 0) exitWith {false};

		vehicle _target isEqualTo _target && {alive _target} && {_target isEqualTo leader group _target} && {isTouchingGround _target}
	};
	case "postInit" : {
        if !(["isEnabled"] call MPSF_fnc_rallypoint) exitWith {};

        ["MPSF_RespawnMP_onDeployRallyPoint_EH","onDeployRallyPoint",{
            params [["_target",objNull,[objNull]],["_requestor",objNull,[objNull]]];

            if (local _target) then {
                [format ["MPSF_RespawnMP_UndeployRallyPoint_%1_Action",_target call BIS_fnc_netId],_target,"Pack Up Rallypoint",[
                    ["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
                    ,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
                    ,{ ["onUndeployRallyPoint",[_target,_caller],0] spawn MPSF_fnc_triggerEventHandler; }
                    ,{}
                    ,3,false,102
                ],[],"true"
                ,true] spawn { sleep 0.2; _this call MPSF_fnc_addAction; };
            };

			if (isServer) then {
                private _owner = _target getVariable ["MPSF_Rallypoint_Owner",objNull];
				private _handlerID = [_owner,_target,format["Rally #%1",mapGridPosition _target]] call BIS_fnc_addRespawnPosition;
				_target setVariable ["RespawnPositionID",_handlerID,true];
			};

			if (hasInterface) then {
				if (group _requestor isEqualTo group player) then {
					["MPSF_Respawn_RallyDeployed",[
                        format ["Rallypoint Deployed #%1",mapGridPosition _target],
						[player,true,"hq"] call MPSF_fnc_getCfgIconNATO
                    ]] call BIS_fnc_showNotification;
					[sideunknown,"SentGenBaseUnlockRespawn"] call BIS_fnc_sayMessage;
				};
			};
        }] call MPSF_fnc_addEventHandler;

        ["MPSF_RespawnMP_onDeployRallyPoint_EH","onUndeployRallyPoint",{
            params [["_target",objNull,[objNull]],["_requestor",objNull,[objNull]]];

            private _rallyPos = position _target;
            if (isServer) then {
                private _owner = _target getVariable ["MPSF_Rallypoint_Owner",objNull];
				(_target getVariable ["RespawnPositionID",[_owner,-1]]) call BIS_fnc_removeRespawnPosition;
                deleteVehicle _target;
            };

			if (hasInterface) then {
				if (group _requestor isEqualTo group player) then {
					["MPSF_Respawn_RallyUnDeployed",[
                        format ["Rallypoint Removed at #%1",mapGridPosition _rallyPos],
						[player,true,"hq"] call MPSF_fnc_getCfgIconNATO
                    ]] call BIS_fnc_showNotification;
				};
			};
        }] call MPSF_fnc_addEventHandler;

        if (hasInterface) then {
            [] spawn {
				waitUntil { !(isNull player) };
                [format ["MPSF_RespawnMP_DeployRallyPoint_%1_Action",player call BIS_fnc_netId],player,"Deploy Rallypoint",[
                    ["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{[_caller,"AinvPknlMstpSlayWrflDnon_medic"] call MPSF_fnc_animateUnit;}]
                    ,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
                    ,{
                        private _type = ((["CfgRespawnMP","rallypointType"] call MPSF_fnc_getCfgDataArray) + RALLYTYPES) select ((side _target) call BIS_fnc_sideID);
                        private _rallypoint = createVehicle [_type, _target getPos [1,direction _target], [], 0, "CAN_COLLIDE"];
                        _rallypoint setDir (direction _target);
                        _rallypoint setVariable ["MPSF_Rallypoint_F",true,true];
                        _rallypoint setVariable ["MPSF_Rallypoint_Owner",_target,true];
                        missionNamespace setVariable ["MPSF_RespawnMP_rallypoint",_rallypoint];

                        [_caller,""] call MPSF_fnc_animateUnit;

                        ["onDeployRallyPoint",[_rallypoint,_caller],0] spawn MPSF_fnc_triggerEventHandler;
                    }
                    ,{[_caller,""] call MPSF_fnc_animateUnit;}
                    ,3,false,103
                ],[],"(['canDeploy',[_target]] call MPSF_fnc_rallypoint)"
                ,true] spawn { sleep 0.1; _this call MPSF_fnc_addAction; };
            };
        };
	};
};
//