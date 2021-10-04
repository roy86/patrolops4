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
params [["_type","Client",[""]]];

switch (_type) do {
	case "Client" : { isMultiplayer && {hasInterface} || {!isMultiplayer} && {hasInterface} };
	case "Server" : { isMultiplayer && {isServer} || {!isMultiplayer} };
	case "HeadlessClient" : { isMultiplayer && {!hasInterface} };
	default {false};
};