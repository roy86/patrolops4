/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-22
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
//class Params {
	class MPSF_ParamGroup_RecruitMP {
		title = "====== Recruitment Options ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	class MPSFRecruitMPSize {
		title = "Recruit AI: Squad Size Limit";
		values[] = {0,4,8,12};
		texts[] = {"Disabled","Fire Team (4)","Patrol (8)","Section (12)"};
		default = 8;
		isGlobal = 1;
	};
//};