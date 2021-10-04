if !(isServer) exitWith {[]};

params [["_position",[0,0,0],["",[]]],["_areaRadius",[0,0],[0,[]]],["_intel",false,[false]],["_ambush",false,[false]]];

// Create IED
private _iedClasses = ["CfgMissionTasks","iedTypes"] call MPSF_fnc_getCfgDataArray;
if (count _iedClasses isEqualTo 0) exitWith { ["No IED Types Found"] call BIS_fnc_error; [objNull]; };

private _roadPos = (_position nearRoads 20) param [0,objNull];
if (isNull _roadPos) exitWith {[]};


private _iedClassname = selectRandom _iedClasses;
private _ied = if (_iedClassName isKindOf "MineGeneric") then {
    createMine [_iedClassname,_roadPos call BIS_fnc_position,[],0];
} else {
    createVehicle [_iedClassname,_roadPos call BIS_fnc_position,[],0];
};
private _offset = if(selectRandom [true,false]) then { _roadPos modelToWorld [-7.5 - random 3,0,0]; } else { _roadPos modelToWorld [7.5 + random 3,0,0]; };
_offset set [2,0];

_ied setDir ((getDir _roadPos)+90);
_ied setPosATL _offset;

_ied setVariable ["MPSF_IED",true,true];
_ied setVariable ["MPSF_IED_Ambush",_ambush,true];

[[_ied]] call MPSF_fnc_addZeusObjects;

[_ied]