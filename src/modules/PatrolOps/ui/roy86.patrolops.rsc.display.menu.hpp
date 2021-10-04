class RscDisplayMissionConsoleMenu {
	idd = ASSIGNED_IDD_5;
	enableSimulation = 1;
    onLoad = "['onLoad',_this] call PO4_fnc_missionConsoleUI;";
    displayGroups[] = {"MissionConsoleActiveOps","MissionConsoleAvailableOps","MissionConsoleIntel"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletMenuScreenLogo: RscControlAmrelTabletMenuScreen_Logo {};
        class MissionConsoleMap: RscControlMissionConsoleMap {};
        class MissionConsoleAvailableOps: RscControlMissionConsoleAvailableOps {};
        class MissionConsoleActiveOps: RscControlMissionConsoleActiveOps {};
        class MissionConsoleIntel: RscControlMissionConsoleIntel {};
        class MissionConsoleIntelOrders: RscControlMissionConsoleIntelOrders {};
    };
};