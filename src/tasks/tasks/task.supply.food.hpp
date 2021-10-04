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
class Task_Supply_Food {
	scope = 1;
	target = -1;
	typeID = 21;

	areaSize[] = {1000,1000};
	positionSearchRadius = 3000;
	positionSearchTypes[] = {"Town","Village"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Deliver Supplies near %5";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>Civilians are struggling near %5. They have been raided by what INTEL indicates %7 forces and have no food or medicine.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 will transport the supplies from the 'Return Point' at base to the location and successfully delivery without loss or damage</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>It is likely the local insurgency or resistance will attempt a strike at the vehicles. No intel specifically indicates the details or strength of any attacks.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Deploy the tower within the radius of the location. If the container is destroyed or the tower deployed in the wrong location, you will fail.</t>"
		};
		iconType = "default";
		iconPosition = "positionOffset";
		textArguments[] = {"randomCode","datetime","worldRegion","worldName","nearestTown","factionBLUshort","factionOPFshort"};
	};
	class Markers {
		class marker_A {
			position = "positionOffset";
			shape = "ELLIPSE";
			brush = "SolidBorder";
			colour = "ColorBlufor";
			size[] = {350,350};
			alpha = 0.5;
		};
		class marker_C: marker_A {
			brush = "SolidBorder";
			size[] = {30,30};
			alpha = 0.5;
		};
		class marker_D: marker_A {
			brush = "FDiagonal";
			colour = "ColorBlack";
			size[] = {30,30};
			alpha = 0.8;
			text = "Planned Position";
		};
	};
	class Groups {
		class Container1 {
			probability = 1;
			isTarget = 1;
			position = "return_point";
			objectTypes[] = {"B_Slingload_01_Cargo_F"};
			radius[] = {0,0};
		};
		class Container2: Container1 {
			probability = 1;
			minPlayers = 7;
		};
	}; 
	class Objective {
		class Succeeded {
			state = 1; // 0:Created, 1:Succeeded, 2: Failed, 3: Canceled
			condition = "_targetsDelivered";
		};
		class Failed {
			state = 2;
			condition = "_targetsDestroyed";
		};
	};
};
