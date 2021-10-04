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
if (_markerPos isEqualTo []) exitWith { deleteMarkerLocal _markerID; };

createMarkerLocal [_markerID,_markerPos];

_markerID setMarkerPosLocal _markerPos;
_markerID setMarkerDirLocal _markerDir;
_markerID setMarkerShapeLocal _markerShape;
if (toUpper _markerShape isEqualTo "ICON") then {
	_markerID setMarkerTypeLocal _markerType;
} else {
	_markerID setMarkerBrushLocal _markerBrush;
};
_markerID setMarkerColorLocal _markerColour;
_markerID setMarkerSizeLocal _markerSize;
_markerID setMarkerTextLocal _markerText;
_markerID setMarkerAlphaLocal _markerAlpha;

_markerID