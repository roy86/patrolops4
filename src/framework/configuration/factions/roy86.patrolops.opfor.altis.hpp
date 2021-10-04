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
class PatrolOps_Opfor_Altis {
	displayName = "AFA";
	displayLongName = "Altis Freedom Alliance";
	displayColour = "ColorOpfor";
	side = 0;
	class Groups {
		// Task Specific
		class SquadAmbushINS4 {
			classNames[] = {"O_G_Soldier_GL_F","O_G_Soldier_AR_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F"};
		};
		class SquadAmbushINS8 {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F","O_G_Soldier_A_F","O_G_Soldier_M_F","O_G_Sharpshooter_F","O_G_medic_F"};
		};
		class SquadATINS4 {
			classNames[] = {"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_LAT_F","O_G_medic_F"};
		};
		class SquadATINS8 {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_LAT_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Sharpshooter_F","O_G_medic_F"};
		};
		class SquadAAINS4 {
			classNames[] = {"O_G_Soldier_GL_F","O_Soldier_AA_F","O_Soldier_AA_F","O_G_medic_F"};
		};
		class SquadAAINS8 {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_Soldier_AA_F","O_Soldier_AA_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Sharpshooter_F","O_G_medic_F"};
		};
		class HVTINS {
			classNames[] = {"O_Officer_F","O_G_Officer_F"};
		};
		class DrugDealer {
			classNames[] = {{"O_Officer_F","I_L_Criminal_SG_F"}};
		};
		class QRFSquad {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_AA_F","O_Soldier_AR_F","O_Soldier_AT_F","O_soldier_M_F","O_medic_F"};
		};

		// General Config
		class TargetHVT {
			classNames[] = {"O_Officer_F","O_V_Soldier_TL_hex_F"};
		};
		class TargetHVT_INS {
			classNames[] = {"O_G_officer_F","O_G_Sharpshooter_F"};
		};
		class Squad8 {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_AA_F","O_Soldier_AR_F","O_Soldier_AT_F","O_soldier_M_F","O_medic_F"};
		};
		class Squad8_AA {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_AA_F","O_Soldier_AA_F","O_medic_F"};
		};
		class Squad8_AR {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_AR_F","O_medic_F"};
		};
		class Squad8_AT {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_AT_F","O_Soldier_LAT_F","O_medic_F"};
		};
		class Squad8_M {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_A_F","O_Soldier_GL_F","O_soldier_M_F","O_soldier_M_F","O_medic_F"};
		};
		class Squad8_INS {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F","O_G_Soldier_A_F","O_G_Soldier_M_F","O_G_Sharpshooter_F","O_G_medic_F"};
		};
		class Squad4 {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_medic_F"};
		};
		class Squad4_AA {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_AA_F","O_Soldier_AA_F"};
		};
		class Squad4_AR {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_AR_F"};
		};
		class Squad4_AT {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_AT_F","O_Soldier_LAT_F"};
		};
		class Squad4_M {
			classNames[] = {"O_Soldier_TL_F","O_Soldier_GL_F","O_soldier_M_F","O_soldier_M_F"};
		};
		class Squad4_INS {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F"};
		};
		class Sniper {
			classNames[] = {"O_ghillie_sard_F","O_ghillie_sard_F"};
		};
		class Sniper_INS {
			classNames[] = {"O_G_Sharpshooter_F","O_G_Sharpshooter_F"};
		};
		class ParaMilitary {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_Soldier_LAT_F"};
		};
		class SpecOps {
			classNames[] = {"O_recon_TL_F","O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_exp_F"};
		};
		class SpecOps_Elite {
			classNames[] = {"O_V_Soldier_TL_hex_F","O_V_Soldier_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_Exp_hex_F"};
		};
	};
	class Vehicles {
		class VehicleHVT {
			classNames[] = {"O_Truck_03_device_F"};
		};
		class Car {
			classNames[] = {"O_LSV_02_unarmed_F","O_LSV_02_unarmed_black_F","O_LSV_02_unarmed_arid_F","O_MRAP_02_F"};
		};
		class Car_INS {
			classNames[] = {"O_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"O_LSV_02_armed_F","O_LSV_02_armed_black_F","O_LSV_02_armed_arid_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"};
		};
		class CarTurret_INS {
			classNames[] = {"O_G_Offroad_01_armed_F"};
		};
		class Truck {
			classNames[] = {"O_Truck_03_transport_F","O_Truck_03_covered_F"};
		};
		class Truck_INS {
			classNames[] = {"O_Truck_02_transport_F","O_G_Van_01_transport_F"};
		};
		class Truck_Support {
			classNames[] = {"O_Truck_03_repair_F","O_Truck_03_ammo_F","O_Truck_03_fuel_F"};
		};
		class Armour_AA {
			classNames[] = {"O_APC_Tracked_02_AA_F"};
		};
		class Armour_APC {
			classNames[] = {"O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"};
		};
		class Armour_MBT {
			classNames[] = {"O_MBT_02_cannon_F","O_MBT_04_cannon_F","O_MBT_04_command_F"};
		};
		class Armour_Art {
			classNames[] = {"O_MBT_02_arty_F"};
		};
		class CAS_Heli {
			classNames[] = {"O_Heli_Attack_02_F","O_Heli_Attack_02_black_F"};
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
			classNames[] = {"O_Heli_Transport_04_bench_black_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_black_F","O_Heli_Transport_04_covered_F"};
		};
		class Transport_Air {
			classNames[] = {"O_T_VTOL_02_infantry_grey_F","O_T_VTOL_02_infantry_hex_F"};
		};
		class UAV {
			classNames[] = {"O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"};
		};
		class UGV {
			classNames[] = {"O_UGV_01_rcws_F"};
		};
		class Boat {
			classNames[] = {"O_Boat_Armed_01_hmg_F"};
		};
		class StaticSAM {
			classNames[] = {"O_SAM_System_04_F"};
		};
		class StatisSAMRadar {
			classNames[] = {"O_Radar_System_02_F"};
		};
	};
};
