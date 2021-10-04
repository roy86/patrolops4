class RscDisplayAmrelTabletUAV {
	idd = ASSIGNED_IDD_4;
	enableSimulation = 1;
    onLoad = "";
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
    };
};