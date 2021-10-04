/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-14
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})
#define LOGFACTOR (1-(worldsize/60000))

params [["_modelID","",[""]],["_position",[0,0,0],[[]]],["_direction",0,[0]],["_distance",0,[0]]];

private _logRegAttr = ["PatrolOperations","models",_modelID] call MPSF_fnc_getCfgDataArray;

// Process Model
private _logRegScore = 0;
private _debug = [];
{
	_x params [["_varType","",[""]],["_coef",0,[0]],["_score","0",[""]]];
	_debug pushBack [_varType,call compile _score,_coef * (call compile _score)];
	_logRegScore = _logRegScore + (_coef * (call compile _score));
} forEach _logRegAttr;

private _logScore = 1/(1+exp(-(_logRegScore)*(LOGFACTOR max 0.3)));
private _logTrigger = _logScore >= random 1;

if (!isMultiplayer && {(getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1}) then {
    _debug pushBack [_logRegScore,_logScore,_logTrigger];
    hintSilent (_debug joinString "\n");
    diag_log (_debug joinString "\n");

    if (_logTrigger) then {
        [str [_modelID,_position],_position,nil,nil,nil,"ColorGreen"] call MPSF_fnc_createMarker;
    } else {
        [str [_modelID,_position],_position,nil,nil,nil,"ColorRed"] call MPSF_fnc_createMarker;
    };
};

_logTrigger;