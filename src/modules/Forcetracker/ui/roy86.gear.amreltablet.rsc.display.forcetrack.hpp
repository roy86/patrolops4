class RscDisplayAmrelTabletForceTrack {
	idd = ASSIGNED_IDD_1;
	enableSimulation = 1;
    onLoad = "['onLoadForceTrackMenu',_this] call MPSF_fnc_forcetracker;";
    displayGroups[] = {"AmrelTabletForceTrackOverview","AmrelTabletForceTrackGroups","AmrelTabletForceTrackReports"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletForceTrackButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletForceTrackScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletForceTrackMap: RscControlAmrelTabletForceTrackMap {};
        class AmrelTabletForceTrackOverview: RscControlAmrelTabletForceTrackOverview {};
        class AmrelTabletForceTrackGroups: RscControlAmrelTabletForceTrackGroups {};
        class AmrelTabletForceTrackReports: RscControlAmrelTabletForceTrackReports {};
        class AmrelTabletForceTrackGroupsMenu: RscControlAmrelTabletForceTrackGroupsMenu {};
        class AmrelTabletForceTrackReportsMenu: RscControlAmrelTabletForceTrackReportsMenu {};
    };
};