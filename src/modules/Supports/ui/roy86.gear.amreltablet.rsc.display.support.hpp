class RscDisplayAmrelTabletSupport {
	idd = ASSIGNED_IDD_3;
	enableSimulation = 1;
    onLoad = "['onLoadSupportMenu',_this] call MPSF_fnc_supportManager;";
    displayGroups[] = {"AmrelTabletSupportFiremission","AmrelTabletSupportCAS","AmrelTabletSupportSupplyDrop"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletSupportMap: RscControlAmrelTabletSupportMap {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletSupportFiremission: RscControlAmrelTabletSupportFiremission {};
        class AmrelTabletSupportCAS: RscControlAmrelTabletSupportCAS {};
        class AmrelTabletSupportSupplyDrop: RscControlAmrelTabletSupportSupplyDrop {};
        //class AmrelTabletSupportSupplyDropListGroup: RscControlAmrelTabletSupportSupplyDropListGroup {};
    };
};