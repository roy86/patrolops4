/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-15
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})
#define TIMEVAR "PO4_Encounter_%1_lastTime"
private _radius = 1000;

params [["_requestor",objNull,[objNull]],["_position",[0,0,0],[[]]],["_distance",0,[0]],["_direction",0,[0]],["_speed",0,[0]]];

if (isNull _requestor) exitWith {["Invalid Requestor for Encounter"] call BIS_fnc_error; false; };

_position = _position getPos [_distance*2 min 2000,_direction];
["RefCheckPos",_position,nil,nil,nil,nil,nil," Position Check"] call MPSF_fnc_createMarkerLocal;

private _encounterIDs = [];
switch (true) do {
	case (vehicle _requestor isEqualTo _requestor) : {
		_encounterIDs append [101];
	};
	case (vehicle _requestor isKindOf "LandVehicle") : {
		_encounterIDs append [101,102];
	};
	case (vehicle _requestor isKindOf "Helicopter") : {
		_encounterIDs append [103];
	};
	case (vehicle _requestor isKindOf "Plane") : {
		_encounterIDs append [104];
	};
	case (vehicle _requestor isKindOf "Ship") : {
		_encounterIDs append [105];
	};
};

// Get Encounters by IDs
private _encounters = (["getTasksByID",_encounterIDs] call MPSF_fnc_getCfgTasks) select {(missionNamespace getVariable [format [TIMEVAR,_x],0]) < MISSIONTIME};
if (_encounters isEqualTo []) exitWith {["No Encounters available for IDs: ",_encounterIDs] call BIS_fnc_error; false};

// Existing Tasks nearby
private _existingTasks = ([] call MPSF_fnc_getCfgTaskModules) select {_x distance2D _position < (_radius)};
if (count (_existingTasks) > 0) exitWith {["Unable to create encounter as nearby active Tasks"] call BIS_fnc_error; false};

// Get Vehicle Types
private _vehicleClasses = ([group _requestor,true] call MPSF_fnc_getSquadVehicleTypes) apply {toLower _x};

// All Safezones
private _safeZones = (([(["side","FactionTypeBLU"] call MPSF_fnc_getCfgFaction)] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x});


// Nearby Areas
private _nearbyAreas = ["getNearbyAreas",[_position,[],_radius,true]] call MPSF_fnc_getCfgMapData;
_nearbyAreas append (["areas",["Air"]] call MPSF_fnc_getCfgMapData);
_nearbyAreas = _nearbyAreas apply {
	[_x,["getAreaPosition",[_x]] call MPSF_fnc_getCfgMapData,["getAreaType",[_x]] call MPSF_fnc_getCfgMapData]
};
// Nearby Roads
private _nearbyRoads = ["getNearbyRoads",[_position,_radius]] call MPSF_fnc_getCfgMapData;
_nearbyRoads = _nearbyRoads apply {
	[_x,["getRoadPosition",[_x]] call MPSF_fnc_getCfgMapData,"road"]
};

// Process Areas
_nearbyAreas append _nearbyRoads;
_nearbyAreas = _nearbyAreas select {
	_x params ["_areaID","_areaPos","_areaType"];
	_areaPos distance2D player > _radius
	&& {_areaPos distance2D _x > _radius/2} count _safeZones > 0
	&& {_x distance2D _areaPos < (_radius*2)} count _existingTasks == 0
};

// Process Encounters
_encounters = _encounters apply {
	private _encounterID = _x;
	private _encounterAreas = (["conditionAreas",[_encounterID]] call MPSF_fnc_getCfgTasks) apply {toLower _x};
	private _encounterVehicles = (["conditionVehicleTypes",[_encounterID]] call MPSF_fnc_getCfgTasks) apply {toLower _x};
	[_encounterID
		,_nearbyAreas select {toLower(_x select 2) in _encounterAreas}
		,count (_encounterVehicles arrayIntersect _vehicleClasses) > 0
		,(missionNamespace getVariable [format ["PO4_Encounter_%1_lastTime",_encounterID],MISSIONTIME]) - MISSIONTIME
	]
};

//hintSilent (_encounters joinString "\n");
_encounters = _encounters  select {count (_x select 1) > 0 && (_x select 2) && ((_x select 3) <= 0) };
if (_encounters isEqualTo []) exitWith {systemChat "exiting no valid encounters"; false};

private _encounter = selectRandom (_encounters apply {[_x select 0,_x select 1]});

private _nearestAreaID = [];
private _distance = -1;
{
	_x params ["_areaID","_areaPos","_areaType"];
	//private _distance = _areaPos distance2D _position;
	if (_distance < 0 || _areaPos distance2D _position < _distance) then {
		_distance = _areaPos distance2D _position;
		_nearestAreaID =+ _x;
	};
	["RefCheckPos"+_areaID,_areaPos,nil,nil,nil,nil,nil,_areaID + " - " + str _distance] call MPSF_fnc_createMarkerLocal;
} forEach (_encounter select 1);

if !(_nearestAreaID isEqualTypeArray ["",[0,0,0],""]) exitWith { false };

_encounter set [1,_nearestAreaID select 1];
["onEncounterRequest",[player,_encounter,false],2] call MPSF_fnc_triggerEventHandler;

true