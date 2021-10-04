/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]]];

if !(_target isEqualTo player) exitWith {}; 

// Event Handler: Vehicle Player moved position
private _vehicle = vehicle _target;
private _oldPosition = _target getVariable ["MPSF_Player_var_previousPositionASL",[0,0,0]];
private _oldDistance = _target getVariable ["MPSF_Player_var_distanceTraveled",0];
private _newPosition = getPosASL _vehicle;
private _incrementalDistance = _newPosition distance2D _oldPosition;

private _vehicleDistance = switch (true) do {
    case (_vehicle isKindOf "CaManBase") : {200};
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