class RscControlMissionConsoleAvailableOps: Rsc86ControlsGroupNoScrollbars {
    idc = 98000;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "12.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "26.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
		class RscControlMissionConsoleAvailableOpsText: Rsc86StructuredText {
			idc = 98001;
			text = "<t size='1.2' shadow='0'>Available Operations</t>"; //--- ToDo: Localize;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "12.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
		};
        class RscControlMissionConsoleAvailableOpsList: Rsc86ListBox {
            idc = 98002;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "12.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "24.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            columns[] = {0.05,0.1};
            colorBackground[] = {0,0,0,0.8};
        };
    };
};