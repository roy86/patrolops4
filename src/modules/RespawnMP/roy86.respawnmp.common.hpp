/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class CfgRespawnMP {

    // Mobile Headquarters (MHQ) Configuration
    MHQenable = 1;
	MHQLimit = 3;
	MHQvehicles[] = {
		"B_Truck_01_box_F",
        "B_MRAP_01_F",
        "O_Truck_03_repair_F",
        "O_MRAP_02_F",
		"I_Truck_02_box_F",
        "I_MRAP_03_F"
	};

    // Rallypoint Configuration
    rallypointsEnable = 1;
    rallypointType[] = {
        "Land_TentSolar_01_sand_F", // East
        "Land_TentSolar_01_olive_F", // West
        "Land_TentSolar_01_bluewhite_F", // Independent
        "Land_TentSolar_01_redwhite_F" // Civilian
    };
};

#include "ui\roy86.respawnmp.rsc.control.halo.hpp"
#include "ui\roy86.respawnmp.rsc.control.map.hpp"
#include "ui\roy86.respawnmp.rsc.control.menu.hpp"
#include "ui\roy86.respawnmp.rsc.display.menu.hpp"