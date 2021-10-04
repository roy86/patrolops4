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
params ["_killed","_attributes"];

private _group = group _killed;

if ({alive _x} count units(_group) == 0) then {
	["create",[getPosATL _killed,_attributes]] call MPSF_fnc_intel;
};

if (selectRandom [false,true]) then {
	_killed setVariable ["MPSF_INTEL_ATTRIBUTES",[],true];
};

true;