class RscDisplayAmrelTabletSquad {
	idd = ASSIGNED_IDD_2;
	enableSimulation = 1;
    onLoad = "['onLoadSquadMenu',_this] call MPSF_fnc_squadManager;";
    displayGroups[] = {"AmrelTabletSquadGroupView","AmrelTabletSquadManageView","AmrelTabletSquadRoleView"};
    class ControlsBackground {
        class RscControlBackground: RscBackgroundAmrelTablet {
	        moving = 1;
        };
    };
    class Controls {
        class AmrelTabletMainButtons: RscControlAmrelTabletButtons {};
        class AmrelTabletMenuScreen: RscControlAmrelTabletMenuScreen {};
        class AmrelTabletSquadGroupView: RscControlAmrelTabletSquadGroupView {};
        class AmrelTabletSquadManageView: RscControlAmrelTabletSquadManageView {};
        class AmrelTabletSquadRoleView: RscControlAmrelTabletSquadRoleView {};
    };
};