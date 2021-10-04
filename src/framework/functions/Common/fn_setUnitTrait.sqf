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
params [["_target",objNull,[objNull]],["_trait","",[""]],["_value",false,[false]],["_showChat",true,[false]]];

private _hasTrait = [_target,_trait,false] call MPSF_fnc_getUnitTrait;
private _knownTraits = ["medic","engineer","explosiveSpecialist","UAVHacker"] apply {toLower _x};
_target setUnitTrait [_trait,_value,!(toLower _trait in _knownTraits)];

if (_showChat) then {
    private _hasCustomRadio = (missionNamespace getVariable ["MPSF_Radio_channelID",-1]) >= 0;
	switch (true) do {
		case (_value && !_hasTrait): {
            if (_hasCustomRadio) then {
                player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],format ["%1 assigned as %2",name _target,_trait]];
            } else {
                [west, "HQ"] sideChat format ["%1 assigned as %2",name _target,_trait];
            };
        };
		case (_hasTrait && !_value): {
            if (_hasCustomRadio) then {
                player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],format ["%1 unassigned as %2",name _target,_trait]];
            } else {
                [west, "HQ"] sideChat format ["%1 unassigned from %2",name _target,_trait];
            };
        };
	};

};

true;