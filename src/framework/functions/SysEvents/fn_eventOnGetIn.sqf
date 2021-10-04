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
params [["_unit",objNull,[objNull]],["_position","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];

if (hasInterface) then {
    if !((_vehicle getVariable ["returnpoint_taskID",""]) isEqualTo "") then {
    //	["loadReturnPointUI",[_vehicle]] call MPSF_fnc_taskmaster;
    };

    if ({vehicle _unit isKindOf _x} count ["Heli_Transport_01_base_F","Heli_Transport_04_base_F","Heli_Attack_02_base_F","Heli_Transport_02_base_F"] > 0) then {
        ["MPSF_VehicleDoor_Action",_unit,"Toggle Cargo Doors",{
            params ["_target", "_caller", "_actionId", "_arguments"];
            private _vehicle = vehicle _caller;
            switch (true) do {
                case (_vehicle isKindOf "Heli_Transport_01_base_F") : {
                    _vehicle animateDoor ['door_R',1 - (_vehicle doorPhase "door_R")];
                    _vehicle animateDoor ['door_L',1 - (_vehicle doorPhase "door_L")];
                };
                case (_vehicle isKindOf "Heli_Transport_04_base_F") : {
                    _vehicle animateDoor ["Door_4_source",1 - (_vehicle doorPhase "Door_4_source")];
                    _vehicle animateDoor ["Door_5_source",1 - (_vehicle doorPhase "Door_5_source")];
                };
                case (_vehicle isKindOf "Heli_Attack_02_base_F") : {
                    _vehicle animateDoor ["door_L",1 - (_vehicle doorPhase "door_L")];
                    _vehicle animateDoor ["door_L_pop",1 - (_vehicle doorPhase "door_L_pop")];
                    _vehicle animateDoor ["door_R",1 - (_vehicle doorPhase "door_R")];
                    _vehicle animateDoor ["door_R_pop",1 - (_vehicle doorPhase "door_R_pop")];
                };
                case (_vehicle isKindOf "Heli_Transport_02_base_F") : {
                    _vehicle animateDoor ["Door_Back_L",1 - (_vehicle doorPhase "Door_Back_L")];
                    _vehicle animateDoor ["Door_Back_R",1 - (_vehicle doorPhase "Door_Back_R")];
                };
            };
        },[],"(driver vehicle _this) isEqualTo _this"] call MPSF_fnc_addAction;
    };
};