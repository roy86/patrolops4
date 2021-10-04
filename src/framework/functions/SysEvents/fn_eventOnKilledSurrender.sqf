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
params [["_unit",objNull,[objNull]],["_groupID",grpNull,[grpNull]]];

{
    if (local _x) then {
        ["initCapture",[_x]] call MPSF_fnc_simulCapture;
    };
} forEach (units _groupID);

true;