/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class Task_Clear_Minefield {
	scope = 1;
	target = -1;
	typeID = 21;

	areaSize[] = {1000,1000};
	positionSearchRadius = 3000;
	positionSearchTypes[] = {"Town","Village","House","Farm","Military","SportField"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Clear UXO near %5";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>UXO and Shrapnel have killed a civilian and maimed 3 others yesterday. A exclusion zone around the UXO has been set up and needs to be cleared before civilians can continue to work in that area.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep to identify any UXO in the area and proceed to use controled detonation to remove them.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are blaming %6 forces which alledgedly dropped a cluster bomb in the area that failed to detonate. As %6 does not use cluster bombs, this is highly unlikely.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "destroy";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	class Compositions {
		class MinefieldIED {
			mineFieldType = "UXO";
			position = "positionOffset";
			radius = 150;
			intel = 1;
		};
	};

	class Objective {
		class Succeeded {
			state = 1;
			condition = "_minesdestroyed";
		};
	};
};
