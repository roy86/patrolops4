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
    class MPSF_SupportManager {
        tag = "MPSF";
        class SupportManager {
            file = "modules\Supports\functions";
            class casSupport {};
            class fireSupport {};
            class fireSupportVirtual {};
            class getNearLaserTargets {};
            class supportAirdrop {};
            class SupportManager { preInit = 1;  postInit = 1; };
        };
    };
//};