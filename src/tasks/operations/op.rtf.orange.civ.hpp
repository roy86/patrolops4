// Recontruction Task Force Orange DLC Area Operations
class OP_RTF_Orange_CIV {
	summary = "RTF Operation to restore supply lines, handle UXO and create comms networks";
	scope = 1;
	target = -1;
	typeID = 9;
	minIntelScore = 5;
	class TaskDetails {
		title = "%1 ORANGE";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%4 has been in crises, both natural and human inflicted, contributing to regional and international instability that threaten %5 interest both directly and indirectly. IDAP, who are monitoring regional security and conflict trends, suggest that instability will continue to pose a threat in the near future as exemplified by a number of new and ongoing crises, and the increase in the reach and scope of apparent %6 backed groups. With many of these threats originating in fragile and conflict-affected states, %5, along with its allies, has a compelling reason to combat these threats at the source.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>IDAP are unable to operate in %4 due to the high risk of attack, %5 taskforce will move to the affected areas and conduct reconstruction efforts to repair and assist stabilising the areas.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>The area has recently seen conflict between %5 and %6 forces resulting in civilian casualties and damaged infrastructure. Two IDAP teams were attacked in the area which forced their withdrawal. It is likely that %5 taskforce will encounter resistance but the strength and capability require further assessment in the field.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>The local civilian population are conflicted in their support for %5. Be aware of watchers who are likely to be reporting %5 positions to unfriendly forces.</t>"
		};
		iconType = "repair";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};
	class ChildTasks {
		class RTF_ORANGE_CIV_RESUPPLY {};
		class RTF_ORANGE_CIV_COMMS {};
		class RTF_ORANGE_CIV_MINEFIELD {};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};

// Resupplly Civilian Town
class RTF_ORANGE_CIV_RESUPPLY: Task_Supply_Food {
	scope = 1;
	typeID = 201;
	positionNearLast = 1;
	class TaskDetails {
		title = "Resupply Civilians";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Civilians in %5 are reporting critical supplies have been stolen in a raid overnight. These supplies include food for the schools and local villages nearby, along with medicine for local doctors who are treating those impacted by the recent conflicts.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 Taskforce will collect, transport and deliver the required supplies to the local population. Ensure the shipping containers arrive safely and undamaged.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Expect small arms resistance to the delivery of the supplies however %7 have made a bold move so anticipate a heavier response.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Intel indicates this is the work of %7 insurgents looking to destabilise the relationship between %5 and the local populace. If the supplies aren't delivered, it is believed the insurgents will come to the 'rescue' and further undermine %6 operations.</t>"
		};
		iconType = "A";
		iconPosition = "positionOffset";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
};

// Deploy Comms Tower
class RTF_ORANGE_CIV_COMMS: Task_Deploy_Tower {
	scope = 1;
	typeID = 201;
	positionNearLast = 1;
	class TaskDetails {
		title = "Establish Communications";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Recent insurgent activity has disabled civilian communications near %5. With IDAP unable to enter the area, %6 command has committed to IDAP to restore communications on their behalf.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 Taskforce will collect the IDAP container containing the communications array, transported to the identified location and set it up near %5 to restore communications.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Expect low resistance to this from %7 insurgents however with rumours regarding a recent re-supply, they could pack a heavier than anticipated punch.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>This is known to be the direct action of %7 insurgents looking to destabilise the relationship between %5 and the local populace. If the communications aren't restored, the locals will lose faith in our ability to secure the area.</t>"
		};
		iconType = "B";
		iconPosition = "positionOffset";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
};

// Clear Minefield
class RTF_ORANGE_CIV_MINEFIELD: Task_Clear_Minefield {
	scope = 1;
	typeID = 201;
	positionNearLast = 1;
	class TaskDetails {
		title = "Clear UXO";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Civilians have reported several casualties to IDAP as a result of some unexploded ordinance near %5 left from recent operations by %6. IDAP has requested that %6 Taskforce clear the area to prevent any more from happening.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 Taskforce will move to the identified UXO field and begin clearing using minesweepers and explosives. Limit damage to civilian infrastructure where possible.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Nearby %7 insurgents might likely see this as an opportunity to attack and disrupt %6 operations. Expect possible light to medium arms fire.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted.</t>"
		};
		iconType = "C";
		iconPosition = "positionOffset";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Markers {};
};
