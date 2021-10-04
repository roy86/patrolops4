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
class Blufor_Tanoa {
	displayName = "NATO Pacific";
	displayLongName = "North Atlantic Treaty Organization";
	displayColour = "ColorBlufor";
	side = 1;
	class Groups {
		class TargetHVT {
			classNames[] = {"B_T_Officer_F","B_T_Recon_JTAC_F"};
		};
		class TargetHVT_INS {
			classNames[] = {{"B_T_Officer_F","I_C_Soldier_Camo_F"},{"B_T_Recon_JTAC_F","I_C_Soldier_Para_4_F"}};
		};
		class Squad8 {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_AA_F","B_T_Soldier_AR_F","B_T_Soldier_AT_F","B_T_Soldier_M_F","B_T_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_AA_F","B_T_Soldier_AA_F","B_T_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F","B_T_Soldier_AR_F","B_T_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_AT_F","B_T_Soldier_LAT_F","B_T_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_Soldier_A_F","B_T_Soldier_GL_F","B_T_Soldier_M_F","B_T_Soldier_M_F","B_T_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {{"B_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_2_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_8_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_7_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_4_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_1_F"}};
		};
		class Squad4 {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_F","B_T_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_AA_F","B_T_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_AR_F","B_T_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_AT_F","B_T_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"B_T_Soldier_TL_F","B_T_Soldier_GL_F","B_T_Soldier_M_F","B_T_Soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {{"B_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"B_T_Soldier_F","I_C_Soldier_Bandit_2_F"}};
		};
		class Sniper {
			classNames[] = {"B_T_ghillie_tna_F","B_T_ghillie_tna_F"};
		};
		class Sniper_INS {
			classNames[] = {{"B_T_ghillie_tna_F","I_C_Soldier_Para_1_F"},{"B_T_ghillie_tna_F","I_C_Soldier_Para_2_F"}};
		};
		class ParaMilitary {
			classNames[] = {{"B_T_Soldier_F","I_C_Soldier_Para_6_F"},{"B_T_Soldier_F","I_C_Soldier_Para_2_F"},{"B_T_Soldier_F","I_C_Soldier_Para_4_F"},{"B_T_Soldier_F","I_C_Soldier_Para_5_F"},{"B_T_Soldier_F","I_C_Soldier_Para_8_F"}};
		};
		class SpecOps {
			classNames[] = {"B_T_Recon_TL_F","B_T_Recon_F","B_T_Recon_M_F","B_T_Recon_LAT_F","B_T_Recon_JTAC_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_AR_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_Medic_tna_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"B_T_Truck_01_ammo_F","B_T_APC_Tracked_01_CRV_F"};
		};
		class VehicleHVT_INS {
			classNames[] = {"B_G_Offroad_01_repair_F"};
		};
		class Car {
			classNames[] = {"B_T_MRAP_01_F","B_T_LSV_01_unarmed_CTRG_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_olive_F"};
		};
		class Car_INS {
			classNames[] = {"B_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_olive_F"};
		};
		class CarTurret_INS {
			classNames[] = {"B_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"B_T_Truck_01_transport_F","B_T_Truck_01_covered_F"};
		};
		class Truck_INS {
			classNames[] = {"B_G_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"B_T_Truck_01_ammo_F","B_T_Truck_01_fuel_F","B_T_Truck_01_Repair_F"};
		};
		class Armour_AA {
			classNames[] = {"B_T_APC_Tracked_01_AA_F"};
		};
		class Armour_APC {
			classNames[] = {"B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_rcws_F"};
		};
		class Armour_MBT {
			classNames[] = {"B_T_MBT_01_cannon_F","B_T_MBT_01_TUSK_F"};
		};
		class Armour_Art {
			classNames[] = {"B_T_MBT_01_arty_F","B_T_MBT_01_mlrs_F"};
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
			classNames[] = {"B_CTRG_Heli_Transport_01_tropic_F","B_Heli_Transport_01_F","B_Heli_Transport_03_F"};
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
			classNames[] = {"B_T_Boat_Armed_01_minigun_F"};
		};
	};
};