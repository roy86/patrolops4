class RscControlAmrelTabletButtons: Rsc86ControlsGroupNoScrollbars {
	idc = ASSIGNED_IDC_0;
	x = "14.1 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "33.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "28.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
		class RscControlAmrelTabletButton_Fnc1 : Rsc86ButtonTextOnly {
			idc = ASSIGNED_IDC_1;
			text = "";
			tooltip = "Undefined";
			x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.05 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1,1,1,0};
			shadow = 1;
		};
		class RscControlAmrelTabletButton_Fnc2 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_2;
			x = "2 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc3 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_3;
			x = "3.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc4 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_4;
			x = "5.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc5 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_5;
			x = "7.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc6 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_6;
			x = "9.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc7 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_7;
			x = "11.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc8 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_8;
			x = "13.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_Fnc9 : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_9;
			x = "15.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_FncX : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_10;
			x = "17.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_FncY : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_11;
			x = "19.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class RscControlAmrelTabletButton_FncZ : RscControlAmrelTabletButton_Fnc1 {
			idc = ASSIGNED_IDC_12;
			x = "26.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
			w = "3 * (((safezoneW / safezoneH) min 1.2) / 40)";
		};
    };
};

class RscControlAmrelTabletMenuScreen: Rsc86ControlsGroupNoScrollbars {
    idc = ASSIGNED_IDC_13;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
    y = "30.65 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlAmrelTabletMenuScreen_Fnc1: Rsc86StructuredText {
            idc = ASSIGNED_IDC_14;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "6.35 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            size = "0.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            sizeEx = "0.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "F1:Undefined";
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlAmrelTabletMenuScreen_Fnc2: RscControlAmrelTabletMenuScreen_Fnc1 {
            idc = ASSIGNED_IDC_15;
            x = "6.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            text = "F2:Undefined";
        };
        class RscControlAmrelTabletMenuScreen_Fnc3: RscControlAmrelTabletMenuScreen_Fnc1 {
            idc = ASSIGNED_IDC_16;
            x = "12.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
            text = "F3:Undefined";
        };
        class RscControlAmrelTabletMenuScreen_Fnc4: RscControlAmrelTabletMenuScreen_Fnc1 {
            idc = ASSIGNED_IDC_17;
            x = "19.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
            text = "F4:Undefined";
        };
        class RscControlAmrelTabletMenuScreen_Fnc5: RscControlAmrelTabletMenuScreen_Fnc1 {
            idc = ASSIGNED_IDC_18;
            x = "25.7 * (((safezoneW / safezoneH) min 1.2) / 40)";
            text = "F5:Undefined";
        };
        class RscControlAmrelTabletMenuScreen_Fnc6: RscControlAmrelTabletMenuScreen_Fnc1 {
            idc = ASSIGNED_IDC_19;
            x = "32.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            text = "F6:Undefined";
        };
    };
};