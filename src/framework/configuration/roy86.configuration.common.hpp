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
class CfgMissionFramework {
	// Mission Admin - Credit to Mackenzieexd from TaskForce72 for UID filter Idea
	AdminUIDs[] = {
		"_SP_PLAYER_"	/* SP and Editor Debug */
		,"_MP_CANKICK_"	/* ServerCommandAvailable #kick */
	//	,"00000000000"	/* example Player UID "getPlayerUID" */
	//	,"B_Soldier_F"	/* Specific Unit Class Type */
	};

	class MapData {
		#include "maps\roy86.configuration.mapdata.altis.hpp"
	};

	#include "factions\roy86.configuration.factions.common.hpp"

	#include "compositions\roy86,configuration.compositions.common.hpp"

	#include "roy86.configuration.opnames.hpp"

	#include "roy86.configuration.civilian.hpp"

	#include "roy86.configuration.diary.hpp"
};

#include "roy86.configuration.events.hpp"

#include "conversations\roy86.configuration.conversations.common.hpp"