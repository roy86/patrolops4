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

params [["_newDate",[],[[]]],["_fade",false,[false]]];

if !(_fade) exitWith {};

if !(isNil "MPSF_onTimeChange_Fade") then { terminate MPSF_onTimeChange_Fade; };

missionNamespace setVariable ["MPSF_onTimeChange_Fade", _newDate spawn {
	private _showEffects = isnull curatorcamera && hasinterface;
	private _dateNumberOld = datetonumber date;
	private _yearOld = date select 0;

	//--- Transition effect
	if (_showEffects) then {
		bis_fnc_setDate_soundvolume = missionnamespace getvariable ["bis_fnc_setDate_soundvolume",soundvolume];
		1 fadesound 0;
		("bis_fnc_setDate" call bis_fnc_rscLayer) cuttext ["","black out"];
	};

	sleep 1;

	//--- Wait until time is synced from server
	private ["_diffMinute","_diffHour","_diffDay","_diffMonth","_diffYear"];
	_timeout = time + 10;
	waituntil {
		_diffDate = numbertodate [date select 0,datetonumber date - _dateNumberOld];
		_diffYear = (_diffDate select 0) - _yearOld;
		_diffMonth = (_diffDate select 1) - 1;
		_diffDay = (_diffDate select 2) - 1;
		_diffHour = (_diffDate select 3);
		_diffMinute = (_diffDate select 4);
		_diffMinute > 10 || _diffHour > 0 || _diffDay > 0 || _diffMonth > 0 || _diffYear > 0 || time > _timeout
	};

	if (_showEffects) then {
		_value = 0;
		_text = "";
		if (_diffMinute > 0) then {
			_value = round _diffMinute;
			_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_minuteP"} else {localize "STR_A3_BIS_fnc_setDate_minuteS"};
		};
		if (_diffHour > 0) then {
			_value = round (_diffHour + _diffMinute / 60);
			_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_hourP"} else {localize "STR_A3_BIS_fnc_setDate_hourS"};
		};
		if (_diffDay > 0) then {
			_value = round (_diffDay + _diffHour / 24);
			_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_dayP"} else {localize "STR_A3_BIS_fnc_setDate_dayS"};
		};
		if (_diffMonth > 0) then {
			_value = round _diffMonth;
			_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_monthP"} else {localize "STR_A3_BIS_fnc_setDate_monthS"};
		};
		if (_diffYear > 0) then {
			_value = round _diffYear;
			_text = if (_value > 1) then {localize "STR_A3_BIS_fnc_setDate_yearP"} else {localize "STR_A3_BIS_fnc_setDate_yearS"};
		};

		_text = format [toupper _text,_value];
		_text = format ["<t size='2' font='PuristaSemiBold'>%1</t>",_text];
		[_text,-1,-1,4,0.5] call bis_fnc_dynamictext;
		sleep 0.1;

		("bis_fnc_setDate" call bis_fnc_rscLayer) cuttext ["","black in"];
		1 fadesound bis_fnc_setDate_soundvolume;
	};

	bis_fnc_setDate_transition = nil;
	bis_fnc_setDate_soundvolume = nil;

}];