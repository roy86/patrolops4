class RscControlRespawnMPHalo: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_202;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "22.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "5.20 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
		class RscControlRespawnMPHALOslider: Rsc86XSliderH {
			idc = ASSIGNED_IDC_203;
            x = "12.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "3.00 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "14.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.00 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class RscControlRespawnMPHALOTextDist: Rsc86StructuredText {
			idc = ASSIGNED_IDC_204;
			text = "<t size='0.8' shadow='0'>Distance</t><br/><t size='1.7' shadow='0'>128m</t>"; //--- ToDo: Localize;
            x = "12.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.00 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
		};
		class RscControlRespawnMPHALOTextAlt: Rsc86StructuredText {
			idc = ASSIGNED_IDC_205;
			text = "<t size='0.8' shadow='0'>Altitude</t><br/><t size='1.7' shadow='0'>10.8km</t>"; //--- ToDo: Localize;
            x = "21.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.00 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "8.00 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.80 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
		};
        class RscControlRespawnMPHaloCommitButton: Rsc86ButtonMenu {
            idc = ASSIGNED_IDC_206;
            x = "12.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "4.10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "14.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Redeploy to Position";
            tooltip = "Redeploy to Position";
            colorBackground[] = {0.8,0,0,0.8};
            colorBackgroundFocused[] = {0.8,0,0,1};
        };
    };
};