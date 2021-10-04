// Search and Destroy Insurgent Comms Network
class OP_SAD_CommsNetwork_INS: Task_Base_F {
	scope = 0;
	typeID = 2;
	minIntelScore = 4;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>REDACTED</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>REDACTED</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>REDACTED</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>REDACTED</t>"
		};
		iconType = "Default";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};
	class ChildTasks {};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};