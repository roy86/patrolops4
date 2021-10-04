params [["_npc",objNull,[objNull]],["_unit",objNull,[objNull]],["_attributes",[],[[]]],["_id",[0],[0,[]]]];

if !(_id isEqualType []) then {_id = [_id]};

private _compasDir = {
	params [["_direction",-1,[0]]];
	if (_direction < 0) exitWith {""};

	private _regions = [["North West",292.5,337.5],["North",-22.5,22.5],["North East",22.5,67.5],["East",67.5,112.5],["South East",112.5,157.5],["South",157.5,202.5],["South West",202.5,247.5],["West",247.5,292.5]];
	private _region = "";
	{
		private _ref = _direction + 360;
		private _min = (_x select 1) + 360;
		private _max = (_x select 2) + 360;
		if (_ref >= _min && _ref <= _max) exitWith { _region = _x select 0; };
	} forEach _regions;

	_region;
};

private _relativeDir = {
	params [["_target",objNull,[objNull]],["_dest",[0,0,0],[[],objNull,""]],["_resolve",false,[false]]];
	if (_dest isEqualTo objNull) exitWith {-1};
	private _destPos = _dest call BIS_fnc_position;
	private _direction = ((_target getRelDir _destPos) + (direction _target)) % 360;
	if (_resolve) exitWith {[_direction] call _compasDir};
	_direction;
};

private _calcWalkTime = {
	params [["_target",objNull,[objNull]],["_dest",[0,0,0],[[],objNull,""]]];
	private _distance = _target distance2D (_dest call BIS_fnc_position);
	round((_distance * 1.388)/60);
};

private _dateFormat = {
	params [["_dateTime",daytime,[0]]];
	private _year = str (date select 1);
	private _month = str (date select 1);
	private _day = str (date select 2);
	private _time = [daytime,"HH:MM"] call BIS_fnc_timeToString;
	format["%1-%2-%3 %4",
		_year,
		if (_month < 10) then {format ["0%1",_month]} else {str _month},
		if (_day < 10) then {format ["0%1",_day]} else {str _day},
		[daytime,"HH:MM"] call BIS_fnc_timeToString
	];
};

private _nearestEncounter = {
	params [["_target",objNull,[objNull]],["_distance",2000,[0]]];
	private _nearbyModules = ([[],true] call MPSF_fnc_getCfgTaskModules) select {_x distance2D _target < _distance && _x getVariable ["TaskActive",false]};
	_nearbyModules = _nearbyModules apply {[_target distance2D _x,_x]};
	_nearbyModules sort true;
	(_nearbyModules param [0,[-1,objNull]]) select 1;
};

private _nearestEnemy = {
	params [["_target",objNull,[objNull]],["_distance",1000,[0]]];
	private _nearbyEnemies = allUnits select { alive _x && {side group _x != side group player} && {_x distance2D _target <= _distance} };
	_nearbyEnemies = _nearbyEnemies apply {[_target distance2D _x,_x]};
	_nearbyEnemies sort true;
	_nearbyEnemies = _nearbyEnemies param [0,[0,objNull]];
	_nearbyEnemies params [["_nearestEnemyDist",0,[0]],["_nearestEnemy",objNull,[objNull]]];
	if (_nearestEnemyDist > 1000) exitWith {objNull};
	_nearestEnemy;
};

private _nearbyArea = {
	params [["_target",objNull,[objNull]],["_position",[0,0,0],[[]]]];
	private _areas = ["getNearbyAreas",[_position,[],_radius]] call MPSF_fnc_getCfgMapData;
	if (_areas isEqualTo []) exitWith {""};

	private _area = _areas param [0,""];
	["getAreaType",[_area]] call MPSF_fnc_getCfgMapData;
};

