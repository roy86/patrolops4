/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
if !(hasInterface) exitWith {false};
if (["missionDebugMode"] call MPSF_fnc_getCfgDataBool) exitWith {
	waitUntil {!(isNull ([] call BIS_fnc_displayMission))};
	["onIntroComplete"] call MPSF_fnc_triggerEventHandler;
	false;
};

["PO4_introScript_onComplete_EH","onIntroComplete",{
	["PO4_introScript_onComplete_EH","onIntroComplete"] call MPSF_fnc_removeEventHandler;

	(["cfgMissionIntroCam",worldName,"text"] call MPSF_fnc_getCfgDataArray) params [["_line1",""],["_line2",""],["_line3",""]];

	private _factionName = ["displayLongName","FactionTypeBLU"] call MPSF_fnc_getCfgFaction;
	private _respawn = (["getRespawnPositions",[player]] call MPSF_fnc_respawnMP) param [0,[player,"None",false]];
	[
		[
			[worldName, "align = 'center' shadow = '1' size = '1' font='PuristaBold'", "#ffc600"],
			[" | ", "align = 'center' shadow = '1' size = '0.9' font='PuristaBold'", "#ffffff"],
			[_respawn param [1,""], "align = 'center' shadow = '1' size = '0.9'", "#ffffff"],
			["","<br/>"],
			[_factionName,"align = 'center' shadow = '1' size = '0.75'", "#d2d2d2"]
		],
		safeZoneX, safeZoneH / 2,
		true,
		"<t font='PuristaBold'>%1</t>",
		[],
		{ false },
		true
	] spawn BIS_fnc_typeText2;
}] call MPSF_fnc_addEventHandler;

missionNamespace setVariable ["PO4_INTRO_SCRIPT",[] spawn {
	waitUntil {!(isNull ([] call BIS_fnc_displayMission))};

	private _musicVolume = musicVolume;
	private _wparray = [];
	private _duration = 20;

	/* Prepare Sequence 1 */
	private _worldCams = ["CfgMissionFramework","MapData",worldName,"camera"] call MPSF_fnc_getCfgDataArray;
	if (count _worldCams > 0) then {
		(selectRandom _worldCams) params [["_posX",0],["_posY",0],["_posZ",0],["_direction",0]];
		private _distance = 1000;
		private _campos_1 = [_posX,_posY,_posZ];
		private _camTgt_1 = _campos_1 getPos [_distance,_direction]; _camTgt_1 set [2,-1000];
		_wparray pushBack [_campos_1,50,_camTgt_1,0,0.5,false,"fadeIn"];

		private _campos_2 = _campos_1 getPos [_distance/3,_direction];
		private _camTgt_2 = _campos_1 getPos [_distance,_direction];
		_wparray pushBack [_campos_2,50,_camTgt_2,_duration,0.5,false,"fadeOut"];
	};

	/* Prepare Sequence 2 */
	[270,600,600,16] params ["_bse","_rad","_alt","_dur"];
	_pos = (position player);
	_dir = if(random 1 > 0.5) then { -1 }else{ 1 };
	_wpc = round (_rad / 12) max 5;
	_rid = round (_rad / _wpc);
	_aid = round (_alt / _wpc);
	_inc = 360/_wpc;
	for "_i" from 0 to _wpc do {
		_ang = _bse + _inc * _dir * _i;
		_a = (_pos select 0)+(sin(_ang)*_rad);
		_b = (_pos select 1)+(cos(_ang)*_rad);
		_time = if (_i == 0) then {0} else {_dur/_wpc};
		_wparray pushBack [[_a,_b,_alt],-1,player,_time,0.5,false,"fadeIn"];
		_rad = (_rad - _rid) max 1;
		_alt = (_alt - _aid) max 1;
	};

	/* Execute Sequences */
	4 fadeMusic 1;
	playMusic ["LeadTrack01b_F_EXP",23];

	[([] call BIS_fnc_displayMission),"RscDisplayCameraIntro"] call MPSF_fnc_createCtrl;

	private _ctrlCfgText = (["CfgMission","introText"] call MPSF_fnc_getCfgDataArray);
	private _textArguments = (["CfgMission","introTextArguments"] call MPSF_fnc_getCfgDataArray) apply {[_x] call MPSF_fnc_getTaskDescription};
	_ctrlCfgText = _ctrlCfgText apply {[format([_x select 0] + _textArguments),_x select 1,3]};
	missionNamespace setVariable ["PO4_INTRO_SCRIPT2",_ctrlCfgText spawn {
		uiSleep 8;
		[_this,0.002] call MPSF_fnc_typeText;
	}];

	private _rscTop = uiNamespace getVariable ["RscDisplayCameraIntro_MainBackgroundTop",controlNull];
	_rscTopPos = ctrlPosition _rscTop;
	_rscTopPos set [3,0];
	_rscTop ctrlSetPosition _rscTopPos;
	_rscTop ctrlSetFade 0.2;
	_rscTop ctrlCommit _duration/2;

	private _rscBottom = uiNamespace getVariable ["RscDisplayCameraIntro_MainBackgroundBottom",controlNull];
	_rscBottomPos = ctrlPosition _rscBottom;
	_rscBottomPos set [3,0];
	_rscBottomPos set [1,safeZoneH + safeZoneY];
	_rscBottom ctrlSetPosition _rscBottomPos;
	_rscBottom ctrlSetFade 0.2;
	_rscBottom ctrlCommit _duration/2;

	private _rscTitle = uiNamespace getVariable ["RscDisplayCameraIntro_Title",controlNull];
	_rscTitle ctrlSetFade 1;
	_rscTitle ctrlCommit 0;
	_rscTitle spawn {
		_this ctrlSetFade 0;
		_this ctrlCommit 5;
		uiSleep 5;
		_this ctrlSetFade 1;
		_this ctrlCommit 4;
	};

	[_wparray,true] call MPSF_fnc_cameraShot;

	["PO4_onKeyPress_skipIntro_EH","onKeyDown"] call MPSF_fnc_removeEventHandler;
	["RscDisplayCameraIntro"] call MPSF_fnc_destroyCtrl;

	10 fadeMusic 0;

	_musicVolume spawn {
		uiSleep 10;
		playMusic "";
		0 fadeMusic _this;
	};
	["onIntroComplete"] call MPSF_fnc_triggerEventHandler;
}];

["PO4_onKeyPress_skipIntro_EH","onKeyDown",{
	private _key = param [1,0,[0]];
	if (_key == 57) then {
		_keyTime = missionNamespace getVariable ["PO4_onKeyPress_skipIntro_timer",0];
		if (_keyTime > 15) then {
			["PO4_onKeyPress_skipIntro_EH","onKeyDown"] call MPSF_fnc_removeEventHandler;
			["RscDisplayCameraIntro"] call MPSF_fnc_destroyCtrl;
			terminate (missionNamespace getVariable "PO4_INTRO_SCRIPT");
			terminate (missionNamespace getVariable "PO4_INTRO_SCRIPT2");
			["", _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
			["destroyCamera",["CameraPath"]] call MPSF_fnc_Camera;
			5 fadeMusic 0;
			1 spawn {
				uiSleep 10;
				playMusic "";
				0 fadeMusic _this;
			};
			["onIntroComplete"] call MPSF_fnc_triggerEventHandler;
		};
		missionNamespace setVariable ["PO4_onKeyPress_skipIntro_timer",_keyTime + 1];
	};
}] call MPSF_fnc_addEventHandler;

true;