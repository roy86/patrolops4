class RscDisplayAmrelTabletMenu {
	idd = ASSIGNED_IDD_0;
	enableSimulation = 1;
    onLoad = "['onLoadMenu',_this] call MPSF_fnc_itemAmrelTablet;";
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletMenuScreenLogo: RscControlAmrelTabletMenuScreen_Logo {};
    };
};