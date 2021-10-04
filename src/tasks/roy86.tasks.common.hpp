class CfgTaskEnhancements {
	enable       = 1; // 0: disable new task features (default), 1: enable new task features & add new task markers and task widgets into the map
	3d           = 1; // 0: do not use new 3D markers (default), 1: replace task waypoints with new 3D markers
	3dDrawDist   = 9000; // 3d marker draw distance (default: 2000)
	share        = 1; // 0: do not count assigned players (default), 1: count how many players have the task assigned
	propagate    = 1; // 0: do not propagate (default), 1: propagate shared tasks to subordinates
};

/* 
	Task TypeIDs
	10-19 - Operations
		10 - OP-Air
		11 - OP-RTF
		12 - OP-SAD
		13 - OP-CAP
		14 - OP-SEC
	20-99 - Tasks
		20 - Destroy
			21 - Destroy Vehicle
		30 - Intel
			31 - Download
			32 - Pickup
			33 - Recieve
		40
		50
		60
		70
		80
		90
	100-109 - Encounters
		101 - Area based encounters (determined on start)
		102 - Movement based encounters
		103 - Time based encounters
		104 - Random time based encounters

	positionSearchTypes[] = {"Shack","Forest","Village","Clearing","Hill","House","Farm","Villa","Fuel","Factory","Airport","Military","Tower","Dock","SportField","Ruin"};
*/

class CfgMissionTasks {
	// Task Objects
	intelDropTypes[] = {"Land_Suitcase_F"};//,"Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Map_F","Land_Notepad_F","Land_HandyCam_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_PortableLongRangeRadio_F","Land_File_research_F","Land_Tablet_01_F","Land_Tablet_02_F"};
	intelDownloadTypes[] = {"Land_DataTerminal_01_F","Land_Device_assembled_F","Land_Device_disassembled_F","Land_Laptop_F","Land_Laptop_unfolded_F","Land_Laptop_device_F","Land_SatellitePhone_F","UAV"};
	WeaponCacheTypes[] = {"Box_FIA_Ammo_F","Box_FIA_Support_F","Box_FIA_Wps_F"};
	TowerTypes[] = {};
	SupplyTypes[] = {};
	iedTypes[] = {"Land_Wreck_Truck_dropside_F","Land_Wreck_BMP2_F","Land_Wreck_Skodovka_F","Land_Wreck_Ural_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_CarDismantled_F","Land_Wreck_BRDM2_F","Land_Wreck_Car_F","Land_Wreck_Car2_F","Land_Wreck_AFV_Wheeled_01_F","Land_Wreck_Truck_F","Land_Wreck_Truck_dropside_F","Land_Wreck_UAZ_F","Land_Wreck_Van_F","IEDLandSmall_F","IEDUrbanSmall_F","IEDLandBig_F","IEDUrbanBig_F"};

	class PatrolOperations {
		scope = 2;
		target = -1;
		typeID = 0;
		areaSize[] = {1000,1000};
		positionSearchRadius = 1000;
		class TaskDetails {
			title = "Patrol %1";
			description[] = {
				"<t>Ref: %2</t> | <t>Date: %3</t>"
				,"<t size='1.1' color='#FFC600'>Brief:</t> <t>%1 has been a region of heavy conflict for the last several years. Under current occupation by %4 Forces, the region has a tenuous sense of stability despite small underground groups running an insurgency in the hopes of profiting from a black market resource trade.</t>"
				,"<t size='1.1' color='#FFC600'>Action:</t> <t>%4 Forces will conduct regional patrols around the landscape of %1. The objective is to maintain a constant presence visible to the civilian population and to gather INTEL on regional insurgent activities in the hope of mounting further operations to eliminate it.</t>"
				,"<t size='1.1' color='#FFC600'>Enemy:</t> <t>Little is known about what the insurgency have with respect to their resources however attacks have begun to increase in the last month. While there is no evidence of external funding and resourcing, there have been reports of %6 observers in the region and COMMAND has suspicion that the insurgency is backed by %5 Forces. More INTEL is needed before mounting serious operations against insurgent supply lines, key personnel and potentially engagements with %5 Forces.</t>"
				,"<t size='1.1' color='#FFC600'>Note:</t> <t>Redacted</t>"
			};
			iconType = "Default";
			textArguments[] = {"worldName","randomCode","datetime","factionBLUlong","factionOPFlong","factionOPFshort"};
		};
		class ChildTasks {
			childtasks[] = {"Task_Patrol_Area_1","Task_Patrol_Area_2","Task_Patrol_Area_3"};
		};
		class Objective {
			class Succeeded {
				state = 1;
				//condition = "_missionComplete";
				condition = "false";
			};
		};
	};

