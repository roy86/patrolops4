/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-31
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_units",[],[objNull,[]]]];

if (_units isEqualType objNull) then { _units = [_units]; };

{
	_x addEventHandler ["HandleDamage",{
		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
		_unit setSkill 0.3;
		_damage * 2.25;
	}];
} forEach _units;

true;