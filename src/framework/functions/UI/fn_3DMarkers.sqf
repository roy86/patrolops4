/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-03-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#define ICONEMPTY							"#(argb,8,8,3)color(0,0,0,0.8)"
#define ICONBG								"\a3\ui_f\data\IGUI\Cfg\simpleTasks\background3_over_ca.paa"
#define ICONMOVE							"\a3\ui_f\data\IGUI\Cfg\Cursors\mission_ca.paa"
#define COLOURORANGE(alpha)					[1,0.66,0,alpha]

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "add" : {};
	case "remove" : {};
	case "getNearby" : {
		_params params [["_position",[],[[]]],["_radius",25,[0]]];
		if !(_position isEqualTypeArray [0,0,0]) then {[]};
		(nearestObjects [_position,["All"],_radius]) select {
			!((_x getVariable ["MPSF_Intel_VRtext_F",""]) + (_x getVariable ["MPSF_Intel_VRicon_F",""]) isEqualTo "")
		};
	};
	case "preInit" : {};
	case "postInit" : {
		["init"] call MPSF_fnc_3Dmarkers;
	};
	case "init" : {
		["MPSF_3Dmarkets_onEachFrame_EH","onEachFrame",{
			if (missionNamespace getVariable ["suspend3D",false]) exitWith {};

			private _pos = positionCameraToWorld [0,0,0];
			private _nearbyVRtargets = ["getNearby",[_pos]] call MPSF_fnc_3Dmarkers;
			//
			if (_nearbyVRtargets isEqualTo []) exitWith {};
			if !(surfaceIsWater _pos) then { _pos = ATLtoASL _pos; };

			{
				(boundingBoxReal _x) params ["_p1","_p2"];
				private _offset = (_p2 select 2) - (_p1 select 2);
				private _drawPos = _x modelToWorld [0,0,abs _offset + 1];
				private _alpha = if (missionNamespace getVariable ["MPSF_onKeyPress_57_State",false]) then {
					0.5
				} else {
					0 max (1-(_pos distance2D _drawPos)/25) min 1
				};
				private _drawPos2 = _x modelToWorld [0,0,abs (_offset + 1) + (0.15 * (1 - _alpha))];

				switch (_x getVariable ["MPSF_Intel_VRiconType_F",-1]) do {
					case 0 : {};
					default {
						drawIcon3D [ICONBG,COLOURORANGE(_alpha),_drawPos,1.6,1.6,0,"",0];
						drawIcon3D [(_x getVariable ["MPSF_Intel_VRicon_F",ICONMOVE]),COLOURORANGE(_alpha),_drawPos2,1,1,0,"",0];
						drawIcon3D [ICONEMPTY,[1,1,1,_alpha],_drawPos,0,-3,0,(_x getVariable ["MPSF_Intel_VRtext_F",""]),2,0.04,"RobotoCondensed"];
					};
				};
			} forEach _nearbyVRtargets;
		}] call MPSF_fnc_addEventHandler;
	};
};