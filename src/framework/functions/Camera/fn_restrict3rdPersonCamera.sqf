/*
	Description:
	This function updates the misison parameter for restriction of 3rd Person
		- PARAM Only
*/
params [["_value",0,[0]]];

if (hasInterface) then {
	["MPSF_3rdPersonCheck_trigger_EH","on3rdPersonCameraReset",{
		//[side player,"Base"] sideChat "External Camera Disabled";
		params [["_value",0,[0]]];
		private _text = switch (_value) do {
			case 1 : {"External Camera for Tank Drivers Only"};
			case 2 : {"External Camera for Pilots Only"};
			case 3 : {"External Camera for Drivers & Pilots Only"};
			case 4 : {"External Camera Disabled"};
			default {""};
		};
		if !(_text isEqualTo "") then {
			player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],_text];
		};
	}] call MPSF_fnc_addEventHandler;

	switch (_value) do {
		case 1 : { // Armour 3rd Person
			["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
				if (cameraView isEqualTo "EXTERNAL") then {
					if !(vehicle player isKindOf "Tank" && driver vehicle player isEqualTo player) then {
						vehicle player switchCamera "Internal";
						["on3rdPersonCameraReset",[1],true] call MPSF_fnc_triggerEventHandler;
					};
				};
			}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
			["MPSF_Framework_Note","Features","3rd Person Restriction","<font size='16' face='PuristaLight'>3rd Person Restriction</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>Restrictions are in effect. Unless you are the driver of a <font color='#ffC600'>TANK</font> typeClass, 3rd person camera will reset on the next possible frame to a first person camera view."] spawn {sleep 1; _this call MPSF_fnc_createDiaryNote};
		};
		case 2 : { // Air 3rd Person
			["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
				if (cameraView isEqualTo "EXTERNAL") then {
					if !(vehicle player isKindOf "Air" && driver vehicle player isEqualTo player) then {
						vehicle player switchCamera "Internal";
						["on3rdPersonCameraReset",[2],true] call MPSF_fnc_triggerEventHandler;
					};
				};
			}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
			["MPSF_Framework_Note","Features","3rd Person Restriction","<font size='16' face='PuristaLight'>3rd Person Restriction</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>Restrictions are in effect. Unless you are the driver of a <font color='#ffC600'>AIRCRAFT</font> typeClass, 3rd person camera will reset on the next possible frame to a first person camera view."] spawn {sleep 1; _this call MPSF_fnc_createDiaryNote};
		};
		case 3 : { // Driver 3rd Person
			["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
				if (cameraView isEqualTo "EXTERNAL") then {
					if !(driver vehicle player isEqualTo player && !(vehicle player isKindOf "CaManBase")) then {
						vehicle player switchCamera "Internal";
						["on3rdPersonCameraReset",[3],true] call MPSF_fnc_triggerEventHandler;
					};
				};
			}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
			["MPSF_Framework_Note","Features","3rd Person Restriction","<font size='16' face='PuristaLight'>3rd Person Restriction</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>Restrictions are in effect. Unless you are the driver of any <font color='#ffC600'>VEHICLE</font> typeClass, 3rd person camera will reset on the next possible frame to a first person camera view."] spawn {sleep 1; _this call MPSF_fnc_createDiaryNote};
		};
		case 4 : { // No 3rd Person
			["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame",{
				if (cameraView isEqualTo "EXTERNAL") then {
					vehicle player switchCamera "Internal";
					["on3rdPersonCameraReset",[4],true] call MPSF_fnc_triggerEventHandler;
				};
			}] spawn { uisleep 0.1; _this call MPSF_fnc_addEventHandler; };
			["MPSF_Framework_Note","Features","3rd Person Restriction","<font size='16' face='PuristaLight'>3rd Person Restriction</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>Restrictions are in effect. 3rd person camera will reset on the next possible frame to a first person camera view no matter what vehicle type used."] spawn {sleep 1; _this call MPSF_fnc_createDiaryNote};
		};
		default {
			["MPSF_3rdPersonCheck_onEachFrame_EH","onEachFrame"] call MPSF_fnc_removeEventHandler;
			["MPSF_3rdPersonCheck_trigger_EH","on3rdPersonCameraReset"] call MPSF_fnc_removeEventHandler;
		};
	};
};

true;