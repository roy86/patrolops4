/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-03-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_attributes",0,["",0]],["_instant",true,[false]]];

private _availableTypes = ["Params","MPSF_Param_MissionTime","texts"] call MPSF_fnc_getCfgDataArray;
if (_availableTypes isEqualTo []) then {
    _availableTypes = ["Early Foggy Morning","Morning","Midday","Afternoon","Evening","Late Evening","Night"];
};

if (_attributes isEqualType 0) then {
    _attributes = _availableTypes select (_attributes min (count _availableTypes - 1))
};

if (_attributes isEqualType "") then {
    _attributes = (_attributes splitString " ") apply {toLower _x};
};

date params ["_year","_month","_day","_hour","_minute"];
private _adjustHour = 0;
private _overcast = 0;
private _fog = [0,0.1,15];

{
    switch (_x) do {
        case "midnight";
        case "night" : { _hour = 0; };
        case "dawn" : { _hour = 6; };
        case "morning" : { _hour = 9; };
        case "afternoon" : { _hour = 15; };
        case "evening" : { _hour = 17; };
        case "dusk" : { _hour = 19; };
        case "midday" : { _hour = 12; };
        case "early" : {_adjustHour = -2; };
        case "late" : {_adjustHour = 2; };
        case "foggy" : {_fog set [0,0.5];};
        case "dense" : {_fog set [1,0.1];};
        case "sunny";
        case "clear" : { _overcast = 0; };
        case "cloudy" : { _overcast = 0.25; };
        case "overcast" : { _overcast = 0.5; };
        case "rainy" : { _overcast = 0.75; };
        case "stormy" : { _overcast = 1; };
    };
} forEach _attributes;

if (isServer) then {
    [_overcast,_fog] call MPSF_fnc_setWeather;
    [[_year,_month,_day,_hour+_adjustHour,_minute],!_instant] call MPSF_fnc_setDateTime;
};

true