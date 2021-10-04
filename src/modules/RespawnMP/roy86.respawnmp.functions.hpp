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
	class MPSF_RespawnMP {
        tag = "MPSF";
        class init {
            file = "modules\RespawnMP\functions";
			class mhq { postInit = 1; };
            class rallypoint { postInit = 1; };
            class respawneh {};
		    class respawnhalo { ext = ".fsm"; };
			class respawnmp { postInit = 1; };
            class respawnui {};
        };
    };
//};