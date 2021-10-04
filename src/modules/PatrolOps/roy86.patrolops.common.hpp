/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-14
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class PatrolOperations {
	// Encounter Model Attributes
    class models {
        logRegBeta[] = {
            {"coeff",8.012547,"-1"},
            {"Units",0.021942,"count units group player"},
            {"Players",0.035611,"{isPlayer _x} count units group player"},
            {"Vehicles",0.177314,"count ([group player] call MPSF_fnc_getSquadVehicleTypes)"},
            {"DispersionRadius",0.122251,"([units group player] call MPSF_fnc_getDispersionArea) select 2"},
            {"DistanceToBase",0.002481,"player distance2D ([player,true] call MPSF_fnc_getNearestRespawnPoint)"},
            {"TimeSinceLastEncounter",0.00713,"(if (isMultiplayer) then {serverTime} else {time}) - (missionNamespace getVariable ['PO4_lastEncounterTime',(if (isMultiplayer) then {serverTime} else {time})])"}
        };
        logHostileTown[] = {
            {"coeff",4.034864},
            {"NearbyUnits",0.192274,"count(allplayers select {_x distance2D _position < 1500})"},
            {"DistanceToBase",0.002481,"_position distance2D ([sideUnknown,true] call MPSF_fnc_getNearestRespawnPoint)"}
        };
    };
};

#include "ui\roy86.patrolops.rsc.display.common.hpp"