class RscControlAmrelTabletSupportFiremission: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_100;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "27.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletSupportFiremissionCrossLineV: Rsc86Line {
            x = "19.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "12.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineH: Rsc86Line {
            x = "18.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "13.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineTL1: Rsc86Line {
            x = "15.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "9.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineTL2: Rsc86Line {
            x = "15.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "9.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineTR1: Rsc86Line {
            x = "21.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "9.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineTR2: Rsc86Line {
            x = "23.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "9.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineBL1: Rsc86Line {
            x = "15.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "17.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineBL2: Rsc86Line {
            x = "15.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "15.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineBR1: Rsc86Line {
            x = "21.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "17.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSupportFiremissionCrossLineBR2: Rsc86Line {
            x = "23.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "15.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class RscControlAmrelTabletSupportFiremissionCrossLaserIcon: Rsc86PictureKeepAspect {
            idc = ASSIGNED_IDC_101;
            x = "18.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "9.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "\a3\ui_f_curator\Data\CfgCurator\laser_ca.paa";
            tooltip = "Eightysix is Awesome";
        };

        class RscControlAmrelTabletSupportFiremissionBatteryCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_102;
            x = "0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Artillery Battery";
        };
        class RscControlAmrelTabletSupportFiremissionAmmoTypeCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_103;
            x = "10.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Ordnance Type";
        };
        class RscControlAmrelTabletSupportFiremissionSalvoSubButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_104;
            x = "20.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "-";
            tooltip = "Subtract Round";
        };
        class RscControlAmrelTabletSupportFiremissionSalvoEdit: Rsc86Edit {
            idc = ASSIGNED_IDC_105;
            x = "21.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "3 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "0";
            tooltip = "Set number of Salvos";
        };
        class RscControlAmrelTabletSupportFiremissionSalvoAddButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_106;
            x = "24.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "+";
            tooltip = "Add Round";
        };
        class RscControlAmrelTabletSupportFiremissionDelaySubButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_107;
            x = "25.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "-";
            tooltip = "Reduce Delay";
        };
        class RscControlAmrelTabletSupportFiremissionDelayEdit: Rsc86Edit {
            idc = ASSIGNED_IDC_108;
            x = "26.7 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "3 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "0";
            tooltip = "Set Delay";
        };
        class RscControlAmrelTabletSupportFiremissionDelayAddButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_109;
            x = "29.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "+";
            tooltip = "Increase Delay";
        };
        class RscControlAmrelTabletSupportFiremissionSpreadCombo: Rsc86Combo {
            idc = ASSIGNED_IDC_110;
            x = "31.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "7.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            tooltip = "Select Spread";
        };
        class RscControlAmrelTabletSupportFiremissionPlayerPos1: Rsc86StructuredText {
            idc = ASSIGNED_IDC_111;
            x = "0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "4.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "6.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletSupportFiremissionPlayerPos2: Rsc86StructuredText {
            idc = ASSIGNED_IDC_112;
            x = "4.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "5.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "6.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletSupportFiremissionTargetPos1: Rsc86StructuredText {
            idc = ASSIGNED_IDC_113;
            x = "28.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "4.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "6.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletSupportFiremissionTargetPos2: Rsc86StructuredText {
            idc = ASSIGNED_IDC_114;
            x = "32.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "5.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "6.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
        };

        class RscControlAmrelTabletSupportFiremissionGridXSubButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_115;
            x = "6.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-0.5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "-";
            tooltip = "Reduce Latitude";
        };
        class RscControlAmrelTabletSupportFiremissionGridXEdit: Rsc86Edit {
            idc = ASSIGNED_IDC_116;
            x = "7.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-0.5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "";
            tooltip = "Set Latitude";
        };
        class RscControlAmrelTabletSupportFiremissionGridXAddButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_117;
            x = "11.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-0.5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "+";
            tooltip = "Increase Latitude";
        };
        class RscControlAmrelTabletSupportFiremissionGridXText: Rsc86Text {
            idc = ASSIGNED_IDC_118;
            x = "6.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-1.6) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "6.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Latitude";
        };

        class RscControlAmrelTabletSupportFiremissionGridYSubButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_119;
            x = "25.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-0.5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "-";
            tooltip = "Reduce Longitude";
        };
        class RscControlAmrelTabletSupportFiremissionGridYEdit: Rsc86Edit {
            idc = ASSIGNED_IDC_120;
            x = "26.7 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-0.5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "";
            tooltip = "Set Longitude";
        };
        class RscControlAmrelTabletSupportFiremissionGridYAddButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_121;
            x = "30.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-0.5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "+";
            tooltip = "Increase Longitude";
        };
        class RscControlAmrelTabletSupportFiremissionGridYText: Rsc86Text {
            idc = ASSIGNED_IDC_122;
            x = "25.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "(27.3/2-1.6) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "6.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Longitude";
        };

        class RscControlAmrelTabletSupportFiremissionCommitButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_123;
            x = "(38.3/2-7) * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "24.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "14.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Execute Firemission";
            tooltip = "Execute Firemission";
            colorBackground[] = {0.8,0,0,0.8};
        };
    };
};