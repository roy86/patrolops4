params [["_target",objNull,[objNull]],["_includePositions",false,[false]]];

private _respawnPositions = (_target call BIS_fnc_objectSide) call BIS_fnc_getRespawnMarkers;
if (_includePositions) then {
	_respawnPositions append (_target call BIS_fnc_getRespawnPositions);
};

private _respawnPosition = [0,0,0];
{
	if (_x distance2D _target < (_respawnPosition distance2D _target)) then {
		_respawnPosition = _x;
	};
} forEach (_respawnPositions apply {_x call BIS_fnc_position});

_respawnPosition;