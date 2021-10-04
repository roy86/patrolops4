/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-30
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class MPSF_onIntelDownloadComplete {
	title = "Intel Download";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has completed downloading intel";
	priority = 5;
	sound = "taskAssigned";
};
class MPSF_onIntelDownloadStart {
	title = "Intel Download";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has started downloading Intel";
	priority = 5;
	sound = "taskAssigned";
};
class MPSF_onIntelDownloadStop {
	title = "Intel Download";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "Intel download has been cancelled";
	priority = 5;
	sound = "taskAssigned";
};
class MPSF_onIntelRecieve {
	title = "Intel Receive";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has received intel from %2";
	priority = 5;
	sound = "taskAssigned";
};
class MPSF_onIntelPickup {
	title = "Intel Picked Up";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 has found a piece of intel";
	priority = 5;
	sound = "taskAssigned";
};
class MPSF_onIntel {
	title = "%1";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%2";
	priority = 5;
	sound = "taskAssigned";
};