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
if (isServer) then {
    _this call MPSF_fnc_eventOnEachFrameServer;
};

if (hasInterface) then {
    _this call MPSF_fnc_eventOnEachFrameClient;
};