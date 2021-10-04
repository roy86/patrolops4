class RscControlAmrelTabletSquadRoleView: Rsc86ControlsGroupNoScrollbars {
	idc = ASSIGNED_IDC_50;
	x = "7.05 * (((safezoneW / safezoneH) min 1.2) / 40) + safeZoneX + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_X"",0])";
	y = "4.35 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + safeZoneY + (uiNamespace getVariable [""Roy86_IGUI_AmrelTablet_Y"",0])";
	w = "38.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "27.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls {
        class RscControlAmrelTabletSquadRoleScreen_PlayerList: Rsc86ListNBox {
            idc = ASSIGNED_IDC_51;
            x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "19 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "25 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            columns[] = {0.05,0.1};
            colorBackground[] = {0,0,0,0.2};
        };
		class RscControlAmrelTabletSquadUnitRankText: Rsc86Text {
			idc = ASSIGNED_IDC_52;
			text = "Select Player";
            x = "20.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "3.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {1,1,1,1};
			shadow = 0;
			style = 1;
		};
        class RscControlAmrelTabletSquadUnitRankDropdown: Rsc86Combo {
            idc = ASSIGNED_IDC_53;
            x = "20.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "6.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class RscControlAmrelTabletSquadUnitRoleDropdown: Rsc86Combo {
            idc = ASSIGNED_IDC_54;
            x = "20.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
            y = "7.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class RscControlAmrelTabletSquadUnitRoleBanner1: Rsc86StructuredText {
            idc = -1;
			x = "(20.4 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*0) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Vehicle Capabilities";
            colorBackground[] = {0,0,0,0.8};
        };
		class RscControlAmrelTabletSquadRoleCheckboxTextCrewman: Rsc86Text {
			idc = ASSIGNED_IDC_55;
			text = "Crewman";
			x = "(20.4 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*1) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxCrewman: Rsc86CheckBox {
			idc = ASSIGNED_IDC_56;
			x = "(23.9 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*1) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable Capability to Drive Armour";
		};

		class RscControlAmrelTabletSquadRoleCheckboxTextPilotHeli: Rsc86Text {
			idc = ASSIGNED_IDC_57;
			text = "PilotHeli";
			x = "(20.4 + 5.6*1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*1) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxPilotHeli: Rsc86CheckBox {
			idc = ASSIGNED_IDC_58;
			x = "(23.9 + 5.6*1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*1) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable Capability to Pilot Rotary Wing";
		};

		class RscControlAmrelTabletSquadRoleCheckboxTextPilotPlane: Rsc86Text {
			idc = ASSIGNED_IDC_59;
			text = "PilotPlane";
			x = "(20.4 + 5.6*2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*1) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxPilotPlane: Rsc86CheckBox {
			idc = ASSIGNED_IDC_60;
			x = "(23.9 + 5.6*2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*1) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable Capability to Pilot Fixed Wing";
		};

        class RscControlAmrelTabletSquadUnitRoleBanner2: Rsc86StructuredText {
            idc = -1;
			x = "(20.4 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*2) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Unit Capabilities";
            colorBackground[] = {0,0,0,0.8};
        };
		class RscControlAmrelTabletSquadRoleCheckboxTextMedic: Rsc86Text {
			idc = ASSIGNED_IDC_61;
			text = "Medic";
			x = "(20.4 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*3) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxMedic: Rsc86CheckBox {
			idc = ASSIGNED_IDC_62;
			x = "(23.9 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*3) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable Medic Capability";
		};

		class RscControlAmrelTabletSquadRoleCheckboxTextEngineer: Rsc86Text {
			idc = ASSIGNED_IDC_63;
			text = "Engineer";
			x = "(20.4 + 5.6*1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*3) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxEngineer: Rsc86CheckBox {
			idc = ASSIGNED_IDC_64;
			x = "(23.9 + 5.6*1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*3) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable Engineer Repair Capability";
		};

		class RscControlAmrelTabletSquadRoleCheckboxTextExplosiveSpecialist: Rsc86Text {
			idc = ASSIGNED_IDC_65;
			text = "Explosive";
			x = "(20.4 + 5.6*2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*3) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxExplosiveSpecialist: Rsc86CheckBox {
			idc = ASSIGNED_IDC_66;
			x = "(23.9 + 5.6*2) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*3) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable Explosive Specialist Capability";
		};

        class RscControlAmrelTabletSquadUnitRoleBanner3: Rsc86StructuredText {
            idc = -1;
			x = "(20.4 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*4) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "17 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "Permissions";
            colorBackground[] = {0,0,0,0.8};
        };
		class RscControlAmrelTabletSquadRoleCheckboxTextHALO: Rsc86Text {
			idc = ASSIGNED_IDC_67;
			text = "HALO";
			x = "(20.4 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxHALO: Rsc86CheckBox {
			idc = ASSIGNED_IDC_68;
			x = "(23.9 + 5.6*0) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable HALO Capability";
		};

		class RscControlAmrelTabletSquadRoleCheckboxTextJTAC: Rsc86Text {
			idc = ASSIGNED_IDC_69;
			text = "JTAC";
			x = "(20.4 + 5.6*1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 2*5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "3.4 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.6,0.6,0.6,0.6};
			shadow = 0;
			style = 1;
		};
		class RscControlAmrelTabletSquadCheckboxJTAC: Rsc86CheckBox {
			idc = ASSIGNED_IDC_70;
			x = "(23.9 + 5.6*1) * (((safezoneW / safezoneH) min 1.2) / 40)";
			y = "(9.8 + 0.1 + 2*5) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "Enable JTAC Capability to request Supports";
		};
	};
};