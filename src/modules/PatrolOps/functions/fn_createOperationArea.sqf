/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-28
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_cfgTaskID","",["",[],0]],["_areaID","",[""]]];

switch (true) do {
	case (_cfgTaskID isEqualType []) : { _cfgTaskID = selectRandom _cfgTaskID; };
	case (_cfgTaskID isEqualType 0) : { _cfgTaskID = ""; };
	case (_cfgTaskID isEqualType "");
};

if (_cfgTaskID isEqualTo "") exitWith { ["No Task Configuration ID provided"] call BIS_fnc_error; };
if (_areaID isEqualTo "") then {
	//
};