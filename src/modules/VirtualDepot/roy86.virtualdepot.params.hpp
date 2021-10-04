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
	class MPSF_ParamGroup_VirtualDepot {
		title = "====== Virtual Depot Options ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	class paramCompatiblePylonMags {
		title = "Virtual Depot: Pylon Compatibility";
		values[] = {0,1};
		texts[]={"Anything Goes","Compatible Ordinance Loadouts"};
		default = 0;
	};

	class paramExternalPylonInteraction {
		title = "Virtual Depot: Direct Pylon Interaction";
		values[] = {0,1};
		texts[]={"Disabled","Enabled"};
		default = 1;
	};

	class paramLoadOrdinanceDuration {
		title = "Virtual Depot: Pylon Rearm Duration";
		values[] = {5,15,30};
		texts[]={"Fast","Medium","Slow"};
		default = 15;
	};
//};