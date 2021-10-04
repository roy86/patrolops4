/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-13
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class RscDisplayAmrelTabletRoles {
	idd = ASSIGNED_IDD_6;
	enableSimulation = 1;
    onLoad = "['onLoadRolesMenu',_this] call MPSF_fnc_itemAmrelTablet;";
    //displayGroups[] = {"AmrelTabletSettingsView"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
    };
};