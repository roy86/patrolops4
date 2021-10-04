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
//class CfgFunctions {
    class MPSF_SquadManager {
        tag = "MPSF";
        class SquadManager {
            file = "modules\SquadManager\functions";
            class squadCheckVehicleRole {};
            class SquadManager { preInit = 1;  postInit = 1; };
            class squadUnitRole {};
        };
    };
//};