class RscControlAmrelTabletSquadManageView: Rsc86ControlsGroupNoScrollbars {
	idc = ASSIGNED_IDC_33;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "27.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls {
		class RscControlAmrelTabletSquadBackgroundGroupName: Rsc86Text {
			idc = ASSIGNED_IDC_34;
			x = "1.7 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "34.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.05 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text="";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
		};
		class RscControlAmrelTabletSquadPictureSide: Rsc86Picture {
			idc = ASSIGNED_IDC_35;
			x = "0.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "#(argb,8,8,3)color(0,0,1,0.6)";
		};
		class RscControlAmrelTabletSquadEditGroupName: Rsc86Edit {
			idc = ASSIGNED_IDC_36;
			style = "0x02 + 0x200";
			x = "1.83 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "34.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.26 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "";
			tooltip = "$STR_A3_RscDisplayDynamicGroups_Tooltip_EditGroupName";
			font = "RobotoCondensedLight";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			maxChars = 20;
		};
		class RscControlAmrelTabletSquadTextPlayerCount: Rsc86Text {
			idc = ASSIGNED_IDC_37;
			style = 2;
			x = "36.6 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "6";
			tooltip = "$STR_A3_RscDisplayDynamicGroups_Tooltip_PlayersInGroup";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.4};
		};

		class RscControlAmrelTabletSquadBackgroundManage: Rsc86Text {
			idc = ASSIGNED_IDC_38;
			x = "0.2 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "19.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "24.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.7};
		};

		class RscControlAmrelTabletSquadGroupIcon: Rsc86PictureKeepAspect {
			idc = ASSIGNED_IDC_39;
			x = "12.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "7 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "5.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\bi_ca.paa";
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,0.4};
		};

		class RscControlAmrelTabletSquadTextPlayerName: Rsc86Text {
			idc = ASSIGNED_IDC_40;
			x = "0.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "Leader";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadTextPlayerNameFill: Rsc86Text {
			idc = ASSIGNED_IDC_41;
			x = "3.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "8.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0.4,0.4,0.4,0.6};
			shadow = 0;
			style = 0;
		};

		class RscControlAmrelTabletSquadTextPlayerSide: Rsc86Text {
			idc = ASSIGNED_IDC_42;
			x = "0.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "4.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_A3_RscDisplayDynamicGroups_Side";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadTextPlayerSideFill: Rsc86Text {
			idc = ASSIGNED_IDC_43;
			x = "3.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "4.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "8.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0.4,0.4,0.4,0.6};
			shadow = 0;
			style = 0;
		};

		class RscControlAmrelTabletSquadTextPlayerScore: Rsc86Text {
			idc = ASSIGNED_IDC_44;
			x = "0.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_A3_RscDisplayDynamicGroups_Score";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadTextPlayerScoreFill: Rsc86Text {
			idc = ASSIGNED_IDC_45;
			x = "3.8 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "5.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "8.3 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0.4,0.4,0.4,0.6};
			shadow = 0;
			style = 0;
		};

		class RscControlAmrelTabletSquadTextPrivate: Rsc86Text {
			idc = ASSIGNED_IDC_46;
			text = "$STR_A3_RscDisplayDynamicGroups_Private";
			x = "0.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "6.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxPrivate: Rsc86CheckBox {
			idc = ASSIGNED_IDC_47;
			x = "3.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "6.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayDynamicGroups_Tooltip_PrivateGroup";
		};

        class RscControlAmrelTabletSquadPlayerBackground: Rsc86StructuredText {
            idc = ASSIGNED_IDC_48;
            x = "19.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "18.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "24.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            colorBackground[] = {0,0,0,0.2};
        };
        class RscControlAmrelTabletSquadScreen_PlayerList: Rsc86ListNBox {
            idc = ASSIGNED_IDC_49;
            x = "19.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "18.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "24.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            columns[] = {0.05,0.1};
            colorBackground[] = {0,0,0,0.2};
        };
	};
};