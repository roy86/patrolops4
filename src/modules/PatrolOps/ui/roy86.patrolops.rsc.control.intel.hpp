class RscControlMissionConsoleIntel: Rsc86ControlsGroupNoScrollbars {
    idc = 97001;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "26.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlMissionConsoleIntelBanner: Rsc86StructuredText {
            idc = 97002;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "<t size='1.6' shadow='0'>Patrol Operations Mission Intelligence</t>"; //--- ToDo: Localize;
            colorBackground[] = {0,0,0,0.8};
        };
        class RscControlMissionConsoleIntelInfo: Rsc86StructuredText {
            idc = 97003;
            x = "0.1* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Find locations that might contain Operational Intelligence to unlock new Operations";
            colorBackground[] = {0,0,0,0.6};
        };
        class RscControlMissionConsoleIntelTitle: Rsc86StructuredText {
            idc = 97004;
            x = "(38.4/2-5)* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "<t size='1.6' shadow='0' align='center'>Intel Collected</t>"; //--- ToDo: Localize;
        };
        class RscControlMissionConsoleIntelCount: Rsc86StructuredText {
            idc = 97005;
            x = "(38.4/2-5)* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "<t size='4' shadow='0' align='center'>0</t>"; //--- ToDo: Localize;
        };
        class RscControlMissionConsoleOPsCount: Rsc86StructuredText {
            idc = 97006;
            x = "(38.4/2-5)* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "17 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "<t size='1.1' shadow='0' align='center'>0</t>"; //--- ToDo: Localize;
        };
        class RscControlMissionConsoleIntelCompile: Rsc86ButtonMenu {
            idc = 97007;
            x = "(38.3/2-7) * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "20.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "14.0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Analyse Intel";
            tooltip = "Send Intel to be Analysed for Operational Mission";
            colorBackground[] = {0.8,0,0,0.8};
        };
    };
};

class RscControlMissionConsoleIntelOrders: Rsc86ControlsGroupNoScrollbars {
    idc = 97010;
	x = "8.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "15.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "12.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    class Controls {
        class RscControlMissionConsoleIntelOrdersBanner: Rsc86StructuredText {
            idc = 97011;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "<t font='PuristaMedium' size='1' shadow='0'>Issue Orders</t>";
        };
        class RscControlMissionConsoleIntelOrdersTaskText: Rsc86StructuredText {
            idc = 97012;
            x = "0* (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "3.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.8};
            text = "<t font='PuristaMedium' size='1' shadow='0'>Patrol Summary:</t>";
        };
        class RscControlMissionConsoleIntelOrdersButton: Rsc86ButtonMenu {
            idc = 97013;
            x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "4.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Order Task";
            colorBackground[] = {0.8,0,0,0.8};
        };
    };
};