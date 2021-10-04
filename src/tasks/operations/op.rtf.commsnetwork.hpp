/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-02-09
    
    Description:
        Reconstruction Task Force Set Up Comms Network
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class OP_RTF_CommsNetwork {
	summary = "RTF Operation to restore part of the civilian communications network and locate HVTs";
	scope = 1;
	target = -1;
	typeID = 9;
	minIntelScore = 5;

	areaSize[] = {1000,1000};
	//positionSearchRadius = 1000000;
	positionSearchTypes[] = {"Clearing","Hill","Farm","Military","SportField"};

	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>During the government crackdown, areas around %4 had their communications network destroyed. INTEL has identified 2 key areas that would benefit greatly by setting up new communications network and improve relations with the %4 civilians.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 Forces are tasked with transporting the shipping containers to the identified locations, securing the areas and deploying the communications towers.<br/>Secondary Actions: Any lethal aid, such as weapons caches, should be destroyed and any discovered Intel gathered for further analysis.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%6 are likely to have forces in the area, however it is unlikely that they would move to interfere heavily as they are likely to benefit from the increased coverage of the upgraded comms network.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>This is a hearts and minds issue and killing civilians will undermine this whole operation. Excersize extreme caution when moving around and do not engage unless fired upon.</t>"
		};
		iconType = "container";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};

	class ChildTasks {
		class OP_RTF_CommsNetwork_Task1 {};
	};

	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};

class OP_RTF_CommsNetwork_Task1: Task_Deploy_Tower {
	positionNearLast = 1;
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_targetsDeployed";
			nextTask[] = {"OP_RTF_CommsNetwork_Task2"};
		};
		class Failed {
			state = 2;
			condition = "_targetsDestroyed";
			nextTask[] = {"OP_RTF_CommsNetwork_Task2"};
		};
	};
};

class OP_RTF_CommsNetwork_Task2: Task_Deploy_Tower {
	positionNearLast = 1;
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_targetsDeployed";
			nextTask[] = {};
		};
		class Failed {
			state = 2;
			condition = "_targetsDestroyed";
			nextTask[] = {};
		};
	};
};