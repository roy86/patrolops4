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
params ["_unit", "_rating"];

if (rating _unit <= 0) then {
    if (rating _unit < 0) then {
        _unit customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],localize "STR_PO4_DIALOG_BADRATING"];
        ["onPlayerRatingBad",[],0] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);
    };
    _unit addRating ((abs rating _unit) + 1);
};