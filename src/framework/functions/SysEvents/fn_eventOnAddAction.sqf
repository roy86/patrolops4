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
params [
	["_actionID","",[""]]
	,["_object",objNull,[objNull]]
	,["_displayText","Interact",[""]]
	,["_script",{},[{},[]]]
	,["_arguments",[],[[]]]
	,["_condition","true",[""]]
	,["_draw3D",false,[false]]
];

if (isServer) then {
	private _globalActions = missionNamespace getVariable ["MPSF_InterAction_globalActions",[]];
	_globalActions pushBackUnique [_actionID,_object,_displayText,_script,_arguments,_condition,_draw3D];
	missionNamespace setVariable ["MPSF_InterAction_globalActions",_globalActions];
	publicVariable "MPSF_InterAction_globalActions";
};

if (hasInterface) then {
	if (_object isEqualTo player) then {
		private _localActions = missionNamespace getVariable ["MPSF_InterAction_playerActions",[]];
		_localActions pushBackUnique [_actionID,_object,_displayText,_script,_arguments,_condition,_draw3D];
		missionNamespace setVariable ["MPSF_InterAction_playerActions",_localActions];
	} else {
		private _localActions = missionNamespace getVariable ["MPSF_InterAction_localActions",[]];
		_localActions pushBackUnique [_actionID,_object,_displayText,_script,_arguments,_condition,_draw3D];
		missionNamespace setVariable ["MPSF_InterAction_localActions",_localActions];
	};	
	["addAction",_this] call MPSF_fnc_Interaction;
};