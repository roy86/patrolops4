/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-21
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]],["_rank","",[""]]];

if (_rank isEqualTo "") exitWith {false};

_target setRank toUpper _rank;

player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],format ["%1 assigned rank as %2",name _target,_rank]];

true;