/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-10
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class CivilianSimulation {
	init = "[_this] call PO4_fnc_actionCivilianIntel;";

	class Farm {
		area = "Farm";
		classNames[] = {"Crowd4"};
	};

	class Village {
		area = "Village";
		classNames[] = {"Crowd6"};
		vehicles[] = {"Cars"};
		vehicleSize[] = {0,1};
	};

	class Town {
		area = "Town";
		classNames[] = {"Crowd12"};
		vehicles[] = {"Cars"};
		vehicleSize[] = {1,3};
	};

	class City {
		area = "City";
		classNames[] = {"Crowd24"};
		vehicles[] = {"Cars"};
		vehicleSize[] = {2,5};
	};
};
