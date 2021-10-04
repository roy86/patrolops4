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
class Opfor_Ins_Altis {
	displayName = "Syndikat";
	displayLongName = "Syndikat Allegiance Group";
	displayColour = "ColorOpfor";
	side = 0;
	class Groups {
		class Squad8 {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F","O_G_Soldier_A_F","O_G_Soldier_M_F","O_G_Sharpshooter_F","O_G_medic_F"};
		};
		class Squad6 {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F","O_G_Soldier_M_F","O_G_medic_F"};
		};
		class Squad4 {
			classNames[] = {"O_G_Soldier_TL_F","O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F"};
		};
		class SquadAA {
			classNames[] = {"O_G_officer_F","O_soldierU_AA_F","O_soldierU_AA_F","O_soldierU_AAA_F"};
		};
		class HVT1 {
			classNames[] = {"O_A_soldier_F"};
		};
		class HVT2 {
			classNames[] = {"O_A_soldier_TL_F","O_A_soldier_F"};
		};
	};
	class Vehicles {
		class Car {
			classNames[] = {"O_G_Offroad_01_F"};
		};
		class CarTurret {
			classNames[] = {"O_G_Offroad_01_armed_F"};
		};
		class Vehicle_AA_Radar {
			classNames[] = {"O_Radar_System_02_F"};
		};
		class Vehicle_AA {
			classNames[] = {"O_SAM_System_04_F"};
		};
		class Vehicle_Armour_APC {
			classNames[] = {"O_APC_Wheeled_02_rcws_v2_F","I_APC_Wheeled_03_cannon_F"};
		};
	};
};