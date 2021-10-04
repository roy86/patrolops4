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
	class MPSF_VirtualArmoury {
        tag = "MPSF";
        class VirtualArmoury {
            file = "modules\VirtualArmoury\functions";
            class createVirtualArmoury {};
			//class getCfgRoles {};
            class rscVirtualArmoury {};
            class setArmouryLoadout {};
            class virtualArmoury { preInit = 1; postInit = 1; };
        };
    };
//};