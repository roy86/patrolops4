class RscDisplayAmrelTabletSettings {
	idd = ASSIGNED_IDD_5;
	enableSimulation = 1;
    onLoad = "['onLoadSettingsMenu',_this] call MPSF_fnc_itemAmrelTablet;";
    //displayGroups[] = {"AmrelTabletSettingsView"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletSettingsView: RscControlAmrelTabletSettingsView {};
    };
};