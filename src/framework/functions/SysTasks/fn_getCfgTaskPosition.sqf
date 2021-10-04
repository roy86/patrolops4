#define MINSEARCHRADIUS 3000

params [["_cfgTaskID","",[""]],["_taskID","",[""]],["_areaID","",[[],""]]];

// Exit early when already stored
private _var = format["%1_var_position",_taskID];
if !(isNil _var) exitWith { missionNamespace getVariable [_var,[[0,0,0],[0,0,0],""]]; };

//systemChat str ["_cfgTaskID: ",_cfgTaskID];

// Get task position configuration
private _position = ["position",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionOffset = ["positionOffset",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionSearchRadius = ["positionSearchRadius",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionSearchTypes = ["positionSearchTypes",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionNearLast = ["positionNearLast",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionNearRoad = ["positionNearRoad",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;
private _positionIsWater = ["positionIsWater",[_cfgTaskID]] call MPSF_fnc_getCfgTasks;

private _safeZones = (([(["side","FactionTypeBLU"] call MPSF_fnc_getCfgFaction)] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x});

//(format ["Task Position 1 info: %1 | Position: %2 | PosOffset: %3 | AreaID: %6 | SearchRadius: %4 | SearchTypes: %5",_taskID,_position,_positionOffset,_positionSearchRadius,_positionSearchTypes,str _areaID]) call BIS_fnc_logFormat;
//(format ["Task Position 1 _positionSearchRadius %3 | _positionSearchTypes %4 | _positionNearLast %5 | _positionNearRoad %6 | _positionIsWater %7",_position,_positionOffset,_positionSearchRadius,_positionSearchTypes,_positionNearLast,_positionNearRoad,_positionIsWater]) call BIS_fnc_logFormat;

//systemChat str ["PositionNearLast: ",_positionNearLast && _position isEqualTo [0,0,0]];
if (_positionNearLast && _position isEqualTo [0,0,0]) then {
	_position = missionNamespace getVariable ["MPSF_Task_var_lastRefPos",[worldSize/2,worldSize/2,0]];

	private _nearbySectors = ["getNearbySectors",[_position,_positionSearchRadius max (worldSize/10)]] call MPSF_fnc_getCfgMapData;
	_nearbySectors = ["hasNoTaskModules",[_nearbySectors]] call MPSF_fnc_getCfgMapData;
	if (_positionIsWater) then {
		_nearbySectors = _nearbySectors select {(["isSectorWater",[_x]] call MPSF_fnc_getCfgMapData)};
	} else {
		_nearbySectors = _nearbySectors select {!(["isSectorWater",[_x]] call MPSF_fnc_getCfgMapData)};
	};
	if (count _nearbySectors > 0) then {
		_position = ["sectorPosition",[selectRandom _nearbySectors]] call MPSF_fnc_getCfgMapData;
	};
};

//systemChat str ["AreaID isArray: ",_areaID isEqualType []];
if (_areaID isEqualType []) then {
	switch (true) do {
		case (_areaID isEqualTypeArray [0,0]);
		case (_areaID isEqualTypeArray [0,0,0]) : { _position =+ _areaID; _areaID =  ""; };
		default {
			private _areaIDs =+ _areaID select {!([["getAreaPosition",[_x]] call MPSF_fnc_getCfgMapData,1000] call MPSF_fnc_isNearbyTaskModule)};
			if (count _areaIDs > 0) then {
				_areaID = selectRandom _areaIDs;
				_positionOffset = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
				_position = ["sectorPosition",[_positionOffset]] call MPSF_fnc_getCfgMapData;
			};
		};
	};
};

//systemChat str ["Position is 0: ",_position isEqualTo [0,0,0]];
if (_position isEqualTo [0,0,0]) then {
	private _allSectors = ["sectors"] call MPSF_fnc_getCfgMapData apply { [_x,["sectorPosition",[_x]] call MPSF_fnc_getCfgMapData]; };
	if (_positionIsWater) then {
		_allSectors = (_allSectors) select { (["isSectorWater",[_x select 0]] call MPSF_fnc_getCfgMapData)};
	} else {
		_allSectors = (_allSectors) select {!(["isSectorWater",[_x select 0]] call MPSF_fnc_getCfgMapData)};
	};
	_allSectors = (_allSectors) select { private _sectorPos = _x select 1; {_sectorPos distance2D _x > _positionSearchRadius/2} count _safeZones > 0 };
	if (count _allSectors > 0) then {
		_position = (selectRandom _allSectors) param [1,[0,0,0]];
	};
};

//systemChat str ["_positionSearchTypes: ",count _positionSearchTypes > 0 && _areaID isEqualTo ""];
if (count _positionSearchTypes > 0 && _areaID isEqualTo "") then {
	private _nearbySectors = ["getNearbySectors",[_position,_positionSearchRadius max (worldSize/20)]] call MPSF_fnc_getCfgMapData;
	_nearbySectors = _nearbySectors select {(["hasSectorAreaType",[_x,_positionSearchTypes]] call MPSF_fnc_getCfgMapData)};
	_nearbySectors = ["hasNoTaskModules",[_nearbySectors]] call MPSF_fnc_getCfgMapData;

	if (_positionIsWater) then {
		_nearbySectors = _nearbySectors select {(["isSectorWater",[_x]] call MPSF_fnc_getCfgMapData)};
	} else {
		_nearbySectors = _nearbySectors select {!(["isSectorWater",[_x]] call MPSF_fnc_getCfgMapData)};
	};

	if (count _nearbySectors > 0) then {
		private _mapSector = selectRandom _nearbySectors;
		_areaID = selectRandom (["getSectorAreas",[_mapSector,_positionSearchTypes]] call MPSF_fnc_getCfgMapData);
	} else {
		_areaID = ["getNearestAreaByType",[_position,_positionSearchTypes,true]] call MPSF_fnc_getCfgMapData;
	};
};

//systemChat str ["_areaID is string: ",_areaID isEqualType ""];
if (_areaID isEqualType "") then {
	if !(_areaID isEqualTo "") then {
		switch (true) do {
			case (["isArea",[_areaID]] call MPSF_fnc_getCfgMapData) : {
				private _areaPos = ["getAreaPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
				_position = ["sectorPosition",[_areaPos]] call MPSF_fnc_getCfgMapData;
				_positionOffset =+ _areaPos;
			};
			case (["isRoad",[_areaID]] call MPSF_fnc_getCfgMapData) : {
				private _areaPos = ["getRoadPosition",[_areaID]] call MPSF_fnc_getCfgMapData;
				_position = ["sectorPosition",[_areaPos]] call MPSF_fnc_getCfgMapData;
				_positionOffset =+ _areaPos;
			};
		};
	};
} else {
	_areaID = "";
};

switch (true) do {
//    case (_position isEqualTo [0,0,0]) : { _position = [worldSize/2,worldSize/2,0]; };
	case (_position isEqualTypeArray [0,0]);
	case (_position isEqualTypeArray [0,0,0]) : {};
	case (_position isEqualType []) : { _position = selectRandom _position; };
	case (_position isEqualType objNull);
	case (_position isEqualType "") : { _position = _position call BIS_fnc_position; };
	default { _position = [worldSize/2,worldSize/2,0]; };
};

// If positionOffset is not defined, use position location
if (_positionOffset isEqualTo [0,0,0]) then { _positionOffset =+ _position; };
switch (true) do {
	case (_positionOffset isEqualTypeArray [0,0]);
	case (_positionOffset isEqualTypeArray [0,0,0]) : {};
	case (_positionOffset isEqualType []) : { _positionOffset = selectRandom _positionOffset; };
	case (_positionOffset isEqualType objNull);
	case (_positionOffset isEqualType "") : { _positionOffset = _positionOffset call BIS_fnc_position; };
	default { _positionOffset = _position call BIS_fnc_position; };
};

// Move Offset Position to nearby road
if (_positionNearRoad) then {
	private _nearRoads = [];
	for "_i" from 2 to 10 do {
		_nearRoads = (_positionOffset nearRoads (50*(_i/2))) select {!(surfaceIsWater getPos _x)};
		if (count _nearRoads > 0) exitWith { _nearRoads apply {getPos _x}};
	};
	if (count _nearRoads > 0) then {
		_positionOffset = getPos (selectRandom _nearRoads);
	};
};

//(format ["Task Position 13 generated: %1 | Position: %2 | PosOffset: %3 | Area: %4",_taskID,_position,_positionOffset,str _areaID]) call BIS_fnc_logFormat;

if !(_position isEqualTo [0,0,0]) then {
	missionNamespace setVariable ["MPSF_Task_var_lastRefPos",_position];
};
missionNamespace setVariable [_var,[_position,_positionOffset,_areaID]];

/* [_taskID,_position,nil,nil,nil,nil,nil,_taskID + " Position"] call MPSF_fnc_createMarkerLocal;
[_taskID+"2",_positionOffset,nil,nil,nil,nil,nil,_taskID + " Position Offset"] call MPSF_fnc_createMarkerLocal; */

[_position,_positionOffset,_areaID];