private _response = "";
switch (selectRandom _id) do {
 	case 1 : { // 1: Nearest Enemy GRID
		private _nearestEnemy = [_npc] call _nearestEnemy;
		if !(isNull _nearestEnemy) then {
			private _stringFormat = selectRandom [
				"I spotted soldiers near here (indicating Grid #%1 on map)",
				"Definitely saw soldiers near here (points to Grid #%1)"
			];
			_response = format [_stringFormat,mapGridPosition _nearestEnemy];
		};
	};
	case 2 : { // 2: Nearest Enemy AREA+DIRECTION+TIME
		private _nearestEnemy = [_npc] call _nearestEnemy;
		if !(isNull _nearestEnemy) then {
			private _enemyDir = [_npc,_nearestEnemy] call _relativeDir;
			private _areaEn = [_npc,_npc getPos [_npc distance2D _nearestEnemy,_enemyDir] ] call _nearbyArea;
			private _walkTime = [_npc,_nearestEnemy] call _calcWalkTime;
			private _stringFormat = selectRandom [
				"I spotted some soldiers near a %1 towards the %2 about %3 minutes walk",
				"Definitely saw some soldiers towards the %2 near a %1 about %3 minutes walk"
			];
			_response = format [_stringFormat,_areaEn,[_enemyDir] call _compasDir,_walkTime];
		};
	};
	case 3 : { // 3: Nearest Enemy AREA+DIRECTION
		private _nearestEnemy = [_npc] call _nearestEnemy;
		if !(isNull _nearestEnemy) then {
			private _enemyDir = [_npc,_nearestEnemy] call _relativeDir;
			private _areaEn = [_npc,_npc getPos [_npc distance2D _nearestEnemy,_enemyDir] ] call _nearbyArea;
			private _stringFormat = selectRandom [
				"I spotted some soldiers near a %1 towards the %2",
				"Definitely saw some soldiers towards the %2 near a %1"
			];
			_response = format [_stringFormat,_areaEn,[_enemyDir] call _compasDir];
		};
	};
	case 4 : { // 4: Nearest Enemy AREA + Time
		private _nearestEnemy = [_npc] call _nearestEnemy;
		if !(isNull _nearestEnemy) then {
			private _enemyDir = [_npc,_nearestEnemy] call _relativeDir;
			private _areaEn = [_npc,_npc getPos [_npc distance2D _nearestEnemy,_enemyDir] ] call _nearbyArea;
			private _walkTime = [_npc,_nearestEnemy] call _calcWalkTime;
			private _stringFormat = selectRandom [
				"I spotted some soldiers near a %1 about %2 minutes walk",
				"Definitely saw some soldiers about %2 minutes walk near a %1 somewhere"
			];
			_response = format [_stringFormat,_areaEn,_walkTime];
		};
	};
	case 5 : { // 4: Nearest Enemy Direction
		private _nearestEnemy = [_npc] call _nearestEnemy;
		if !(isNull _nearestEnemy) then {
			private _enemyDir = [_npc,_nearestEnemy,true] call _relativeDir;
			private _walkTime = [_npc,_nearestEnemy] call _calcWalkTime;
			private _stringFormat = selectRandom [
				"I spotted some soldiers towards the %1 about %2 minutes walk",
				"Definitely saw some soldiers about %2 minutes walk to the %1"
			];
			_response = format [_stringFormat,_enemyDir,_walkTime];
		};
	};
//	case 6 : {};
//	case 7 : {};
//	case 8 : {};
//	case 9 : {};
	default {
		private _encounter = [_npc] call _nearestEncounter;
		private _encounterDir = [_npc,_encounter] call _relativeDir;
		private _areaEnc = [_npc,_npc getPos [_npc distance2D _encounter,_encounterDir] ] call _nearbyArea;

		private _nearestEnemy = [_npc] call _nearestEnemy;
		private _enemyDir = [_npc,_nearestEnemy] call _relativeDir;
		private _areaEn = [_npc,_npc getPos [_npc distance2D _nearestEnemy,_enemyDir] ] call _nearbyArea;

		private _walkTime = [_npc,_encounter] call _calcWalkTime;

		systemChat str [
			_encounter,
			getPos _encounter,
			_encounterDir,
			_areaEnc,
			"|",
			_nearestEnemy,
			getPos _nearestEnemy,
			_enemyDir,
			_areaEn
		];

		systemChat str [
			"Time Walked: ",[_npc,_encounter] call _walkTime,"min"
		];

		private _marker1 = createMarker [format["MARKER1_%1",[5] call MPSF_fnc_getRandomString],getPos _encounter];
		_marker1 setMarkerShape "ICON";
		_marker1 setMarkerType "mil_dot";
		_marker1 setMarkerColor "colorGreen";
		_marker1 setMarkerText format ["Encounter"];
		_marker1 setMarkerAlpha 0.5;
		_marker1 setMarkerSize [3,3];

		private _marker2 = createMarker [format["MARKER2_%1",[5] call MPSF_fnc_getRandomString],getPos _nearestEnemy];
		_marker2 setMarkerShape "ICON";
		_marker2 setMarkerType "mil_dot";
		_marker2 setMarkerColor "colorRed";
		_marker1 setMarkerText format ["Enemy"];
		_marker2 setMarkerAlpha 0.5;
		_marker2 setMarkerSize [1,1];

		private _marker3 = createMarker [format["MARKER3_%1",[5] call MPSF_fnc_getRandomString],getPos _npc];
		_marker3 setMarkerShape "ICON";
		_marker3 setMarkerType "mil_dot";
		_marker3 setMarkerColor "colorBlue";
		_marker3 setMarkerAlpha 0.5;
		_marker3 setMarkerSize [1,1];

		_response = format["%1 | %2 | %3 | %4",
			[_encounterDir] call _compasDir,
			[_enemyDir] call _compasDir,
			_areaEnc,
			_areaEn
		];
	};
};

["Log","Log","Civil Intel",
	format ["%2 recieved intel from a civilian: %1",_response,name player]
] call MPSF_fnc_createDiaryNote;

_response;