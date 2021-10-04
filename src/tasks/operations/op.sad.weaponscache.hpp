// Search and Destroy Weapons Cache
class OP_SAD_WeaponsCache: Task_Base_F {
	scope = 1;
	typeID = 2;
	minIntelScore = 15;
	class TaskDetails {
		title = "%1";
		description[] = {
			"<t>Ref: %2</t> | <t>Date: %3</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t><br/>Lethal aid has been distributed across %4 by insurgent forces. This has significantly increased the risk level to locals and %5 forces in the area and is likely to inhibit operations if not dealt with.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%5 Task Force is tasked with identifing locations of lethal aid weapon caches and destroy them through controlled detonations.<br/>Secondary Actions: Locate any intel on targets of opportunity and keep civilian casualties to a minimum.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>The location of the caches has not been determined. Additional intel from local civilians, enemy forces and terminals should be sought to provide a more accurate location.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Speak with civilians who may have intel on the target or enemy positions.<br/>Recovering intel from %6 forces may provide leads on a location or target of opportunity.</t>"
		};
		iconType = "Destroy";
		textArguments[] = {"operationName","randomCode","datetime","worldName","factionBLUshort","factionOPFshort"};
	};
	class ChildTasks {
		class SAD_WeaponsCache_IntelSearch {};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_childTasksComplete";
		};
	};
};

class SAD_WeaponsCache_IntelSearch: Task_Base_F {
	scope = 1;
	typeID = 201;
	positionSearchTypes[] = {"Town","Village","City"};
	positionSearchRadius = 2000;
	class TaskDetails {
		title = "Locate Lethal Aid";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Target is believed to be currently operating in the areas around %5 in %3 of %4. The area is known to have high traffic with both enemy and civilian present in the area.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 Task Force will move to the area, clear and secure a foothold before conducting patrols to locate and capture the target.</t>"
			,"<t size='1.1' color='#FFC600'>Intel:</t> <t>It is unknown at this time how the target is moving the lethal aid through %4. The target is likely to be guarded by an unknown number of infantry and possible vehicles.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilians are present in the area and are likely to be either intimidated by or supportive of %7 forces. Use caution as operations are conducted in the area.</t>"
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
};

class SAD_WeaponsCache_Cache1: Task_Base_F {
	scope = 1;
	typeID = 201;
};
class SAD_WeaponsCache_Cache2: Task_Base_F {
	scope = 1;
	typeID = 201;
};
class SAD_WeaponsCache_Cache3: Task_Base_F {
	scope = 1;
	typeID = 201;
};