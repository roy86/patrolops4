params [
	["_markerID",""]
	,["_markerPos",[],[[],objNull,""]]
	,["_markerDir",0,[0]]
	,["_markerShape","ICON",[""]]
	,["_markerType","mil_dot",[""]]
	,["_markerColour","ColorBlack",[""]]
	,["_markerSize",[1,1],[[]]]
	,["_markerText","",[""]]
	,["_markerAlpha",1,[0]]
];

if !(_markerPos isEqualType []) then {_markerPos = _markerPos call BIS_fnc_position;};
if (_markerPos isEqualTo []) exitWith { deleteMarker _markerID; };

createMarker [_markerID,_markerPos];

_markerID setMarkerPos _markerPos;
_markerID setMarkerDir _markerDir;
_markerID setMarkerShape _markerShape;
if (toUpper _markerShape isEqualTo "ICON") then {
	_markerID setMarkerType _markerType;
} else {
	_markerID setMarkerBrush _markerBrush;
};
_markerID setMarkerColor _markerColour;
_markerID setMarkerSize _markerSize;
_markerID setMarkerText _markerText;
_markerID setMarkerAlpha _markerAlpha;

_markerID