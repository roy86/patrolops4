class RscDisplayMissionSelection {
	idd = 860142;
	enableSimulation = 1;
    onLoad = "['onLoad',_this] call PO4_fnc_rscDisplayMissionUI;";
	class ControlsBackground {
		class MissionCtrlMap: Rsc86StrategicMap {
			idc = 1001;
			x = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneW)";
			h = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneH)";
		};
		class MissionCtrlBackground: Rsc86StructuredText {
			idc = 1002;
			x = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneXAbs)";
			y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "0 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneWAbs)";
			h = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneH)";
			colorBackground[] = {0,0,0,1};
		};
		class RespawnCtrlTitleLogo: Rsc86PictureKeepAspect {
			idc = 1003;
			x = "(safeZoneW/2) - 10 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "20 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "10 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			text = "framework\data\titles\patrolops_banner_b_co.paa";
		};
	};
	class Controls {
		class MissionTextTR1: Rsc86StructuredText {
			idc = 2011;
			x = "20 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			text = "-";
			class Attributes {
				font = "EtelkaMonospacePro";
			};
		};
		class MissionTextTR2: MissionTextTR1 {
			idc = 2012;
			y = "1.3 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			text = "-";
			class Attributes {
				font = "EtelkaMonospacePro";
			};
		};
		class MissionTextTR3: MissionTextTR1 {
			idc = 2013;
			y = "2.1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "10 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
			h = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			size = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.7 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			text = "-";
			class Attributes {
				font = "EtelkaMonospacePro";
			};
		};
		class MissionCtrlMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 2100;
			x = "0.5 * (((safeZoneW / safeZoneH) min 1.2) / 40) + (safeZoneX)";
			y = "23.5 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + (safeZoneY + safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2))";
			w = "safeZoneW";
			h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class MissionCtrlMenuButton1: Rsc86ButtonMenu {
					idc = 2101;
					text = "Intel";
					x = "3 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
				};
				class MissionCtrlMenuButton2: Rsc86ButtonMenu {
					idc = 2102;
					text = "Unlock Operation";
					x = "4 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.2) - 0.1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
				};
				class MissionCtrlMenuButton3: Rsc86ButtonMenu {
					idc = 2103;
					text = "Close";
					x = "6 * ((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					w = "((safeZoneW - 1 * (((safeZoneW / safeZoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safeZoneW / safeZoneH) min 1.2) / 40)";
					h = "1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "Exit [Escape]";
				};
			};
		};
		class FrameLeft: Rsc86Frame {
			idc = 2200;
			x = "4 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
		};
		class ListOps: Rsc86ListBox {
			idc = 2201;
			x = "4 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {0.8,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class TabOps: Rsc86ButtonImg {
			idc = 2202;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Car_ca.paa";
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "0.5 * 0.04 + 0 * 0.04 + (safezoneY)";
			w = "(1.4 * 2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Operations"; // Todo: Localise
			colorBackground[] = {0,0,0,0.8};
		};
		class MissionCtrlInfo: Rsc86StructuredText {
			idc = 2300;
			x = "20 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "2.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY)";
			w = "30 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
			text = "";
		};
	};
};