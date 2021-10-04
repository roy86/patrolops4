class RscControlAmrelTabletSupportMap: Rsc86StrategicMap {
    idc = ASSIGNED_IDC_99;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "26.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	//scaleMin = "0.01";
};