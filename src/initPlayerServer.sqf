/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-28
    
    Description:
        Executed only on server when a player joins mission (includes both mission start and JIP). See Initialization Order for details about when exactly the script is executed.
		This script relies on BIS_fnc_execVM and remoteExec. If CfgRemoteExec's class Functions is set to mode = 0 or 1, the script will never be executed. Therefore, initPlayerServer.sqf should be avoided.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params ["_playerUnit", "_didJIP"];
