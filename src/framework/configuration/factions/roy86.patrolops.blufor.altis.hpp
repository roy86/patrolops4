/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-02-09
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class PatrolOps_Blufor_Altis {
	displayName = "TF Lighthorse";
	displayLongName = "NATO Task Force Lighthorse";
	displayColour = "ColorBlufor";
	side = 1;
	class Groups {
		class TargetHVT {
			classNames[] = {"B_Officer_F","B_Recon_JTAC_F"};
		};
		class TargetHVT_INS {
			classNames[] = {"B_G_officer_F","B_G_Sharpshooter_F"};
		};
		class Squad8 {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_AA_F","B_Soldier_AR_F","B_Soldier_AT_F","B_Soldier_M_F","B_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_AA_F","B_Soldier_AA_F","B_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_AR_F","B_Soldier_AR_F","B_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_AT_F","B_Soldier_LAT_F","B_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_A_F","B_Soldier_GL_F","B_Soldier_M_F","B_Soldier_M_F","B_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {"B_G_Soldier_TL_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F","B_G_Soldier_AR_F","B_G_Soldier_AR_F","B_G_Soldier_LAT_F","B_G_Sharpshooter_F","B_G_medic_F"};
		};
		class Squad4 {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_F","B_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_AA_F","B_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_AR_F","B_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_AT_F","B_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"B_Soldier_TL_F","B_Soldier_GL_F","B_Soldier_M_F","B_Soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {"B_G_Soldier_TL_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F","B_G_medic_F"};
		};
		class Sniper {
			classNames[] = {"B_ghillie_sard_F","B_ghillie_sard_F"};
		};
		class Sniper_INS {
			classNames[] = {"B_G_Sharpshooter_F","B_G_Sharpshooter_F"};
		};
		class ParaMilitary {
			classNames[] = {"B_G_Soldier_TL_F","B_G_Soldier_GL_F","B_G_Soldier_LAT_F","B_G_Soldier_AR_F","B_G_Soldier_AR_F","B_G_Soldier_LAT_F","B_G_Sharpshooter_F","B_G_medic_F"};
		};
		class SpecOps {
			classNames[] = {"B_Recon_TL_F","B_Recon_F","B_Recon_M_F","B_Recon_LAT_F","B_Recon_JTAC_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"B_CTRG_soldier_GL_LAT_F","B_CTRG_soldier_AR_A_F","B_CTRG_Sharphooter_F","B_CTRG_soldier_engineer_exp_F","B_CTRG_soldier_M_medic_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"B_Truck_01_ammo_F","B_APC_Tracked_01_CRV_F"};
		};
		class VehicleHVT_INS {
			classNames[] = {"B_G_Offroad_01_repair_F"};
		};
		class Car {
			classNames[] = {"B_MRAP_01_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_sand_F"};
		};
		class Car_INS {
			classNames[] = {"B_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_armed_black_F","B_LSV_01_armed_sand_F"};
		};
		class CarTurret_INS {
			classNames[] = {"B_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"B_Truck_01_transport_F","B_Truck_01_covered_F"};
		};
		class Truck_INS {
			classNames[] = {"B_G_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"B_Truck_01_Repair_F","B_Truck_01_ammo_F","B_Truck_01_fuel_F"};
		};
		class Armour_AA {
			classNames[] = {"B_APC_Tracked_01_AA_F"};
		};
		class Armour_APC {
			classNames[] = {"B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
		};
		class Armour_MBT {
			classNames[] = {"B_MBT_01_cannon_F","B_MBT_01_TUSK_F"};
		};
		class Armour_Art {
			classNames[] = {"B_MBT_01_arty_F","B_MBT_01_mlrs_F"};
		};
		class CAS_Heli {
			classNames[] = {"B_Heli_Light_01_dynamicLoadout_F","B_Heli_Attack_01_F"};
		};
		class CAS_Air {
			classNames[] = {"B_Plane_CAS_01_F"};
		};
		class CAS_UAV {
			classNames[] = {"B_UAV_02_CAS_F","B_UAV_05_F"};
		};
		class Fighter_Plane {
			classNames[] = {"B_Plane_Fighter_01_F","B_Plane_Fighter_01_Stealth_F"};
		};
		class Transport_Heli {
			classNames[] = {"B_CTRG_Heli_Transport_01_sand_F","B_Heli_Transport_01_F","B_Heli_Transport_03_F"};
		};
		class Transport_Air {
			classNames[] = {"B_T_VTOL_01_infantry_F"};
		};
		class UAV {
			classNames[] = {"B_UAV_02_CAS_F","B_UAV_05_F"};
		};
		class UGV {
			classNames[] = {"B_UGV_01_rcws_F"};
		};
		class Boat {
			classNames[] = {"B_Boat_Armed_01_minigun_F"};
		};
	};
};