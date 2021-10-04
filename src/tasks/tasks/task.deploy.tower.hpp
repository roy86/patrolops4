/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-02-16
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class Task_Deploy_Tower {
	scope = 1;
	target = -1;
	typeID = 21;

	areaSize[] = {1000,1000};
	positionSearchRadius = 3000;
	positionSearchTypes[] = {"Hill"};
	positionIsWater = 0;

	class TaskDetails {
		title = "Deploy Tower near %5";
		description[] = {
			"<t>Ref: %1</t> | <t>Date: %2<br/>AO: %3 %4 near %5</t>"
			,"<t size='1.1' color='#FFC600'>Brief:</t> <t>INTEL shows an opporunity that for Hearts and Minds. Recent attacks have interupted civilian communications around %5 with mobile towers being cut off. %6 have deployable communnications equipment that will restore the local communications networks.</t>"
			,"<t size='1.1' color='#FFC600'>Action:</t> <t>%6 will transport the deployable comms tower from the 'Return Point' at base to the location and successfully set it up</t>"
			,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>It is likely the local insurgency or resistance will attempt a strike at the vehicles without knowledge of the purpose of this task. No intel specifically indicates the details or strength of any attacks.</t>"
			,"<t size='1.1' color='#FFC600'>Note:</t> <t>Deploy the tower within the radius of the location. If the container is destroyed or the tower deployed in the wrong location, the task is considered a failure.</t>"
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
	class DeployableObjects {
		class Comms_Tower {
			containerClass = "B_Slingload_01_Cargo_F";
			deployClass = "Land_Communication_F";
			position = "return_point";
			angle = -1;
			class Destination {
				position = "positionOffset";
				radius = 30;
			};
		};
	};
	class Groups {
		class INS_Group_1 {
			probability = 0.3;
			position = "positionOffset";
			faction = "FactionTypeOPF";
			groupTypes[] = {"SquadAAINS4","SquadAAINS8"};
			isAttacking = 1;
			distance[] = {1000,1000};
			direction[] = {0,359};
			radius[] = {300,500};
			dropIntel = 1;
		};
	};
	class Objective {
		class Succeeded {
			state = 1;
			condition = "_targetsDeployed";
		};
		class Failed {
			state = 2;
			condition = "_targetsDestroyed";
		};
	};
};