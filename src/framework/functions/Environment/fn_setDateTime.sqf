/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-31
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})

params [
	["_newDate",[],[[],0]],
	["_fade",false,[false]]
];

if !(isServer) exitWith {};
if (_newDate isEqualTo []) exitWith {};

date params ["_year","_month","_day","_hour","_minute"];

if (_newDate isEqualType 0) then {
	if (time == 0) then {_newDate = floor _newDate - _hour;};
	_newDate = [_year,_month,_day,_hour + floor _newDate,(_minute + (_newDate % 1) * 60)];
};

if (_newDate isEqualTypeArray [0,0]) then {
	_newDate params [["_newHour",0,[0]],["_newMin",0,[0]]];
	_newDate = [_year,_month,_day,(_hour + floor _newHour),(_minute + _newMin)];
};

if !(_newDate isEqualTypeParams [0,0,0,0,0]) exitWith { ["Invalid Date Format configured",_newDate] call BIS_fnc_error; };

if (_fade) then {
	["onTimeChange",[_newDate,_fade],0] call MPSF_fnc_triggerEventhandler;
	_newDate spawn { sleep 8; setdate _this; };
} else {
	setdate _newDate;
};