class RscControlAmrelTabletForceTrackReports: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_160;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletForceTrackReportsBanner: Rsc86StructuredText {
            idc = ASSIGNED_IDC_161;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "19 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "FORCE TRACKER: Create/Edit SITREPS";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletForceTrackReportsBannerGridPlayer: Rsc86StructuredText {
            idc = ASSIGNED_IDC_162;
            x = "19.2* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "9.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Observer #000000";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletForceTrackReportsBannerGridCursor: Rsc86StructuredText {
            idc = ASSIGNED_IDC_163;
            x = "28.8* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "9.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Position #000000";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletForceTrackReportsInfo: Rsc86StructuredText {
            idc = ASSIGNED_IDC_164;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Click on an area to create a report. Click on an existing report to edit. Right-Click anywhere to exit report.";
            colorBackground[] = {0,0,0,0.4};
        };
    };
};

class RscControlAmrelTabletForceTrackReportsMenu: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_170;
	x = "8.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "8.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletForceTrackReportsBanner: Rsc86StructuredText {
            idc = ASSIGNED_IDC_171;
            x = "0* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "<t font='PuristaMedium' size='1' shadow='0'>Report Observation</t>";
        };

        class RscControlAmrelTabletForceTrackReportsColourText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_172;
            x = "0* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Side";
        };
        class RscControlAmrelTabletForceTrackReportsColourListCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_173;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Observed Faction";
        };

        class RscControlAmrelTabletForceTrackReportsTypeText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_174;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Type";
        };
        class RscControlAmrelTabletForceTrackReportsTypeListCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_175;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Report Side";
        };

        class RscControlAmrelTabletForceTrackReportsDirText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_176;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Direction";
        };
        class RscControlAmrelTabletForceTrackReportsDirSlider: Rsc86XSliderH {
            idc = ASSIGNED_IDC_177;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Set Movement Direction";
        };

        class RscControlAmrelTabletForceTrackReportsExpiryText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_178;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "7.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Expires in: Never";
        };
        class RscControlAmrelTabletForceTrackReportsExpirySlider: Rsc86XSliderH {
            idc = ASSIGNED_IDC_179;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "8.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Set Report Expiry";
        };

        class RscControlAmrelTabletForceTrackReportsCommentText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_180;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "9.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Text";
        };
        class RscControlAmrelTabletForceTrackReportsCommentEdit: Rsc86Edit {
            idc = ASSIGNED_IDC_181;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "11.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "";
            tooltip = "Set Report Comment";
        };

        class RscControlAmrelTabletForceTrackReportsSpacer: Rsc86StructuredText {
            idc = ASSIGNED_IDC_182;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "12.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "";
        };

        class RscControlAmrelTabletForceTrackReportsUpdateButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_183;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "12.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Update Report";
            colorBackground[] = {0,0,0,0.8};
        };

        class RscControlAmrelTabletForceTrackReportsDeleteButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_184;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "13.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Delete Report";
            colorBackground[] = {0.6,0,0,0.8};
        };
    };
};