/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",player,[objNull]]];

if (alive _target) then {
    // Event Handler: Vehicle Player moved position
    private _vehicle = vehicle _target;
    private _oldPosition = _target getVariable ["MPSF_Player_var_previousPositionASL",[0,0,0]];
    private _oldDistance = _target getVariable ["MPSF_Player_var_distanceTraveled",0];
    private _newPosition = getPosASL _vehicle;
    private _incrementalDistance = _newPosition distance2D _oldPosition;
    private _vehicleDistance = switch (true) do {
        case (_vehicle isKindOf "CaManBase") : {150};
        case (_vehicle isKindOf "Ship");
        case (_vehicle isKindOf "Land") : {500};
        case (_vehicle isKindOf "Helicopter") : {1000};
        case (_vehicle isKindOf "Air") : {5000};
        default {150};
    };

    if (_incrementalDistance > _vehicleDistance) then {
        _target setVariable ["MPSF_Player_var_previousPositionASL",_newPosition];
        _target setVariable ["MPSF_Player_var_distanceTraveled",_oldDistance + _incrementalDistance];
        ["HasMoved",[_oldPosition,_newPosition,round(_oldDistance + _incrementalDistance),round(_incrementalDistance)],true] call MPSF_fnc_triggerEventHandler;
    };

    // Event Handler: Unit UAV Connection State Change
    private _oldUAV = _target getVariable ["MPSF_Player_var_connectedUAV",objNull];
    private _newUAV = getConnectedUAV _target;
    if !(_oldUAV isEqualTo _newUAV) then {
        if !(isNull _oldUAV) then {
            ["UAVdisconnected",[_target,_oldUAV],true] call MPSF_fnc_triggerEventHandler;
        };
        if !(isNull _newUAV) then {
            ["UAVconnected",[_target,_newUAV],true] call MPSF_fnc_triggerEventHandler;
        };
        _target setVariable ["MPSF_Player_var_connectedUAV",_newUAV];
    };

    private _iedTypes = ["CfgMissionTasks","iedTypes"] call MPSF_fnc_getCfgDataArray;
    private _ieds = (nearestObjects [_target,_iedTypes,100]) select {_x getVariable ["MPSF_IED",false] && !(_x getVariable ["MPSF_IED_BOOM",false])};
    private _iedDist = if (vehicle player isEqualTo player) then {3} else {15};
    if (count _ieds > 0) then {
        private _units = allPlayers + units group player;
        {
            private _ied = _x;
            private _nearestPlayer = ((_ied nearEntities ["CaManbase",25])-[_ied]) param [0,objNull];
            switch (true) do {
                case (_nearestPlayer isEqualTo player);
                case (driver vehicle player isEqualTo player && vehicle player isKindOf "LandVehicle") : {
                    if (player distance _ied < _iedDist) then {
                        _ied setVariable ["MPSF_IED_BOOM",true,true];
                        ["onTriggerIED",[_ied],2] call MPSF_fnc_triggerEventhandler;
                    };
                };
            };
        } forEach _ieds;
    };
};