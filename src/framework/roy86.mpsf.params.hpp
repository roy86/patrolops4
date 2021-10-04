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
	class MPSF_ParamGroup_Mission {
		title = "====== Mission Options ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	/* class MPSF_Param_MissionHour {
		title = "Mission Hour";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default = 7;
		texts[]={"0000H","0100H","0200H","0300H","0400H","0500H","0600H","0700H","0800H","0900H","1000H","1100H","1200H","1300H","1400H","1500H","1600H","1700H","1800H","1900H","2000H","2100H","2200H","2300H"};
		function = "MPSF_fnc_setDateTime";
	}; */
	class MPSF_Param_MissionTime {
		title = "Mission Environment";
		values[]={0,1,2,3,4,5,6,7,8,9,10};
		default = 0;
		texts[]={
			"Early Foggy Morning",
			"Morning Sunrise",
			"Sunny Midday",
			"Stormy Midday",
			"Clear Afternoon",
			"Stormy Afternoon",
			"Evening Sunset",
			"Clear Late Evening",
			"Stormy Late Evening",
			"Clear Late Night",
			"Stormy Late Night"
		};
		function = "MPSF_fnc_setEnvironment";
	};
	/* class MPSF_Param_missionskill {
		title = "Mission Difficulty";
		values[]={1,2,4,6};
		texts[]={$STR_PO3_TEXT_LOW,$STR_PO3_TEXT_MED,$STR_PO3_TEXT_HIGH,$STR_PO3_TEXT_ULTRA};
		default=6;
		code = "PO3_param_missionskill = (%1/3);";
	}; */
	/* class MPSF_Param_ai_skill {
		title = $STR_PO3_PARAM_SETAISKILL;
		values[]={1,2,3,4};
		texts[]={$STR_PO3_TEXT_LOW,$STR_PO3_TEXT_MED,$STR_PO3_TEXT_HIGH,$STR_PO3_TEXT_ULTRA};
		default=1;
		code = "PO3_param_ai_skill = 0.8 + log((%1)/4)";
	}; */
	class MPSF_ParamGroup_AI {
		title = "====== AI Options ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	class MPSF_Param_AIeasyKill {
		title = $STR_PO4_PARAM_SETAITKILL;
		values[]={0,1};
		texts[]={$STR_PO4_TEXT_NO,$STR_PO4_TEXT_YES};
		default=1;
	};
	class MPSF_ParamGroup_Player {
		title = "====== Player Options ======";
		values[]= {0};
		texts[]= {" "};
		default = 0;
		code = "";
	};
	class MPSF_Param_Restict3rdPerson {
		title = "Player - 3rd Person Camera";
		values[] = {0,1,2,3,4};
		texts[] = {"Enabled","Armour Drivers Only","Aircraft Pilots Only","Any Driver or Pilot Only","Disabled"};
		default = 0;
		function = "MPSF_fnc_restrict3rdPersonCamera";
		isGlobal = 1;
	};
	class MPSF_Param_BaseGriefProtection {
		title = "Player - Base Grief Protection";
		values[] = {0,150,250,500};
		texts[] = {"Disabled","150m Radius","250m Radius","500m Radius"};
		default = 150;
		isGlobal = 1;
	};
//};