/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-25
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
// Create random hostile squad
class E_000_Marked_EN: Task_Encounter_Base_F {
	scope = 1;
	typeID = 101;
	class Conditions {
		areas[] = {"Village","Town","Clearing","Forest","Hill"};
		vehicleTypes[] = {"Car","Man"};
		timeout = 10;
		sideChat = "Intel reporting possible hostiles occupying areas nearby";
	};
	class Groups {
		class INS_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS8","SquadAmbushINS4"};
			isPatrolling = 0.8;
			isDefending = 1;
			occupyBuildings = 1;
			radius[] = {300,500};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
};

class E_001_SQD_EN: Task_Encounter_Base_F {
	scope = 1;
	typeID = 101;
	class Conditions {
		areas[] = {"Village","Town","Clearing","Forest","Hill"};
		vehicleTypes[] = {"Car","Man"};
		timeout = 10;
		sideChat = "Intel reporting possible hostiles occupying areas nearby";
	};
	class Groups {
		class INS_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS8","SquadAmbushINS4"};
			isPatrolling = 0.8;
			isDefending = 1;
			occupyBuildings = 1;
			radius[] = {300,500};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
};

class E_002_VEH_EN: Task_Encounter_Base_F {
	scope = 1;
	typeID = 101;
	class Conditions {
		areas[] = {"Village","Town","Clearing"};
		vehicleTypes[] = {"Man","LandVehicle"};
		timeout = 60;
		sideChat = "Intel reporting possible hostiles occupying areas nearby";
	};
	class Groups {
		class GroupINSVeh {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadATINS8","SquadATINS4"};
			isPatrolling = 1;
			radius[] = {300,600};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
};

class EN_003_Fuel_INS: Task_Encounter_Base_F {
	scope = 1;
	typeID = 101;
	class Conditions {
		areas[] = {"Fuel"};
		vehicleTypes[] = {"Man","Car"};
		timeout = 60;
		sideChat = "Intel reporting possible hostiles occupying fuel stations nearby";
	};
	class Groups {
		class GroupINSVeh {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS8","SquadAmbushINS4","SquadATINS8","SquadATINS4"};
			isPatrolling = 0.5;
			isDefending = 1;
			occupyBuildings = 1;
			radius[] = {150,200};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
};

class EN_004_HillAA_INS: Task_Encounter_Base_F {
	scope = 1;
	typeID = 103;
	class Conditions {
		areas[] = {"Hill","Clearing"};
		vehicleTypes[] = {"Helicopter"};
		timeout = 600;
		sideChat = "Intel Reporting Unknown Manpads Around";
	};
	class Groups {
		class GroupINSVeh {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAAINS8","SquadAAINS4"};
			isPatrolling = 0.5;
			isDefending = 1;
			radius[] = {150,200};
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
};

class EN_004_Air_INS: Task_Encounter_Base_F {
	scope = 1;
	typeID = 104;
	class Conditions {
		areas[] = {"Air"};
		vehicleTypes[] = {"Plane"};
		timeout = 600;
		sideChat = "AWAC Detecting Unknown Air Contacts Inbound";
	};
	class Groups {
		class AirCombatFighter_1 {
			probability = 1;
			position = "positionOffset";
			angle[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Fighter_Plane"};
			createCrew = 1;
			patrolAirspace = 1;
		};
		class AirCombatFighter_2: AirCombatFighter_1 {
			probability = 0.5;
			minPlayers = 3;
			distance[] = {20,30};
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
	};
};

class EN_005_Attack_INS: Task_Encounter_Base_F {
	scope = 1;
	typeID = 100;
	class Groups {
		class INS_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS8","SquadAmbushINS4"};
			isAttacking = 1;
			distance[] = {300,500};
			direction[] = {0,359};
			radius[] = {300,500};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_unitsKilled";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
	//
};

class EN_006_Attack_IED: Task_Encounter_Base_F {
	scope = 1;
	typeID = 102;
	class Conditions {
		areas[] = {"Road"};
		vehicleTypes[] = {"LandVehicle"};
		timeout = 600;
	};
	class Compositions {
		class MinefieldIED {
			mineFieldType = "IED";
			position = "positionOffset";
			radius = 150;
		};
	};
	class Groups {
		class INS_Group_1 {
			probability = 0.3;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS8","SquadAmbushINS4"};
			isAttacking = 1;
			distance[] = {300,500};
			direction[] = {0,359};
			radius[] = {300,500};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_targetsDestroyed";
		};
		class Canceled {
			state = 3;
			condition = "!(_playersNearby)";
		};
	};
};