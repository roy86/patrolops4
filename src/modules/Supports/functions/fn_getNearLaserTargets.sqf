/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-01-17
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_position",[0,0,0],[[]]]];

private _lasedTargets = [];
{
	private _laserTarget = laserTarget _x;
	if (_laserTarget distance2D _position < 150) exitWith {
		_lasedTargets pushBackUnique _laserTarget;
	};
} forEach ((playableUnits + switchableUnits) select {side _x isEqualTo side player});

_lasedTargets;