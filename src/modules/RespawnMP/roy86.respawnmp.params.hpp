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
//class Params {
	class MPSF_ParamGroup_Respawn {
		title = "====== Respawn Options ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	class MPSFRespawnMPRallypoints {
		title = "Respawn: Rallypoints";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
		isGlobal = 1;
	};
//};