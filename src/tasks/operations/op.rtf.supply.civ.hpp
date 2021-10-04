// Reconstruction Task Force Civilian Supply Operation
class OP_RTF_Supply_CIV {
	summary = "RTF Operation to deliver urgent supplies in difficult circumstances";
	scope = 1;
	target = -1;
	typeID = 9;
	minIntelScore = 5;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL indicates a deteriating situation is developing in %4 with a number of towns reporting sever supply shortages of food, fuel and water after being allegedly raided by %6 forces. These attacks appear to be increasing and until either the locals align them selves to %6 or %5 forces intervene, the situation will continue to escalate.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 Task Force will move to the impacted areas and conduct reconstrunction operations to restore life saving supplies and set up terrain denial positions to inhibit %6 movements in the area as a show of force.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>Supply lines are under threat from %6 attacks. Expect contact en-route and at the target AO. Performing terrain denial patrols will deter hostiles from operating in the area.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilians are being pushed to breaking point and the delayed action by %5 has resulted in increased influence from %6 supporting a power shift in the region. Win hearts and minds, get the people on side by being present.</t>"
		};
		iconType = "container";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};
	class ChildTasks {
		class OP_RTF_Supply_CIV_Task1 {};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};

// Resupplly Civilian Town
class OP_RTF_Supply_CIV_Task1: Task_Supply_Food {
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
	class Groups {};
};

/* class RTF_SUPPLY_CIV_TerrainDenial: Task_Base_F {
	scope = 1;
	typeID = 201;
	positionSearchTypes[] = {"Hill","Clearing","Town","Village"};
	positionSearchRadius = 2000;
	class TaskDetails {
		title = "Secure Foothold near %5";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%7 forces have been spotted moving supplies and leathal aid through an area near %5. It is essential that their operations are disrupted in efforts to regain control over the %4 region.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 Task Force will move to and set up positions covering the area to inhibit %7 movements and prevent them from operating through the area. Any contact should be assessed and engaged.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>%7 presence is expected however is often concealed. It is understood from intel that they are using civilian vehicles and are likely to avoid heavy contact where possible.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>This is largely an observation mission however be on alert in case the terrain denial caused a heavier than anticipated response.</t>"
		};
		iconType = "A";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Markers {
		class marker_A {
			shape = "RECTANGLE";
			brush = "SolidBorder";
			colour = "ColorOpfor";
			size[] = {0.99,0.99};
			alpha = 0.2;
		};
		class marker_B: marker_A {
			brush = "Border";
			size[] = {1.2,1.2};
			alpha = 1;
		};
		class marker_C: marker_A {
			brush = "Border";
			size[] = {1.0,1.0};
			alpha = 1;
		};
		class marker_D: marker_A {
			brush = "FDiagonal";
			size[] = {1.2,0.1};
			alpha = 0.9;
			direction = 0;
			distance = 1.1;
		};
		class marker_E: marker_D {
			direction = 180;
		};
		class marker_F: marker_D {
			size[] = {1.0,0.1};
			direction = 90;
			angle = 90;
		};
		class marker_G: marker_F {
			direction = 270;
		};
	};
	class Groups {
		class INS_Group_1 {
			probability = 1;
			position = "position";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
			isPatrolling = 1;
			radius[] = {300,500};
		};
		class INS_Group_2 {
			probability = 0.85;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad4_INS"};
			isPatrolling = 0.3;
			isDefending = 1;
			occupyBuildings = 1;
			radius[] = {100,300};
		};
		class INS_Group_3 {
			probability = 1;
			minPlayers = 5;
			position = "position";
			faction = "FactionTypeOPF";
			groupTypes[] = {"Squad8_INS","Squad4_INS"};
			isPatrolling = 1;
			radius[] = {500,600};
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
			nextTask[] = {};
		};
	};
}; */