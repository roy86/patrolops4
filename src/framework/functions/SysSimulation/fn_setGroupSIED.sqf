/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-10
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",grpNull,[grpNull,objNull]],["_position",[],[[]]],["_radius",150,[0]]];

if (_target isEqualType grpNull) then {
    private _groupData = [_position,"FactionTypeCIV","Informants"] call MPSF_fnc_createAgentGroup;
    if (count _groupData == 0) exitWith {};
    _target = selectRandom _groupData;
    {
        if !(_x isEqualTo _target) then {
            deleteVehicle _x;
        };
    } forEach _groupData;
};

_target setVariable ["crowdData",nil,true];

MPSF_fnc_siedMonitor = {
    params ["_agentID"];
    _agent = _agentID call BIS_fnc_objectFromNetId;
    
    if (!(alive _agent) || (isNull _agent)) exitWith {
        [_agentID,"onEachFrame"] call MPSF_fnc_removeEventhandler;
    };

    private _players = (allPlayers - entities "HeadlessClient_F") select {alive _x};
    private _target = [_players,position _agent] call MPSF_fnc_getNearestObject;
    private _visible = [_target,"VIEW",_agent] checkVisibility [eyePos _target,eyePos _agent];

    if (isNull _target) exitWith {};
    if (_target distance _agent > 200) exitWith {};

    //systemChat str [diag_frameno,_agentID,_agent,_target,_visible];

    if (diag_frameno % 50 == 0) then {
        _agent setSpeedMode "LIMITED";
        _agent moveTo (position _target);
        if (_visible > 0.5) then {
            _agent forceSpeed (_agent getSpeed "Fast");
        } else {
            _agent forceSpeed (_agent getSpeed "Slow");
        };
    };

    if (diag_frameNo % 125 == 0 && selectRandom [false,false,false,false,false,false,true]) then {
        playSound3D [format["a3\ui_f_curator\Data\Sound\CfgSound\ping0%1.wss",(round random 6) + 1],_target,false,getPosATL _target,1,0.5,900];
    };

    //[_agentID,position _agent,nil,nil,nil,"ColorGreen"] call MPSF_fnc_createMarker;

    if (_target distance _agent < 15) then {
        _agent addRating -10000;
    };

    if (_target distance _agent < 3) then {
        [_agentID,"onEachFrame"] call MPSF_fnc_removeEventhandler;
        ["onDetonateSIED",[position _agent],0] call MPSF_fnc_triggerEventhandler;
        createVehicle ["Bo_GBU12_LGB",position _agent,[],0,"CAN_COLLIDE"];
    };
};

[str (_target call BIS_fnc_netId),"onEachFrame",compile format ["[%1] call MPSF_fnc_siedMonitor;",str (_target call BIS_fnc_netId)]] call MPSF_fnc_addEventHandler;

true;