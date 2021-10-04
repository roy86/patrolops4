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
class Civilian_Altis {
	displayName = "Civilian";
	displayLongName = "Civilian";
	displayColour = "ColorCivilian";
	side = 3;
	class Groups {
		class Observer {
			classNames[] = {"C_Orestes"};
		};
		class Informants {
			classNames[] = {"C_Orestes","C_Nikos","C_Nikos_aged"};
		};
		class Crowd4 {
			classNames[] = {
				{"C_man_polo_1_F_afro","I_C_Soldier_Bandit_1_F"},
				{"C_man_polo_1_F_asia","I_C_Soldier_Bandit_2_F"},
				{"C_man_polo_1_F_euro","I_C_Soldier_Bandit_3_F"},
				"C_man_polo_1_F"
			};
		};
		class Crowd6 {
			classNames[] = {
				{"C_man_polo_2_F_afro","I_C_Soldier_Bandit_1_F"},
				{"C_man_polo_2_F_asia","I_C_Soldier_Bandit_2_F"},
				{"C_man_polo_2_F_euro","I_C_Soldier_Bandit_3_F"},
				{"C_man_polo_2_F","I_C_Soldier_Bandit_4_F"},
				{"C_man_polo_3_F_euro","I_C_Soldier_Bandit_5_F"},
				{"C_man_polo_3_F","I_C_Soldier_Bandit_6_F"}
			};
		};
		class Crowd12 {
			classNames[] = {
				{"C_man_polo_3_F_afro","I_C_Soldier_Bandit_1_F"},
				{"C_man_polo_3_F_asia","I_C_Soldier_Bandit_2_F"},
				{"C_man_polo_4_F_afro","I_C_Soldier_Bandit_3_F"},
				{"C_man_polo_4_F_asia","I_C_Soldier_Bandit_4_F"},
				{"C_man_polo_4_F_euro","I_C_Soldier_Bandit_5_F"},
				{"C_man_polo_4_F","I_C_Soldier_Bandit_6_F"},
				{"C_man_polo_5_F_afro","I_C_Soldier_Bandit_7_F"},
				{"C_man_polo_5_F_asia","I_C_Soldier_Bandit_8_F"},
				{"C_man_polo_5_F_euro","I_C_Soldier_Bandit_1_F"},
				{"C_man_polo_5_F","I_C_Soldier_Bandit_2_F"},
				{"C_man_1_1_F","I_C_Soldier_Bandit_3_F"},
				{"C_man_1_2_F","I_C_Soldier_Bandit_4_F"}
			};
		};
		class Crowd24 {
			classNames[] = {
				{"C_man_polo_1_F","I_C_Soldier_Bandit_1_F"},
				{"C_man_polo_2_F","I_C_Soldier_Bandit_2_F"},
				{"C_man_polo_3_F","I_C_Soldier_Bandit_3_F"},
				{"C_man_polo_4_F","I_C_Soldier_Bandit_4_F"},
				{"C_man_polo_5_F","I_C_Soldier_Bandit_5_F"},
				{"C_man_polo_6_F","I_C_Soldier_Bandit_6_F"},
				{"C_man_shorts_1_F","I_C_Soldier_Bandit_7_F"},
				{"C_Driver_1_random_base_F","I_C_Soldier_Bandit_8_F"},
				{"C_man_shorts_2_F","I_C_Soldier_Bandit_1_F"},
				{"C_man_shorts_3_F","I_C_Soldier_Bandit_2_F"},
				{"C_man_shorts_4_F","I_C_Soldier_Bandit_3_F"},
				{"C_man_w_worker_F","I_C_Soldier_Bandit_4_F"},
				{"C_man_polo_1_F","I_C_Soldier_Bandit_5_F"},
				{"C_man_polo_2_F","I_C_Soldier_Bandit_6_F"},
				{"C_man_polo_3_F","I_C_Soldier_Bandit_7_F"},
				{"C_man_polo_4_F","I_C_Soldier_Bandit_8_F"},
				{"C_man_polo_5_F","I_C_Soldier_Bandit_1_F"},
				{"C_man_polo_6_F","I_C_Soldier_Bandit_2_F"},
				{"C_man_shorts_1_F","I_C_Soldier_Bandit_3_F"},
				{"C_Driver_1_random_base_F","I_C_Soldier_Bandit_4_F"},
				{"C_man_shorts_2_F","I_C_Soldier_Bandit_5_F"},
				{"C_man_shorts_3_F","I_C_Soldier_Bandit_6_F"},
				{"C_man_shorts_4_F","I_C_Soldier_Bandit_7_F"},
				{"C_man_w_worker_F","I_C_Soldier_Bandit_8_F"}
			};
		};
		class Journo {
			classNames[] = {"C_journalist_F"};
		};
	};
	class Vehicles {
		class Helicopters {
			classNames[] = {"C_Heli_Light_01_civil_F"};
		};
		class Boats {
			classNames[] = {"C_Boat_Civil_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F"};
		};
		class Cars {
			classNames[] = {"C_Offroad_01_F","C_Offroad_01_repair_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F"};
		};
		class Trucks {
			classNames[] = {"C_Truck_02_covered_F","C_Truck_02_transport_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F"};
		};
	};
};