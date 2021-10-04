/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-02-09
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class OP_SAD_HVT_Dealer {
	summary = "Locate a high profile arms dealer who is responsible for the flow of lethal aid";
	scope = 1;
	target = -1;
	typeID = 9;
	minIntelScore = 20;

	areaSize[] = {1000,1000};
	positionSearchRadius = 1000000;
	positionSearchTypes[] = {"Farm","Villa","City","Town","Village","Religious"};
	positionNearLast = 1;

	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>An unknown but well-resourced arms dealer has moved into %4 and is supplying %6 with large quantities of lethal aid. This has destabilised the region further and has heightened the risk to %5 operations in %4.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 forces will conduct several small operations to identify and locate the unknown HVT. It is requested that all efforts be made to capture him however lethal force may be necessary.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>There is very little intel on the HVT however %6 forces are likely to have further intel available in order to locate him. Expect heavy resistance with small arms fire and light technicals.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Speak with civilians who may have intel on the target or enemy positions.<br/>Recovering intel from %6 forces may provide leads on a location or target of opportunity.</t>"
		};
		iconType = "target";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};//,"codename"
	};

	class ChildTasks {
		class OP_SAD_HVT_Dealer_Task1 {};
	};

	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};

class OP_SAD_HVT_Dealer_Task1: Task_Destroy_Squad {
	positionSearchTypes[] = {"Farm","Villa","Village","Religious"};
	class TaskDetails {
		title = "Retrieve Intel";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Reports from a local leader indicates a small %7 force is operating near %5 in %3 %4. It is likely they have intel on our arms dealer considering the display of force they are conducting.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move near %5 to locate the %7 forces and retrive any intel that can be located.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%7 forces are likely to be using small arms fire with support from light technicals to maintain speed and low profile. Be prepared as it is unknown as to what lethal aid they have access to.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Speak with civilians who may have intel on the target or enemy positions.<br/>Recovering intel from %7 forces may provide leads on a location or target of opportunity.</t>"
		};
		iconPosition = "position";
		iconType = "intel";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_intelPickedUp || _intelDownloaded";
			nextTask[] = {"OP_SAD_HVT_Dealer_Task2","OP_SAD_HVT_Dealer_Task3"};
		};
	};
};

class OP_SAD_HVT_Dealer_Task2: Task_Download_intel_camp {
	class TaskDetails: TaskDetails {
		title = "Raid Camp for Intel";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Based on the intel recovered from the last engagement, a small supply camp is believed to have been established near %5 and is likely a distribution point for the HVTs lethal aid supply.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep in order to locate and secure the depot before retieving any intel downloaded from technological assets.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a likelyhood of only one small squad operating in that area with small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Objective: Objective {
		class Succeeded: Succeeded {
			nextTask[] = {"OP_SAD_HVT_Dealer_Task3"};
		};
	};
};

class OP_SAD_HVT_Dealer_Task3: Task_Destroy_HVT {
	class TaskDetails {
		title = "Locate HVT";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Based on the intel recovered from the last engagement, the HVT has been identified as %8 and is located near %5 in %3 %4.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep in order to locate and secure the depot before retieving any intel downloaded from technological assets.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a likelyhood of only one small squad operating in that area with small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "intel";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort","codeName"};
	};
};
