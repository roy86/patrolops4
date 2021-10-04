class RscDisplayLogistics {
	idd = -1;
	enableSimulation = 1;
	onLoad = "['onLoadLogisticsUI',_this] call MPSF_fnc_logisticsui;";
	onUnload = "['onUnloadLogisticsUI',_this] call MPSF_fnc_logisticsui;";
	class ControlsBackground {
		class RscLogisticsCtrlTitleLogo: Rsc86PictureKeepAspect {
			idc = 895;
			x = "(safezoneW/2) - 7.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)";
			y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)";
			w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "framework\data\titles\patrolops_banner_b_co.paa";
		};
		class RscLogisticsMouseArea: Rsc86Text {
			idc = 899;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};
	};
	class Controls {
		class DepotMenu: Rsc86ControlsGroupNoScrollbars {
			idc = 3000;
			x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
			y = "23.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "safezoneW";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls {
				class RscLogisticsTextLeft_1: Rsc86Text {
					idc = 3001;
					text = "";
					x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.8};
				};
				class RscLogisticsButtonVehicleSave: Rsc86ButtonMenu {
					idc = 3002;
					text = "Save Vehicle";
					x = "3 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.4) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "Service & Update Vehicles Loadout";
				};
				class RscLogisticsButtonCloseUI: Rsc86ButtonMenu {
					idc = 3003;
					text = "Close";
					x = "7 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.3) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "Exit the Depot [Escape]";
				};
			};
		};

		class RscLogisticsMouseBlock: Rsc86Text {
			idc = 898;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};

		class RscLogisticsIconBack0: Rsc86Picture {
			idc = 7000;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\icon_ca.paa";
			x = -1;
			y = -1;
			w = "1.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,0.8};
		};
		class RscLogisticsIcon0: Rsc86ButtonImg {
			idc = 7100;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa";
			x = -1;
			y = -1;
			w = "1.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {1,1,1,0};
		};
		class RscLogisticsIconBack1: RscLogisticsIconBack0 { idc = 7001; };
		class RscLogisticsIcon1: RscLogisticsIcon0 { idc = 7101; };
		class RscLogisticsIconBack2: RscLogisticsIconBack0 { idc = 7002; };
		class RscLogisticsIcon2: RscLogisticsIcon0 { idc = 7102; };
		class RscLogisticsIconBack3: RscLogisticsIconBack0 { idc = 7003; };
		class RscLogisticsIcon3: RscLogisticsIcon0 { idc = 7103; };
		class RscLogisticsIconBack4: RscLogisticsIconBack0 { idc = 7004; };
		class RscLogisticsIcon4: RscLogisticsIcon0 { idc = 7104; };
		class RscLogisticsIconBack5: RscLogisticsIconBack0 { idc = 7005; };
		class RscLogisticsIcon5: RscLogisticsIcon0 { idc = 7105; };
		class RscLogisticsIconBack6: RscLogisticsIconBack0 { idc = 7006; };
		class RscLogisticsIcon6: RscLogisticsIcon0 { idc = 7106; };
		class RscLogisticsIconBack7: RscLogisticsIconBack0 { idc = 7007; };
		class RscLogisticsIcon7: RscLogisticsIcon0 { idc = 7107; };
		class RscLogisticsIconBack8: RscLogisticsIconBack0 { idc = 7008; };
		class RscLogisticsIcon8: RscLogisticsIcon0 { idc = 7108; };
		class RscLogisticsIconBack9: RscLogisticsIconBack0 { idc = 7009; };
		class RscLogisticsIcon9: RscLogisticsIcon0 { idc = 7109; };
		class RscLogisticsIconBack10: RscLogisticsIconBack0 { idc = 7010; };
		class RscLogisticsIcon10: RscLogisticsIcon0 { idc = 7110; };
		class RscLogisticsIconBack11: RscLogisticsIconBack0 { idc = 7011; };
		class RscLogisticsIcon11: RscLogisticsIcon0 { idc = 7111; };
		class RscLogisticsIconBack12: RscLogisticsIconBack0 { idc = 7012; };
		class RscLogisticsIcon12: RscLogisticsIcon0 { idc = 7112; };
		class RscLogisticsIconBack13: RscLogisticsIconBack0 { idc = 7013; };
		class RscLogisticsIcon13: RscLogisticsIcon0 { idc = 7113; };
		class RscLogisticsIconBack14: RscLogisticsIconBack0 { idc = 7014; };
		class RscLogisticsIcon14: RscLogisticsIcon0 { idc = 7114; };
		class RscLogisticsIconBack15: RscLogisticsIconBack0 { idc = 7015; };
		class RscLogisticsIcon15: RscLogisticsIcon0 { idc = 7115; };
		class RscLogisticsIconBack16: RscLogisticsIconBack0 { idc = 7016; };
		class RscLogisticsIcon16: RscLogisticsIcon0 { idc = 7116; };
		class RscLogisticsIconBack17: RscLogisticsIconBack0 { idc = 7017; };
		class RscLogisticsIcon17: RscLogisticsIcon0 { idc = 7117; };
		class RscLogisticsIconBack18: RscLogisticsIconBack0 { idc = 7018; };
		class RscLogisticsIcon18: RscLogisticsIcon0 { idc = 7118; };
		class RscLogisticsIconBack19: RscLogisticsIconBack0 { idc = 7019; };
		class RscLogisticsIcon19: RscLogisticsIcon0 { idc = 7119; };
	};
};