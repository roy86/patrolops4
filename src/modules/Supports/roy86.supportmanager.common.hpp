/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-21
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class CfgMissionSupports {
	class AvailableSupports {
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
			delay = "60 + (_dist/1000*4.66)";
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
	class Supplydrops {
		vehicles[] = {"O_T_VTOL_02_vehicle_dynamicLoadout_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_vehicle_F"};
		ammoboxes[] = {"O_supplyCrate_F","B_supplyCrate_F","I_supplyCrate_F"};
		UAVs[] = {"O_UGV_01_rcws_F","B_UGV_01_rcws_F","I_UGV_01_rcws_F"};
		UGVs[] = {"O_UGV_01_rcws_F","B_UGV_01_rcws_F","I_UGV_01_rcws_F"};
		/* class Vehicles {
			west[] = {"B_T_VTOL_01_vehicle_F"};
			east[] = {"O_T_VTOL_02_vehicle_dynamicLoadout_F"};
			guer[] = {"B_T_VTOL_01_vehicle_F"};
		};
		class Ammoboxes {
			west[] = {"B_supplyCrate_F"};
			east[] = {"O_supplyCrate_F"};
			guer[] = {"I_supplyCrate_F"};
		}; */
	};
};

#include "ui\roy86.gear.amreltablet.rsc.control.support.cas.hpp"
#include "ui\roy86.gear.amreltablet.rsc.control.support.firemission.hpp"
#include "ui\roy86.gear.amreltablet.rsc.control.support.map.hpp"
#include "ui\roy86.gear.amreltablet.rsc.control.support.showofforce.hpp"
#include "ui\roy86.gear.amreltablet.rsc.control.support.supplydrop.hpp"
#include "ui\roy86.gear.amreltablet.rsc.control.support.uav.hpp"
#include "ui\roy86.gear.amreltablet.rsc.display.support.hpp"