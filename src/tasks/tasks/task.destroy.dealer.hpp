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
class Task_DestroyDrugDealer {
	scope = 1;
	target = -1;
	typeID = 21;

	areaSize[] = {1000,1000};
	positionSearchRadius = 3000;
	positionSearchTypes[] = {"House"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Locate Drug Dealer";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL has shown a pattern of civilians becoming sick after recieving treatment for ailments. It has been identified that many contaminated batches of pain medication have been procured through a drug dealer at high cost and significant risk to civilian health. </t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 forces will move to the area near %5 to conduct a sweep in order to locate and elimiate the drug dealers equipment and put him out of business.</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>%7 forces are minimal with a unlikely to be operating in that area.</t>"
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
		class DrugDealerGroup {
			probability = 1;
			isTarget = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"DrugDealer"};
			radius[] = {100,100};
			isDefending = 1;
			occupyBuildings = 1;
			dropIntel = 1;
		};
		class EN_Group_1 {
			probability = 1;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAmbushINS4","SquadAmbushINS8"};
			isPatrolling = 0.8;
			radius[] = {50,150};
			isDefending = 1;
			occupyBuildings = 1;
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsKilled";
		};
	};
};