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
class Civilian_Tanoa {
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
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan"};
		};
		class Crowd6 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"};
		};
		class Crowd12 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"};
		};
		class Crowd24 {
			classNames[] = {"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan"};
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