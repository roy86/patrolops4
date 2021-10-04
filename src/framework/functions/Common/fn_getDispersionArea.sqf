params [["_objects",[],[[],grpNull]],["_centre",[],[[]]]];

if (_objects isEqualTo [] || _objects isEqualTo grpNull) exitWith {[]};

switch (true) do {
	case (_objects isEqualType grpNull) : {
		_centre = getPos leader _objects;
		_objects = units _objects - [leader _objects];
	};
	case (_centre isEqualTo []) : {
		private _avgX = 0;
		private _avgY = 0;
		{
			private _pos = _x call BIS_fnc_position;
			_avgX = _avgX + (_pos select 0);
			_avgY = _avgY + (_pos select 1);
		} foreach _objects;
		_centre = [_avgX / count(_objects),_avgY / count(_objects)];
	};
};

private _avgDis = 0;
private _maxDis = 0;
private _maxObject = objnull;
{
	private _objPos = _x call BIS_fnc_position;
	private _dis = _objPos distance _centre;
	_avgDis = _avgDis + _dis;
	if (_dis > _maxDis) then {
		_maxDis = _dis;
		_maxObject = _objPos;
	};
} foreach _objects;
_avgDis = _avgDis / count(_objects);

[_centre,[_maxDis,_maxDis + (_maxDis - _avgDis)],_avgDis,_centre getDir _maxObject]
