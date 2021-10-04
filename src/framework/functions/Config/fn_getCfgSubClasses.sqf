/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-03-01
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
(configProperties [(_this call BIS_fnc_getCfg),"isClass _x", true]) apply {configName _x};