class RscControlAmrelTabletSquadGroupView: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_30;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "27.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletSquadScreen_GroupTree: Rsc86Tree {
            idc = ASSIGNED_IDC_31;
            x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "19 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "25 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletSquadGroupButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_32;
            x = "25.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "12.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "$STR_A3_RscDisplayDynamicGroups_Button_Join";
        };
    };
};