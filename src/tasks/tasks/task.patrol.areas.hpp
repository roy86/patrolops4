/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-02-11
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class Task_Patrol_Area {
	scope = 1;
	target = -1;
	typeID = 21;

	areaSize[] = {1500,1500};
	positionSearchTypes[] = {"Clearing","Hill","Farm","Military","SportField","Town","Village"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Patrol Area around %5";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>There are reports of a %7 patrol operating near %5 and that %6 command would like the area secured.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area to conduct a sweep in order to locate and elimiate any %7 forces in the area.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a likelyhood of only one small squad operating in that area with small arms and possibly an additional light technical.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Civilian population are neutral and are unlikely to be a concern. Keep an eye out for watchers who will track %6 movements and report to the enemy.</t>"
		};
		iconType = "default";
		iconPosition = "position";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	
	class Markers {
		class marker_A {
			shape = "ELLIPSE";
			brush = "SolidBorder";
			colour = "ColorOpfor";
			size[] = {1.2,1.2};
			alpha = 0.2;
		};
		class marker_D: marker_A {
			brush = "FDiagonal";
			size[] = {0.9,0.9};
			alpha = 0.8;
		};
	};

	class Groups {
		class EN_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS4","SquadAmbushINS8"};
			isPatrolling = 1;
			radius[] = {300,500};
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
	};

	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_unitsKilled || _intelPickedUp";
			nextTasks[] = {"Task_Patrol_Area"};
			//nextTask[] = {"Task_Clear_Minefield","Task_Deploy_Tower","Task_Destroy_Artillery","Task_Destroy_CommsTower","Task_DestroyDrugDealer","Task_Destroy_FuelDepot","Task_Destroy_Helipad","Task_Destroy_HVT","Task_Destroy_Manpad","Task_Destroy_SAM","Task_Destroy_Squad","Task_Destroy_Vehicles","Task_Download_intel_camp","Task_Recover_HVT","Task_Supply_Food"};
		};
	};
};

class Task_Patrol_Area_1: Task_Patrol_Area {};
class Task_Patrol_Area_2: Task_Patrol_Area {};
class Task_Patrol_Area_3: Task_Patrol_Area {};