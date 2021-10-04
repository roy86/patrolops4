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
#define EVENTNAMETEMPLATE "MPSF_Framework_%1_EH"
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "init" : {
		if (hasInterface) then {
			addmissioneventhandler ["draw3d",{["draw3D",[],true] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);}];
			addMissionEventHandler ["EntityKilled",{["onKilledGlobal",_this,true] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);}];
			addMissionEventHandler ["EntityRespawned",{["onRespawnGlobal",_this,true] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);}];
			addMissionEventHandler ["Map",{params ["_mapIsOpened", "_mapIsForced"]; if (_mapIsOpened) then {
				["onMapOpen",_this,true] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);
			};}];

			[] spawn {
				waitUntil{ !isNull (findDisplay 46) };
				(findDisplay 46) displayAddEventHandler ["KeyDown",			{['onKeyDown',_this,true] call MPSF_fnc_triggerEventHandler;}];
				(findDisplay 46) displayAddEventHandler ["KeyUp",			{['onKeyUp',_this,true] call MPSF_fnc_triggerEventHandler;}];
				(findDisplay 46) displayAddEventHandler ["MouseButtonDown",	{['MouseButtonDown',_this,true] call MPSF_fnc_triggerEventHandler; false;}];
				(findDisplay 46) displayAddEventHandler ["MouseButtonUp",	{['MouseButtonUp',_this,true] call MPSF_fnc_triggerEventHandler; false;}];
				(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{if (visibleMap) then { ['MapDraw',_this,true] call MPSF_fnc_triggerEventHandler; }; false;}];
				(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseMoving",{missionNamespace setVariable ["MPSF_MAP_CURSORPOS",(_this select 0) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];}];
				(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseButtonClick",{if (visibleMap) then { ['onMapClick',_this,true] call MPSF_fnc_triggerEventHandler; };}];
			};
		};

		[] spawn {
			if (hasInterface) then {
				waitUntil { !(isNull player) };
				if (count(missionNamespace getVariable ["MPSF_Player_var_previousPositionASL",[]]) == 0) then {
					missionNamespace setVariable ["MPSF_Player_var_previousPositionASL",getPosASL player];
				};
			};

			{
				if (([_x >> "scope"] call MPSF_fnc_getCfgDataNumber) isEqualTo 2) then {
					private _eventName = configName _x;
					private _eventTarget = [_x >> "target"] call MPSF_fnc_getCfgDataNumber;
					private _eventTriggers = [_x >> "eventTrigger"] call MPSF_fnc_getCfgDataArray;
					private _eventFunction = [_x >> "function"] call MPSF_fnc_getCfgDataText;
					if (_eventTriggers isEqualTo []) then { _eventTriggers = [""]; };
					{
						private _eventTrigger = _x;
						switch (true) do {
							case (_eventTarget == 2 && isServer);
							case (_eventTarget == -2 && !(isServer && isMultiplayer));
							case (_eventTarget == 0) : {
								if (hasInterface && !(_eventTrigger isEqualTo "")) then {
									if (tolower _eventTrigger in ["mpkilled","mprespawn"]) then {
										player addMPEventHandler [_eventTrigger,compile format ["[%1,_this,true] call (missionNamespace getVariable ['MPSF_fnc_triggerEventHandler',{}])",str _eventName]];
									} else {
										player addEventHandler [_eventTrigger,compile format ["[%1,_this,true] call (missionNamespace getVariable ['MPSF_fnc_triggerEventHandler',{}])",str _eventName]];
									};
								};
								if !(_eventFunction isEqualTo "" ) then {
									[format[EVENTNAMETEMPLATE,_eventName],_eventName,compile format ["_this call %1",_eventFunction]] call MPSF_fnc_addEventHandler;
								};
							};
							case (_eventTarget == 1) : {
								if !(_eventFunction isEqualTo "" ) then {
									[player] call (missionNamespace getVariable [_eventFunction,{nil}]);
								};
							};
							default {
								if !(_eventFunction isEqualTo "" ) then {
									[format[EVENTNAMETEMPLATE,_eventName],_eventName,compile format ["_this call %1",_eventFunction]] call MPSF_fnc_addEventHandler;
								};
							};
						};
					} forEach _eventTriggers;
				};
				//if !(_eventName IN ["onEachFrame","onKeyDown","onKeyUp"]) then {[format["MPSF_Framework_%1_EH2",_eventName],_eventName,compile format ["systemchat str [%2, %1, _this];",str _eventTrigger,str _eventName]] call MPSF_fnc_addEventHandler;};
			} forEach ([["CfgMissionEvents"] call BIS_fnc_getCfg,0,false] call BIS_fnc_returnChildren);
		};

		["MPSF_Framework_onEachFrame_BISEH","onEachFrame",{['onEachFrame',_this,true] call MPSF_fnc_triggerEventHandler;}] call BIS_fnc_addStackedEventHandler;
	};
};