params [["_objects",[],[[]]],["_curators",allCurators,[[]]]];

if !((["MPSFZeusObjects",1] call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};;

{
	_x addCuratorEditableObjects [_objects,true];
} foreach _curators;

true;