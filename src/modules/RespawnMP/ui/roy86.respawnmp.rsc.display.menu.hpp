class RscDisplayRespawnMPMenu {
	idd = ASSIGNED_IDD_4;
	enableSimulation = 1;
    onLoad = "['onLoad',_this] call MPSF_fnc_respawnUI;";
    displayGroups[] = {"RespawnMPMenu","RespawnMPHalo"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletMenuScreenLogo: RscControlAmrelTabletMenuScreen_Logo {};
        class RespawnMPMap: RscControlRespawnMPMap {};
        class RespawnMPMenu: RscControlRespawnMPMenu {};
        class RespawnMPHalo: RscControlRespawnMPHalo {};
    };
};