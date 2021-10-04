/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-02-01
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]],["_attributes",[],[[]]]];

//[_target] call MPSF_fnc_law_onKilledInjured;
[_target,"nearbyEncounters",_attributes] call MPSF_fnc_addConversation;