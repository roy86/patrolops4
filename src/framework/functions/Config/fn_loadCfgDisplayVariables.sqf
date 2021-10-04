params [["_display",displayNull],["_displayID","",[""]]];

if (isNull _display || _displayID isEqualTo "") exitWith {false};

{
	uiNamespace setVariable [configName _x,_display displayCtrl getNumber(_x >> "idc")];
	if (isClass (_x >> "ControlsBackground")) then {
		{
			uiNamespace setVariable [configName _x,_display displayCtrl getNumber(_x >> "idc")];
		} forEach ([_x,1,false] call BIS_fnc_returnChildren);
	};
	if (isClass (_x >> "Controls")) then {
		{
			uiNamespace setVariable [configName _x,_display displayCtrl getNumber(_x >> "idc")];
		} forEach ([_x,1,false] call BIS_fnc_returnChildren);
	};
} forEach ([[_displayID] call BIS_fnc_getCfg,1,false] call BIS_fnc_returnChildren);

true