/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-13
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class RscControlAmrelTabletSettingsView: Rsc86ControlsGroupNoScrollbars {
	idc = 86072;
	x = "10.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "10.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls {
		class RscControlAmrelTabletSettings_Btn1: Rsc86ButtonMenu {
			idc = 86073;
			text = "Land";
			x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			tooltip = "Set View Distance for Ground";
		};
		class RscControlAmrelTabletSettings_Btn2: Rsc86ButtonMenu {
			idc = 86074;
			text = "Helicopter";
			x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			tooltip = "Set View Distance for Helicopters";
		};
		class RscControlAmrelTabletSettings_Btn3: Rsc86ButtonMenu {
			idc = 86075;
			text = "Plane";
			x = "2 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			tooltip = "Set View Distance for Aircraft";
		};
		class RscControlAmrelTabletSettings_TextVD: Rsc86Text {
			idc = 86076;
			x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
			y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "View Distance";
			colorBackground[] = {0,0,0,0.5};
		};
		class RscControlAmrelTabletSettings_SliderVD: Rsc86XSliderH {
			idc = 86077;
			x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08)";
			y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.17) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class RscControlAmrelTabletSettings_EditVD: Rsc86Edit {
			idc = 86078;
			x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.25)";
			y = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.05) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onKillFocus = "				comment 'DO NOT COPY THIS CODE TO YOUR ATTRIBUTE CONFIG UNLESS YOU ARE CHANGING SOMETHING IN THE CODE!';				_ctrlGroup = ctrlParentControlsGroup (_this select 0);				_value = sliderposition (_ctrlGroup controlsgroupctrl 100);				[_ctrlGroup,_value] call bis_fnc_3DENIntel;			";
		};
		class RscControlAmrelTabletSettings_TextDD: Rsc86Text {
			idc = 86079;
			x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
			y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "Draw Distance";
			colorBackground[] = {0,0,0,0.5};
		};
		class RscControlAmrelTabletSettings_SliderDD: Rsc86XSliderH {
			idc = 86080;
			x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08)";
			y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.17) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class RscControlAmrelTabletSettings_EditDD: Rsc86Edit {
			idc = 86081;
			x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.25)";
			y = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.05) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onKillFocus = "				comment 'DO NOT COPY THIS CODE TO YOUR ATTRIBUTE CONFIG UNLESS YOU ARE CHANGING SOMETHING IN THE CODE!';				_ctrlGroup = ctrlParentControlsGroup (_this select 0);				_value = sliderposition (_ctrlGroup controlsgroupctrl 100);				[_ctrlGroup,_value] call bis_fnc_3DENIntel;			";
		};
		class RscControlAmrelTabletSettings_TerrainText: Rsc86Text {
			idc = 86082;
			x = "0 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
			y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "Terrain";
			colorBackground[] = {0,0,0,0.5};
		};
		class RscControlAmrelTabletSettings_TerrainList: Rsc86ListBox {
			idc = 86083;
			x = "1 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.08)";
			y = "3.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.22) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.5};
		};
	};
};