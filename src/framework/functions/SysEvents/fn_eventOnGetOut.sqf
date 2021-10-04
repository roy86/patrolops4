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
params ["_vehicle", "_role", "_unit", "_turret"];

["MPSF_VehicleDoor_Action",_unit] call MPSF_fnc_removeAction;