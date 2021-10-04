class RscControlAmrelTabletForceTrackOverview: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_150;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletForceTrackOverviewBanner: Rsc86StructuredText {
            idc = ASSIGNED_IDC_151;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "FORCE TRACKER: Overview";
        };

        /* class RscControlAmrelTabletForceTrackOverviewListCombo1: Rsc86Combo {
            idc = 19678;
            x = "0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Artillery Battery";
        };

        class RscControlAmrelTabletForceTrackOverviewListCombo2: Rsc86Combo {
            idc = 125642;
            x = "12.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Ordnance Type";
        };

        class RscControlAmrelTabletForceTrackOverviewListCombo3: Rsc86Combo {
            idc = 12542635;
            x = "25.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "12.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Ingres Direction";
        }; */
    };
};