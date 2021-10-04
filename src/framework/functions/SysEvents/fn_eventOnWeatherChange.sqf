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
params [["_overcast",overcast],["_fog",fogParams,[[]]]];

if (_overcast isEqualType 0) then {
	0 setOvercast _overcast;
};

if (_fog isEqualTypeArray [0,0,0] || _fog isEqualType 0) then {
	0 setFog _fog;
};

forceweatherchange;