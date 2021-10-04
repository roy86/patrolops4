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
	class MPSF_ParamGroup_PO {
		title = "====== Patrol Operations ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	class PO4MissionType {
		title = "Mission Type";
		values[] = {0,1,2};
		texts[] = {"Intel Driven Operations (Tactical)","Always-On Operations (Public)","Always-On Operations Requiring Intel Gathering (Public Tactical)"};
		default = 0;
		isGlobal = 1;
	};
	class PO4MissionOpCount {
		title = "Operation Limit";
		values[] = {0,1,3,5,9};
		texts[] = {"Infinite","1","3","5","9"};
		default = 3;
		isGlobal = 1;
	};
	class PO4MissionEncounters {
		title = "Random Encounters";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
		isGlobal = 1;
	};
//};