/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_position",[0,0,0],[[],objNull,""]],["_displayText","",[""]],["_displayIcon","",[""]]];

if (isServer) then {
	if (_position isEqualTo [0,0,0]) exitWith {};
	if (_position isEqualType "") then { _position = _position call BIS_fnc_position; };

	if !(_position isEqualType objNull) then {
		_position = [_position call BIS_fnc_position] call MPSF_fnc_createLogic;
	};

	if !(_displayText isEqualTo "") then {
		_position setVariable ["MPSF_Intel_VRtext_F",_displayText,true];
	};

	if !(_displayIcon isEqualTo "") then {
		_position setVariable ["MPSF_Intel_VRicon_F",_displayIcon,true];
	};
};