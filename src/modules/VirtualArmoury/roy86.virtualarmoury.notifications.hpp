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
class VirtualArmoury_RoleRequest {
	title = "Role Requested";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 requesting %2 assignment";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};
class VirtualArmoury_RoleAssigned {
	title = "Role Assigned";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 assigned as %2";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};
class VirtualArmoury_RoleFailed {
	title = "Unqualified Operator";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "You are not qualified to operate this vehicle";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};
class VirtualArmoury_RoleLimitReached {
	title = "Role Limit Reached";
	iconPicture = "\A3\ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa";
	description = "%1 roles are all taken";
	priority = 5;
	duration = 5;
	sound = "taskAssigned";
};