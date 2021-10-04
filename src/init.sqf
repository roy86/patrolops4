/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-05
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
/* TODO: REMOVE --------------------------------------------------------- */

if (!isMultiplayer && {(getMissionConfigValue ["missionDebugMode",0]) isEqualTo 1}) then {
    PO4_fnc_initPlayer = {
        player allowDamage false;
        player enableFatigue false;
        MPSF_BaseGriefProtectionDisabled = true;
        OnMapSingleClick "vehicle player setVehiclePosition [[_pos select 0, _pos select 1, if( (vehicle player) isKindof ""AIR"" && isEngineOn (vehicle player) ) then { 100 }else{ 0 } ],[],0,""None""]";
        setDate [date select 0,date select 1, 9, 5, 30];
    };

	[] call PO4_fnc_initPlayer;

	["setScore",[player,52]] call MPSF_fnc_intel;
};
/* --------------------------------------------------------- */

["Preload"] call BIS_fnc_arsenal;