/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-10
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
class RscDisplayNewStarterUI {
	position[] = {
		"safeZoneXAbs"
		,"safeZoneY + (safeZoneH/2) - 6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
		,"safeZoneWAbs"
		,"8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
	};
	class controls {
        class Step1_Background {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {0,0,0,0};
        };
		class Step1_Icon {
			type = "RscPictureKeepAspect";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"5/2 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4/2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move1_ca.paa";
		};
        class Step1_Title {
			type = "RscStructuredText";
			position[] = {
				"5/2 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "<t size='1.5' shadow='0' color='#ffc600'>Squad Up</t><br/><t size='0.8' shadow='0' color='#ffffff'>Join a squad or recruit others to your squad.<br/>Use the Amrel Device in your action menu under squad (F2).</t>";
        };

        class Step2_Background {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {0,0,0,0};
        };
		class Step2_Icon {
			type = "RscPictureKeepAspect";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"5/2 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4/2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move2_ca.paa";
		};
        class Step2_Title {
			type = "RscStructuredText";
			position[] = {
				"5/2 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "<t size='1.5' shadow='0' color='#ffc600'>Gear Up</t><br/><t size='0.8' shadow='0' color='#ffffff'>Get a role and equip yourself properly.<br/>The armoury will have the gear available based on your role.</t>";
        };

        class Step3_Background {
			type = "RscText";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			colorBackground[] = {0,0,0,0};
        };
		class Step3_Icon {
			type = "RscPictureKeepAspect";
			position[] = {
				"0 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"5/2 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4/2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\move3_ca.paa";
		};
        class Step3_Title {
			type = "RscStructuredText";
			position[] = {
				"5/2 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
				,"15 * (((safezoneW / safezoneH) min 1.2) / 40)"
				,"4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)"
			};
			text = "<t size='1.5' shadow='0' color='#ffc600'>Begin Patrol</t><br/><t size='0.8' shadow='0' color='#ffffff'>Leave the base and move to an area to begin a patrol.<br/>Speak with Civs, gather Intel and identify potential operations.</t>";
        };
	};
};