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
params [["_target",objNull,[objNull]]];

_target addEventHandler ["Hit",{
	["onHit",_this,true] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);
}];