	// Encounters
	class Task_Encounter_Base_F {
		scope = 0;
		target = -1;
		typeID = 0;
		areaSize[] = {250,250};
		positionSearchRadius = 500;
		class TaskDetails {
			title = "Test %13";
			description[] = {"factionblushort: %1","factionblulong: %2","factionbluside: %3","factionopfshort: %4","factionopflong: %5","factionopfside: %6","vehiclename: %7","worldname: %8","worldregion: %9","gridreference: %10","nearesttown: %11","nearestlocation: %12","randomcode: %13","operationname: %14","missionname: %15","briefingname: %16","servername: %17","playername: %18","hh: %19","hh:mm: %20","hh:mm:ss: %21","datetime: %22"};
			textArguments[] = {"factionblushort","factionblulong","factionbluside","factionopfshort","factionopflong","factionopfside","vehiclename","worldname","worldregion","gridreference","nearesttown","nearestlocation","randomcode","operationname","missionname","briefingname","servername","playername","hh","hh:mm","hh:mm:ss","datetime"};
			iconType = "Default";
			iconPosition = "positionOffset";
		};
		class Markers {
			class marker_target {
				position = "positionOffset";
				shape = "ICON";
				type = "mil_objective";
				colour = "ColorOpfor";
				size[] = {0.8,0.8};
				alpha = 0.6;
				text = "Triggered Encounter";
			};
		};
	};
	#include "encounters\encounters.common.hpp"

	#include "tasks\task.clear.minefield.hpp"
	#include "tasks\task.deploy.tower.hpp"
	#include "tasks\task.destroy.artillery.hpp"
	#include "tasks\task.destroy.cache.hpp"
	#include "tasks\task.destroy.commstower.hpp"
	#include "tasks\task.destroy.dealer.hpp"
	#include "tasks\task.destroy.fueldepot.hpp"
	#include "tasks\task.destroy.helipad.hpp"
	#include "tasks\task.destroy.hvt.hpp"
	#include "tasks\task.destroy.manpad.hpp"
	#include "tasks\task.destroy.sam.hpp"
	#include "tasks\task.destroy.squad.hpp"
	#include "tasks\task.destroy.vehicles.hpp"
	#include "tasks\task.download.intel.camp.hpp"
	#include "tasks\task.patrol.areas.hpp"
	#include "tasks\task.recover.hvt.hpp"
	#include "tasks\task.supply.food.hpp"

	#include "operations\op.air.superiority.hpp"
	#include "operations\op.rtf.commsnetwork.hpp"
	#include "operations\op.rtf.orange.civ.hpp"
	#include "operations\op.rtf.supply.civ.hpp"
	//#include "operations\op.sad.commsnetwork.ins.hpp"
	//#include "operations\op.sad.device.ins.hpp"
	//#include "operations\op.sad.enemycamps.ins.hpp"
	//#include "operations\op.sad.fuelsupply.hpp"
	//#include "operations\op.sad.hvt.dealer.hpp"
	#include "operations\op.sad.hvt.ins.hpp"
	//#include "operations\op.sad.weaponscache.hpp"
};