/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-18
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class MPSF_RecruitAdd {
	title = "New Recruit Added";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 recruited";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};

class MPSF_RecruitRemove {
	title = "Recruit Disbanded";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 removed from squad";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};