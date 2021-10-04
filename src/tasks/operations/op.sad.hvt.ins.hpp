// Search and Destory Insurgent High Value Target
class OP_SAD_HVT_INS {
	summary = "Task Force operation to locate and capture an elusive HVT";
	scope = 1;
	target = -1;
	typeID = 9;
	minIntelScore = 5;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL places a high ranking %6 leader, code named %7, in %4 and is responsible for and oversees the flow of weapons and fighters into the country. He is considered a High Value Target and if captured, would lead to vital intelligence to further stabilise the region.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 is tasked with capturing the %7 if possible and returning him to the bases 'Return Point'.<br/>Secondary Actions: Any lethal aid, such as weapons caches, discovered should be destroyed and any discovered Intel gathered for further analysis.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%7 is a high priority target. His location is unknown and %5 Task Force will need to gather Intel to locate %7.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Speak with civilians who may have intel on the target or enemy positions.<br/>Recovering intel from %6 forces may provide leads on a location or target of opportunity.</t>"
		};
		iconType = "Destroy";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort","codeName"};
	};
	class ChildTasks {
		class OP_SAD_HVT_INS_Task1 {};
		class OP_SAD_HVT_INS_Task2 {};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};
class OP_SAD_HVT_INS_Task1: Task_DestroyDrugDealer {
	class TaskDetails {
		title = "Locate Drug Dealer";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL identifies a known drug dealer that would likely know or have intel on the HVT and as they pose a significant risk to civilian health, it is a good opportunity to take him out of the equation. </t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area near %5 to conduct a sweep in order to locate and elimiate the dealer and locate any intel that would indicate the location of the HVT.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a unlikely to be operating in that area.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "A";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	class Objective {
		class Succeeded {
			state = 1;
			condition = "_targetsKilled && _intelPickedUp";
		};
	};
};
class OP_SAD_HVT_INS_Task2: Task_DestroyDrugDealer {
	class TaskDetails {
		title = "Locate Drug Dealer";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL indicates that shipments of Lethal Aid have recently moved and stored in %4 near %5. It is believed our HVT was involved and this could lead to intel of his location.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep in order to locate and destroy any weapons caches discovered.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a likelyhood of only one small  squad operating in that area with small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "B";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	class Objective {
		class Succeeded {
			state = 1;
			condition = "_cacheDestroyed && _intelPickedUp";
			nextTask[] = {"OP_SAD_HVT_INS_Task3"};
		};
	};
};
class OP_SAD_HVT_INS_Task3: Task_Recover_HVT {
	class TaskDetails {
		title = "Capture HVT";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL points to the HVT being located near %5 and that %6 command would like removed from the battlefield.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep in order to locate and capture the HVT if possible. Bag any bodies of targets left behind.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a likelyhood of only one small squad operating in that area with small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "C";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_targetsReturned";
		};
		class Failed {
			state = 2;
			condition = "_targetsKilled";
		};
	};
};
