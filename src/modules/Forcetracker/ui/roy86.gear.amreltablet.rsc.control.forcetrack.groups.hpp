class RscControlAmrelTabletForceTrackGroups: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_165;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletForceTrackGroupsBanner: Rsc86StructuredText {
            idc = ASSIGNED_IDC_166;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "FORCE TRACKER: Create/Edit Groups";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletForceTrackGroupsInfo: Rsc86StructuredText {
            idc = ASSIGNED_IDC_167;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Click on a squad to edit the groups information. Right-Click anywhere to exit menu.";
            colorBackground[] = {0,0,0,0.4};
        };
    };
};

class RscControlAmrelTabletForceTrackGroupsMenu: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_185;
	x = "8.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "8.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "15 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletForceTrackGroupsBanner: Rsc86StructuredText {
            idc = ASSIGNED_IDC_186;
            x = "0* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "<t font='PuristaMedium' size='1' shadow='0'>Squad Info</t>";
        };

        class RscControlAmrelTabletForceTrackGroupsLeaderText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_187;
            x = "0* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Leader";
        };
        class RscControlAmrelTabletForceTrackGroupsLeaderListCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_188;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class RscControlAmrelTabletForceTrackGroupsTypeText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_189;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Type";
        };
        class RscControlAmrelTabletForceTrackGroupsTypeListCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_190;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class RscControlAmrelTabletForceTrackGroupsNameText: Rsc86StructuredText {
            idc = ASSIGNED_IDC_191;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "Name";
        };
        class RscControlAmrelTabletForceTrackGroupsNameEdit: Rsc86Edit {
            idc = ASSIGNED_IDC_192;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "6.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class RscControlAmrelTabletForceTrackGroupsSpacer: Rsc86StructuredText {
            idc = ASSIGNED_IDC_193;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "7.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "";
        };

        class RscControlAmrelTabletForceTrackGroupsUpdateButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_194;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "8.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Update Group";
            colorBackground[] = {0,0,0,0.8};
        };
    };
};