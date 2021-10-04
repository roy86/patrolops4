/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define PO_EDITION_ALTIS
//#define PO_UI_PAPER
#define PO_UI_AMREL
// #define PO_MODIFIEDBY "Your Name Here"

PatrolOpsVersion = "4.1";
missionDebugMode = 0;
missionRadioName = "Patrol Ops";

enableNewStarterUI = 1;
enableActionBodyBags = 1;
enableActionBodySearch = 1;

class cfgMission {
    // Player Faction
	FactionTypeBLU	= "PatrolOps_Blufor_Altis";

    // AI Faction
	FactionTypeOPF	= "PatrolOps_Opfor_Altis";

    // Civilian Faction
	FactionTypeCIV 	= "Civilian_Altis";

	introText[] = {
#ifdef PO_EDITION_ALTIS
		{"Patrol Operations %6","<t size='2' shadow='0' color='#ffc600' align='center' valign='center'>%1</t><br/>"},
#endif
		{"The situation on Altis is degrading significantly.","<t size='0.8' shadow='0' color='#ffffff'>%1</t><br/>"},
		{"NATO has intervened after sever government crackdowns but is now being viewed by citizens as an aggressive hostile force","<t size='0.8' shadow='0' color='#ffffff'>%1</t><br/><br/>"},
		{"The situation is becoming tense.","<t size='1' shadow='0' color='#ffc600'>%1</t><br/><br/>"},
		{"NATO is tasked with reconstruction efforts and public safety.","<t size='0.8' shadow='0' color='#ffffff'>%1</t><br/>"},
		{"Conduct patrols, locate intel to uncover possible operations, and stay safe","<t size='0.8' shadow='0' color='#ffffff'>%1</t><br/>"},
		{"",""}
	};
	introTextArguments[] = {"factionblushort","factionblulong","factionopfshort","factionopflong","factionopfside","worldname","randomcode","codename","operationname","missionname","briefingname","servername","playername","hh","hh:mm","hh:mm:ss","datetime"};

	ActionBodyBags = 1;
	ActionBodySearch = 1;

	class Encounters {
		// If a squad leader does not move for a number of seconds, an attack will occur on their position
		stationaryEncountersTimer = 120;
		// SVIEDs
		enableSVIDs = 0;
	};
    
    // Other
    allTraits[] = {"Crewman","PilotHeli","PilotPlane","Medic","Engineer","ExplosiveSpecialist","HALO"};

	class Supports {
		class USSLiberty_MK41 {
			scope = 2;
			displayName = "USS Liberty MK41 VLS";
			classname = "B_Ship_MRLS_01_F";
			magazines[] = {"magazine_Missiles_Cruise_01_x18","magazine_Missiles_Cruise_01_Cluster_x18"};
			delay = "290 + (_dist/1000*4.66)";
			availableForSupportTypes[] = {"Artillery"};
			size = 1;
		};
		class USSLiberty_MK45 {
			scope = 2;
			displayName = "USS Liberty MK45 Hammer";
			classname = "B_Ship_Gun_01_F";
			magazines[] = {"magazine_ShipCannon_120mm_HE_shells_x32","magazine_ShipCannon_120mm_HE_guided_shells_x2","magazine_ShipCannon_120mm_HE_LG_shells_x2","magazine_ShipCannon_120mm_HE_cluster_shells_x2","magazine_ShipCannon_120mm_mine_shells_x6","magazine_ShipCannon_120mm_smoke_shells_x6","magazine_ShipCannon_120mm_AT_mine_shells_x6"};
			availableForSupportTypes[] = {"Artillery"};
			size = 1;
		};
		class BatteryM4Scorcher {
			scope = 2;
			displayName = "FOB M4 Scorcher";
			classname = "B_MBT_01_arty_F";
			magazines[] = {"32Rnd_155mm_Mo_shells","4Rnd_155mm_Mo_guided","6Rnd_155mm_Mo_mine","2Rnd_155mm_Mo_Cluster","6Rnd_155mm_Mo_smoke","2Rnd_155mm_Mo_LG","6Rnd_155mm_Mo_AT_mine"};
			availableForSupportTypes[] = {"Artillery"};
			size = 3;
		};
		class BatteryM5MLRS {
			scope = 2;
			displayName = "FOB M5 MLRS";
			classname = "B_MBT_01_mlrs_F";
			magazines[] = {"12Rnd_230mm_rockets"};
			availableForSupportTypes[] = {"Artillery"};
			size = 3;
		};
		class BatteryMk6Mortar {
			scope = 2;
			displayName = "FOB Mk6 Mortar";
			classname = "B_Mortar_01_F";
			magazines[] = {"8Rnd_82mm_Mo_shells","8Rnd_82mm_Mo_shells","8Rnd_82mm_Mo_shells","8Rnd_82mm_Mo_shells","8Rnd_82mm_Mo_Flare_white","8Rnd_82mm_Mo_Smoke_white"};
			availableForSupportTypes[] = {"Artillery"};
			size = 4;
		};
		class CAS1 {
			scope = 2;
			displayName = "F/A-181 Black Wasp II";
			classname = "B_Plane_Fighter_01_Stealth_F";
			magazines[] = {"magazine_Fighter01_Gun20mm_AA_x450"};
			availableForSupportTypes[] = {"CAS_Bombing"};
			size = 1;
		};
		class CAS2 {
			scope = 2;
			displayName = "F/A-181 Black Wasp II (Cluster)";
			classname = "B_Plane_Fighter_01_Cluster_F";
			magazines[] = {"magazine_Fighter01_Gun20mm_AA_x450"};
			availableForSupportTypes[] = {"CAS_Bombing"};
			size = 1;
		};
		/* class CAS2 {
			scope = 2;
			displayName = "CASH";
			classname = "B_Heli_Attack_01_F";
			magazines[] = {"1000Rnd_20mm_shells","4Rnd_AAA_missiles","24Rnd_PG_missiles"};
			availableForSupportTypes[] = {"CAS_Heli"};
			size = 1;
		}; */
	};
};