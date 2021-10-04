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

_altitude = _fog param [2,fogparams select 2,[0]];
_density = _fog param [1,fogparams select 1,[0]];
_fog = _fog param [0,fogparams select 0,[0]];

["onWeatherChange",[_overcast,[_fog,_density,_altitude]],0] call MPSF_fnc_triggerEventHandler;

true;