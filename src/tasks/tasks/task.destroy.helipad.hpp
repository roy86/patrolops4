/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-02-10
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class Task_Destroy_Helipad {
	scope = 1;
	target = -1;
	typeID = 10;

 	areaSize[] = {1000,1000};
	positionSearchRadius = 3000;
	positionSearchTypes[] = {"Clearing"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Secure Helipad near %5";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL has identified a small clearing where %7 forces have established a small helipad and are receiving supplies. This helipad is key to their operations in that area.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area locate and destroy the helipads communications and fuel supplies with explosives and engage any %7 forces before retrieving any intel from technological assets.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a likelyhood of only one small squad operating in that area with small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "fuel";
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

	class Compositions {
		class CommsTent {
			position = "positionOffset";
			typeIDs[] = {"en_helipad_1"};
			targets[] = {"Land_TTowerSmall_2_F"};
		};
	};

	class Groups {
		class EN_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS4","SquadAmbushINS8"};
			isPatrolling = 0.9;
			radius[] = {50,150};
			isDefending = 1;
			occupyBuildings = 1;
			dropIntel = 1;
		};
		class EN_Group_2: EN_Group_1 {
			minPlayers = 2;
			distance[] = {100,150};
			radius[] = {150,200};
		};
		class EN_Group_3: EN_Group_1 {
			minPlayers = 6;
			distance[] = {150,200};
			radius[] = {200,250};
		};
		class EN_Vehicle_Group_1 {
			probability = 0.85;
			position = "positionOffset";
			distance[] = {50,100};
			direction[] = {0,360};
			faction = "FactionTypeOPF";
			vehicleTypes[] = {"CarTurret_INS","Car_INS"};
			createCrew = 1;
			isPatrolling = 0.6;
			radius[] = {150,250};
		};
		class EN_Vehicle_Group_2: EN_Vehicle_Group_1 {
			probability = 0.7;
			minPlayers = 5;
			isPatrolling = 1;
			vehicleTypes[] = {"CarTurret_INS","Armour_APC","I_C_Offroad_02_LMG_F"};
		};
		class EN_Vehicle_Group_3: EN_Vehicle_Group_2 {
			probability = 0.7;
			minPlayers = 10;
			radius[] = {250,500};
		};
		class EN_Vehicle_Group_4: EN_Vehicle_Group_3 {
			probability = 0.7;
			minPlayers = 10;
			radius[] = {250,500};
		};
	};
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsdestroyed";
		};
	};
};