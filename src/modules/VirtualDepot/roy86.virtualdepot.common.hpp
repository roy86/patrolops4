/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class CfgVirtualDepot {
	supplyRadius = 10;
	/*
		Limiting the types of ordinance to the configured hardpoints
		Values: 0:False, 1:True
	*/
	compatiblePylonMags = 0;

	/*
		Enable Direct Pylon Interaction
		Disables in-editor editing before deploying the vehicle
		Values: 0:False, 1:True
	*/
	externalPylonInteraction = 0;

	/*
		Time taken in seconds to load an ordinance onto the pylon
		Requires Pylon Interaction
	*/
	loadOrdinanceDuration = 15;

	/*
		The repair damage per second for each damage point of the vehicle.
	*/
	repairSpeed = 0.1;
	refuelSpeed = 0.1;
	rearmSpeed = 0.1;

    /*
        Limit the number of active vehicles created during the mission
    */
	class VehicleLimit {
		Plane = 2;
		Helicopter = 9;
		Air = 1;
		Truck_01_base_F = 3;
	};

	// Force this classname to appear as a distinct vehicle, useful for splitting up models and classnames
	forceInDepot[] = {
		"MELB_AH6M_L","MELB_AH6M_M","MELB_MH6M" // MELB Mod
		// RHS Mod
		,"RHS_AH1Z_CS"	,"RHS_AH1Z_GS"
		,"RHS_MELB_AH6M_H","RHS_MELB_AH6M_L","RHS_MELB_AH6M_M","RHS_MELB_H6M","RHS_MELB_MH6M"
		,"RHS_AH64D_noradar","RHS_AH64D_AA","RHS_AH64D_noradar_AA","RHS_AH64D_CS","RHS_AH64D_noradar_CS","RHS_AH64D_GS","RHS_AH64D_noradar_GS"
		,"RHS_UH60M_MEV2","RHS_UH1Y_FFAR"
		,"RHS_UH1Y_GS","RHS_UH1Y_UNARMED"
		,"RHSgref_b_mi24g_FAB","RHSgref_b_mi24g_UPK23"
		,"rhsgref_cdf_b_Mi35_AT","rhsgref_cdf_b_Mi35_UPK","rhsgref_cdf_b_Mi35"
		,"rhsgref_cdf_b_reg_Mi17Sh_FAB","rhsgref_cdf_b_reg_Mi17Sh_UPK"
		// BIS
		,"B_T_VTOL_01_vehicle_F","B_Plane_Fighter_01_Stealth_F","O_Plane_Fighter_02_Stealth_F"
		,"B_G_Van_02_transport_F","B_G_Van_02_vehicle_F"
		,"O_G_Van_02_transport_F","O_G_Van_02_vehicle_F"
		,"I_G_Van_02_transport_F","I_G_Van_02_vehicle_F"
		,"C_IDAP_UAV_06_antimine_F"
	};

	addMagsInDepot[] = {};

	// Used in "mpsf\functions\spawner\fn_createCarrier01.sqf" for spawning the carrier to support Vehicle Depots
	class CarrierDepots {
		class Elevator1 { // Starboard Bow - Clear, Open, West facing
			position[] = {-33.1792,-8.6475,25.8617};
			direction = 87;
			classNames[] = {"Plane","Helicopter"};
		};
		class Elevator2 { // Starboard Mid Section - West facing, small area near tower overhang
			position[] = {-33.1792,71.6475,25.8617};
			direction = 87;
			classNames[] = {"Plane_Fighter_01_Base_F","Plane_Fighter_02_Base_F","Plane_Fighter_03_base_F","Plane_Fighter_04_Base_F","Plane_CAS_01_base_F","Plane_CAS_02_base_F"};
		};
		class Elevator3 { // Port Stern - Clear, Open, north facing, direct to Catapult 4
			position[] = {35.4792,119.9475,25.8617};
			direction = 180;
			classNames[] = {"Plane","Helicopter"};
		};
		class SternLandingPad { // Starboard Stern - Clear, Open, North facing toward tower
			position[] = {-34.6792,159.6475,25.8617};
			direction = 180;
			classNames[] = {"LandVehicle","Helicopter"};
		};
	};

	// Perfecting the Hardpoint locations of the aircraft. Not all Aircraft require this IF they are set-up properly.
	// If not declared, a default position will be used until specified.
	class HardPoints {
		//copyToClipboard str [[(configFile >> "CfgVehicles" >> typeOf cursorObject)] call BIS_fnc_returnParents,selectionNames cursorObject];
		class B_Plane_Fighter_01_Stealth_F {
			positions[] = {
				{},{},{},{}
				,{1.8612,0,-0.997347}
				,{-1.8612,0,-0.997347}
				,{1,-1,-1.6}
				,{-1,-1,-1.6}
				,{1,-2,-1.6}
				,{-1,-2,-1.6}
				,{1,-3,-1.6}
				,{-1,-3,-1.6}
			};
		};
		class Plane_Fighter_01_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.002"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.003"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.004"
				,{1.8612,0,-0.997347}
				,{-1.8612,0,-0.997347}
				,{1,-1,-1.6}
				,{-1,-1,-1.6}
				,{1,-2,-1.6}
				,{-1,-2,-1.6}
				,{1,-3,-1.6}
				,{-1,-3,-1.6}
			};
		};
		class O_Plane_Fighter_02_Stealth_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.007"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.008"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.009"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.010"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.011"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.012"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.013"
			};
		};
		class Plane_Fighter_02_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.002"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.003"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.004"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.005"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.006"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.007"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.008"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.009"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.010"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.011"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.012"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_05_x1_f.013"
			};
		};
		class Plane_Fighter_03_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.007"
			};
		};
		class Plane_Fighter_04_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.002"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.003"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.004"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.005"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.006"
				//,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.007"
				//,"proxy:\a3\weapons_f_jets\ammo\pylonpod_missile_aa_06_x1_f.008"
			};
		};
		class Plane_CAS_01_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.007"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.008"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.009"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.010"
			};
		};
		class Plane_CAS_02_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.007"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.008"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.009"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.010"
			};
		};
		class VTOL_02_infantry_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
			};
		};
		class VTOL_02_vehicle_base_F: VTOL_02_infantry_base_F {};
		class Heli_Attack_01_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.005"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.006"
			};
		};
		class Heli_Attack_02_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
			};
		};
		class Heli_Light_01_armed_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
			};
		};
		class Heli_Light_02_base_F: Heli_Light_01_armed_base_F {};
		class Heli_light_03_base_F: Heli_Light_01_armed_base_F {};
		class UAV_02_base_F: Heli_Light_01_armed_base_F {};
		class UAV_03_base_F {
			positions[] = {
				"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.001"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.002"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.003"
				,"proxy:\a3\weapons_f\dynamicloadout\pylonpod_3x_missile_agm_02_f.004"
			};
		};
		class UAV_05_Base_F {
			positions[] = {
				"proxy:\a3\weapons_f_jets\ammo\pylonpod_bomb_gbu12_04_x1_f.001"
				,"proxy:\a3\weapons_f_jets\ammo\pylonpod_bomb_gbu12_04_x1_f.002"
			};
		};
	};
};

#include "ui\roy86.rsc.virtualdepot.hpp"