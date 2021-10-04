// Search and Destroy Insurgent Fuel Supplies
class OP_SAD_FuelSupply_INS {
	summary = "Enemy forces are raiding civilian fuel supplies and need to be stopped";
	scope = 1;
	target = -1;
	typeID = 9;
	minIntelScore = 4;

	areaSize[] = {1000,1000};
	positionSearchRadius = 1000000;
	positionSearchTypes[] = {"Fuel"};
	positionNearLast = 1;

	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Reports from local town leaders indicate %6 forces are raiding their fuel supplies in an effort to undermine %5 influence in the area.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 forces will move to any recently reported incidents to secure the area against %6 forces and to build a positive influence with local civilians by making them feel safer.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%6 are operating a minimal operation with reports indiciating usage of light technicals to maintain speed and low profile.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Speak with civilians who may have intel on the target or enemy positions.<br/>Recovering intel from %6 forces may provide leads on a location or target of opportunity.</t>"
		};
		iconType = "refuel";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};

	class ChildTasks {
		class OP_SAD_FuelSupply_INS_Task1 {};
		class OP_SAD_FuelSupply_INS_Task2 {};
		class OP_SAD_FuelSupply_INS_Task3 {};
	};

	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};

class OP_SAD_FuelSupply_INS_Task1: Task_Destroy_Squad {
	positionSearchTypes[] = {"Fuel"};
	class TaskDetails {
		title = "Destroy";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Reports from local town leaders indicate %6 forces are raiding their fuel supplies in an effort to undermine %5 influence in the area.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 forces will move to any recently reported incidents to secure the area against %6 forces and to build a positive influence with local civilians by making them feel safer.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%6 are operating a minimal operation with reports indiciating usage of light technicals to maintain speed and low profile.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Speak with civilians who may have intel on the target or enemy positions.<br/>Recovering intel from %6 forces may provide leads on a location or target of opportunity.</t>"
		};
		iconPosition = "position";
		iconType = "refuel";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};
};

class OP_SAD_FuelSupply_INS_Task2: OP_SAD_FuelSupply_INS_Task1 {};
class OP_SAD_FuelSupply_INS_Task3: OP_SAD_FuelSupply_INS_Task1 {};