/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-12
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_array",[],[[]]],["_position",[0,0,0],[[],objNull,""]],["_radius",-1,[0]]];

if (count _array isEqualTo 0) exitWith {objNull};
_position = _position call BIS_fnc_position;

private _distance = _radius;
private _object = objNull;
{
	if (_distance < 0 || _position distance _x < _distance) then {
		_distance = _position distance _x;
		_object = _x;
	};
} forEach _array;

_object;