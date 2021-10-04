/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-22
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]]];

if (isNull _target) exitWith {};
if (local _target) then {
	["setHandcuffed",[_target]] call MPSF_fnc_simulCapture;
};

true;