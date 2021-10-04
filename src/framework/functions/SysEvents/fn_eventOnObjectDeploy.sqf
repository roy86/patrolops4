/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_container",objNull,[objNull]],["_caller",objNull,[objNull]]];

if (isServer) then {
    private _deployedClassname = _container getVariable ["deployedClassName",""];
    private _attributes = _container getVariable ["attributes",[]];

    if (_deployedClassname isEqualTo "") exitWith {};

    private _spawnPos = getPosATLVisual _container;
    private _spawnDir = getDir _container;
    private _spawnClass = typeOf _container;
    private _spawnName = [_spawnClass] call MPSF_fnc_getCfgText;

    _container allowDamage false;
    _container setPos [0,0,0];
    _container spawn { sleep 10; deleteVehicle _this; };

    _deployed = createVehicle [_deployedClassname,_spawnPos,[],0,"CAN_COLLIDE"];
    _deployed setVehiclePosition [_spawnPos,[],0,"CAN_COLLIDE"];
    _deployed setDir _spawnDir;

    _deployed setVariable ["deployedClassName",_spawnClass,true];
    _deployed setVariable ["attributes",_attributes,true];

    if !(isNull _deployed) then {
        ["onObjectDeployed",[_deployed,_spawnClass,_caller,_attributes],0] call MPSF_fnc_triggerEventHandler;
    };

    [format["MPSF_Deployable_%1",_deployed call BIS_fnc_netID],_deployed,format ["Deploy %1",_spawnName],[
            ["framework\data\holdactions\holdAction_repair_ca.paa",{_caller playAction "PutDown";}]
            ,["framework\data\holdactions\holdAction_repair_ca.paa",{}]
            ,{ ["onObjectDeploy",[_target,_caller],0] call MPSF_fnc_triggerEventHandler; }
            ,{}
            ,3,true
        ],[],"damage _target < 1 && vehicle player isEqualTo player",0,true
    ] spawn {sleep 0.125; _this call MPSF_fnc_addAction;};
};