class RscControlMissionConsoleMenu: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_211;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "27.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1.10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlRespawnMPCommitButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_212;
            x = "12.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.00 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "14.00 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Redeploy to Position";
            tooltip = "Redeploy to Position";
            colorBackground[] = {0.8,0,0,0.8};
            colorBackgroundFocused[] = {0.8,0,0,1};
        };
    };
};