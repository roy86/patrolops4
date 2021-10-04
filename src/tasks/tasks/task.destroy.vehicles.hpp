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
class Task_Destroy_Vehicles {
	scope = 1;
	target = -1;
	typeID = 21;
	minIntelScore = 20;

	areaSize[] = {1000,1000};
	positionSearchRadius = 4000;
	positionSearchTypes[] = {"Clearing","Hill","Town","Village","City","Military","SportField"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Interupt Supplies Exchange";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL indicates %7 are recieving weapons and equipment from an unknown external party somewhere near %5. This supply line is a key strategic objective to cut in order to prevent further leathal aid entering %4.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep in order to locate and destroy the target supply vehicles and gather any further intel available.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with possible small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "default";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};

	class Markers {
		class marker_A {
			position = "position";
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
		class TargetVehicle1 {
			isTarget = 1;
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"Truck_INS","Truck_Support"};
			createCrew = 1;
			radius[] = {80,120};
			distance[] = {20,40};
			direction[] = {0,180};
		};
		class TargetVehicle2: TargetVehicle1 {
			probability = 0.7;
			minPlayers = 2;
			distance[] = {20,40};
			direction[] = {180,360};
		};
		class TargetVehicle3: TargetVehicle1 {
			probability = 0.7;
			minPlayers = 4;
			distance[] = {20,40};
			direction[] = {180,360};
		};
		class EnemyGroup1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadINS4","SquadINS8"};
			distance[] = {20,50};
			direction[] = {0,360};
			isPatrolling = 0.9;
			isDefending = 1;
			occupyBuildings = 1;
			radius[] = {50,150};
		};
		class EnemyGroup2: EnemyGroup1 {
			minPlayers = 3;
			distance[] = {100,150};
			radius[] = {150,200};
		};
		class EnemyGroup3: EnemyGroup1 {
			minPlayers = 8;
			distance[] = {100,150};
			radius[] = {150,200};
		};
		class EnemyVehicleGroup1 {
			probability = 0.85;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"CarTurret_INS","Car_INS"};
			createCrew = 1;
			distance[] = {50,100};
			direction[] = {0,360};
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EnemyVehicleGroup2: EnemyVehicleGroup1 {
			probability = 0.7;
			minPlayers = 8;
			vehicleTypes[] = {"CarTurret_INS"};
		};
		class EnemyVehicleGroup3: EnemyVehicleGroup1 {
			probability = 0.7;
			minPlayers = 16;
			vehicleTypes[] = {"Armour_APC"};
		};
	};
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsKilled";
		};
	};
};