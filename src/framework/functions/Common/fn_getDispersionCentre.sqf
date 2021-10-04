params [["_objects",[],[[],grpNull]]];

if (_objects isEqualType grpNull) then {
	_objects = units _objects;
};

private _xOrd = 0;
private _yOrd = 0;
{
	if (_x isEqualType objNull) then {
		(position _x) params ["_xInc","_yInc"];
		_xOrd = _xOrd + _xInc;
		_yOrd = _yOrd + _yInc;
	};
} forEach (_objects);

[_xOrd,_yOrd] apply {_x/(count _objects max 1)};
