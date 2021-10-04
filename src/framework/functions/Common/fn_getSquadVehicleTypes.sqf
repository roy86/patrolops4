params [["_target",grpNull,[grpNull,objNull]],["_returnAll",false,[false]]];

if (isNull _target) exitWith {[]};
if !(_target isEqualType grpNull) then { _target = group _target; };

private _vehicleClasses = [];
if (_returnAll) then {
	{
		{
			_vehicleClasses pushBackUnique _x;
		} forEach ([configFile >> "CfgVehicles" >> typeOf _x,true] call BIS_fnc_returnParents);
	} forEach ((units _target) apply {vehicle _x});
} else {
	{
		if !(_x isKindOf "CAManBase") then {
			_vehicleClasses pushBackUnique typeOf _x;
		};
	} forEach ((units _target) apply {vehicle _x});
};
_vehicleClasses