/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "preInit" : {
		/* Event Management System */
		["init"] call MPSF_fnc_eventSystem;
	};
	case "postInit" : {
		if (isServer) then {
			/* Broadcast Channel */
			private _channelName = "MPSFRadio1";
			private _channelID = radioChannelCreate [[1,0,0.23,1],_channelName,getMissionConfigValue ["missionRadioName","MPSF"],[]];
			if (_channelID == 0) exitWith {diag_log format ["Custom channel '%1' creation failed!", _channelName]};
			[_channelID, {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName];
			missionNamespace setVariable ["MPSF_Radio_channelID",_channelID]; publicVariable "MPSF_Radio_channelID";
			missionNamespace setVariable ["MPSF_Task_var_lastRefPos",[random worldsize,random worldsize,0]];
		};

		/* ***************************************************
		// DO NOT REMOVE THIS SECTION EVER FROM MY CODE     //
		*************************************************** */
		["MPSF_Framework_Notes","Notes","Ian (Westy) Westaway"
			,format[
				"<font size='18' color='#FFC600' face='PuristaLight'><b>Ian (Westy) Westaway</b></font><br/>By RoyEightysix<img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>%1<br/><br/>%2<br/>%3<br/>%4<br/>%5<br/><br/>%6<br/>%7<br/>%8<br/><br/>%9"
				,"For those who don't know, Westy, a great friend of mine passed mid-2020."
				,"I have known him for a years, worked with him, and played online in Arma with him."
				,"For those of you who use the Auto Open on the parachute, it is directly credited to him for inspiring me to create it."
				,"When I introduced him to arma, during our tac missions, he kept missing the open action on the parachute in time and would face plant into the ground without fail. So I created it for him and called it <font color='#FFC600'><b>'Westy's Auto Open'</b></font>."
				,"It has been in every mission I've made since."
				,"He was an Aussie champion. A guy who would listen, laugh, joke and share a beer with. He was a straight up mate to everyone."
				,"I was lucky to have known him and to consider myself a friend of his."
				,"I will miss him and remember him every time I play."
				,"Cheers Westy!"
		]] spawn {_this call (missionNamespace getVariable ["MPSF_fnc_createDiaryNote",{false}])};
		/* ***************************************************
		// DO NOT REMOVE THIS SECTION EVER FROM MY CODE     //
		*************************************************** */

		/* Briefing Notes */
		[] call MPSF_fnc_briefingNotes;

		if (hasInterface) then {
			waitUntil { !(isNull player) };
		};

		/* Interaction System */
		["init"] spawn MPSF_fnc_interaction;

		/* Tablet UI System */
		["init"] call MPSF_fnc_itemAmrelTablet;

		/* Task System */
		["init"] call MPSF_fnc_initCfgTasks;

		/* INTEL System */
		["init"] call MPSF_fnc_intel;

		/* Zeus Support */
		[] call MPSF_fnc_initZeus;

		// NPC Conversation
		["init"] call MPSF_fnc_conversation;

		// Civilians Simulation
		["init"] call MPSF_fnc_simulCiv;
	};
};