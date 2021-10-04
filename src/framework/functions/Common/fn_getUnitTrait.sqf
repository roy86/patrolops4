/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-01-10
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_target",objNull,[objNull]],["_trait","",[""]],["_default",false,[false,""]]];

private _traitValue = _target getUnitTrait _trait;
if (_traitValue isEqualType _default) exitWith {
    _traitValue
};

_default;