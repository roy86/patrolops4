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
class Opfor_Tanoa {
	displayName = "Syndikat";
	displayLongName = "Syndikat Allegiance Group";
	displayColour = "ColorOpfor";
	side = 0;
	class Groups {
		class TargetHVT {
			classNames[] = {"O_T_Officer_F","O_V_Soldier_TL_ghex_F"};
		};
		class TargetHVT_INS {
			classNames[] = {{"O_T_Officer_F","I_C_Soldier_Camo_F"},{"O_V_Soldier_TL_ghex_F","I_C_Soldier_Para_4_F"}};
		};
		class Squad8 {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_AA_F","O_T_Soldier_AR_F","O_T_Soldier_AT_F","O_T_Soldier_M_F","O_T_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_AA_F","O_T_Soldier_AA_F","O_T_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_AR_F","O_T_Soldier_AR_F","O_T_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_AT_F","O_T_Soldier_LAT_F","O_T_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_Soldier_A_F","O_T_Soldier_GL_F","O_T_Soldier_M_F","O_T_Soldier_M_F","O_T_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {{"O_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_2_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_8_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_7_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_4_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_1_F"}};
		};
		class Squad4 {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_F","O_T_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_AA_F","O_T_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_AR_F","O_T_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_AT_F","O_T_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"O_T_Soldier_TL_F","O_T_Soldier_GL_F","O_T_Soldier_M_F","O_T_Soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {{"O_T_Soldier_F","I_C_Soldier_Bandit_6_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_5_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_3_F"},{"O_T_Soldier_F","I_C_Soldier_Bandit_2_F"}};
		};
		class Sniper {
			classNames[] = {"O_T_ghillie_tna_F","O_T_ghillie_tna_F"};
		};
		class Sniper_INS {
			classNames[] = {"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F"};
		};
		class ParaMilitary {
			classNames[] = {{"O_T_Soldier_F","I_C_Soldier_Para_6_F"},{"O_T_Soldier_F","I_C_Soldier_Para_2_F"},{"O_T_Soldier_F","I_C_Soldier_Para_4_F"},{"O_T_Soldier_F","I_C_Soldier_Para_5_F"},{"O_T_Soldier_F","I_C_Soldier_Para_8_F"}};
		};
		class SpecOps {
			classNames[] = {"O_T_Recon_TL_F","O_T_Recon_F","O_T_Recon_M_F","O_T_Recon_LAT_F","O_T_Recon_Exp_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"O_V_Soldier_TL_ghex_F","O_V_Soldier_ghex_F","O_V_Soldier_M_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_Exp_ghex_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"O_T_Truck_03_device_ghex_F"};
		};
		class VehicleHVT_INS {
			classNames[] = {"O_T_LSV_02_armed_black_F","O_T_LSV_02_armed_ghex_F"};
		};
		class Car {
			classNames[] = {"O_T_LSV_02_unarmed_F","O_T_LSV_02_unarmed_black_F","O_T_LSV_02_unarmed_ghex_F","O_T_MRAP_02_ghex_F"};
		};
		class Car_INS {
			classNames[] = {"O_G_Offroad_01_F","I_C_Offroad_02_unarmed_F"};
		};
		class CarTurret {
			classNames[] = {"O_T_LSV_02_armed_F","O_T_LSV_02_armed_black_F","O_T_LSV_02_armed_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F"};
		};
		class CarTurret_INS {
			classNames[] = {"O_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F"};
		};
		class Truck_INS {
			classNames[] = {"I_C_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"O_T_Truck_03_repair_ghex_F","O_T_Truck_03_ammo_ghex_F","O_T_Truck_03_fuel_ghex_F"};
		};
		class Armour_AA {
			classNames[] = {"O_T_APC_Tracked_02_AA_ghex_F"};
		};
		class Armour_APC {
			classNames[] = {"O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F"};
		};
		class Armour_MBT {
			classNames[] = {"O_T_MBT_02_cannon_ghex_F","O_T_MBT_04_cannon_F","O_T_MBT_04_command_F"};
		};
		class Armour_Art {
			classNames[] = {"O_T_MBT_02_arty_ghex_F"};
		};
		class CAS_Heli {
			classNames[] = {"O_Heli_Attack_02_black_F"};
		};
		class CAS_Air {
			classNames[] = {"O_Plane_CAS_02_F"};
		};
		class CAS_UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class Fighter_Plane {
			classNames[] = {"O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F"};
		};
		class Transport_Heli {
			classNames[] = {"O_Heli_Transport_04_bench_black_F","O_Heli_Transport_04_covered_black_F"};
		};
		class Transport_Air {
			classNames[] = {"O_T_VTOL_02_infantry_ghex_F"};
		};
		class UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class UGV {
			classNames[] = {"O_T_UGV_01_rcws_ghex_F"};
		};
		class Boat {
			classNames[] = {"O_T_Boat_Armed_01_hmg_F"};
		};
	};
};