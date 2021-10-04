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
params [["_actionID","",[""]],["_object",objNull,[objNull]]];

if (isServer) then {
	private _globalActions = missionNamespace getVariable ["MPSF_InterAction_globalActions",[]];
	{
		if ((_x select 0) isEqualTo _actionID) exitWith { _globalActions deleteAt _forEachIndex; };
	} forEach _globalActions;
	missionNamespace setVariable ["MPSF_InterAction_globalActions",_globalActions];
	publicVariable "MPSF_InterAction_globalActions";
};

if (hasInterface) then {
	private _index = _object getVariable [_actionID,-1];
	if (_index >= 0) then {
		_object removeAction _index;
	};
	_object setVariable [_actionID,nil];

	private _localActions = missionNamespace getVariable ["MPSF_InterAction_localActions",[]];
	{
		if ((_x select 0) isEqualTo _actionID) exitWith { _localActions deleteAt _forEachIndex; };
	} forEach _localActions;
	missionNamespace setVariable ["MPSF_InterAction_localActions",_localActions];

	private _playerActions = missionNamespace getVariable ["MPSF_InterAction_playerActions",[]];
	{
		if ((_x select 0) isEqualTo _actionID) exitWith { _playerActions deleteAt _forEachIndex; };
	} forEach _playerActions;
	missionNamespace setVariable ["MPSF_InterAction_playerActions",_playerActions];
};