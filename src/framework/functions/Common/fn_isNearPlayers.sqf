params [["_position",[],[[],"",objNull]],["_radius",1000,[0]]];

if (_position isEqualType []) then { _position = _position call BIS_fnc_position; };

{_x distance _position <= _radius} count allPlayers > 0;