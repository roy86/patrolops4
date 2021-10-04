params [["_sideID",0,[0]],["_centre",[0,0,0],[[]]],["_areaSize",[10,10],[[]]],["_showMarkers",false,[false]]];

private _ordanance = [
	["BombCluster_02_UXO1_F","BombCluster_02_UXO2_F","BombCluster_02_UXO3_F","BombCluster_02_UXO4_F"],
	["BombCluster_01_UXO1_F","BombCluster_01_UXO2_F","BombCluster_01_UXO3_F","BombCluster_01_UXO4_F"],
	["BombCluster_03_UXO1_F","BombCluster_03_UXO2_F","BombCluster_03_UXO3_F","BombCluster_03_UXO4_F"]
] select (0 max _sideID min 2);

_areaSize params [["_minArea",0,[0]],["_maxArea",0,[0]]];
_minArea = _minArea min _maxArea;
_maxArea = (_minArea max _maxArea) - _minArea;

private _uxoArray = [];
for "_i" from 0 to (10 + (random _maxArea)/5) do {
	private _uxo = createMine [selectRandom _ordanance,_centre getPos [_minArea + random _maxArea,random 360],[],0];
	_uxo setVehiclePosition [position _uxo,[],0,"NONE"];
	_uxo setPos [(position _uxo) select 0,(position _uxo) select 1,((position _uxo) select 2)+0.05];
	_uxoArray pushBack _uxo;
};

if (_showMarkers) then {
	[] spawn BIS_fnc_drawMinefields;
};

_uxoArray;