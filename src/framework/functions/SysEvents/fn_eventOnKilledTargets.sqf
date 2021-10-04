/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-01-19
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_units",[],[objNull,[]]],["_attributes",[],[[]]]];

if (_units isEqualType objNull) then { _units = [_units]; };

{
	if (count (_x getVariable ["MPSF_Taskmanager_taskAttr",[]]) == 0) then {
		_x setVariable ["MPSF_Taskmanager_taskAttr",_attributes,true];
		_x addEventHandler ["Killed",{
			params ["_killed","_killer"];
			private _group = group _killed;
			if ({alive _x} count units(_group) == 0) then {
				private _attributes = _killed getVariable ["MPSF_Taskmanager_taskAttr",[]];
				["onKilledDropIntel",[_killed,_attributes],2] call MPSF_fnc_triggerEventHandler;
				["onTaskUnitKilled",[_killed,_attributes],2] call MPSF_fnc_triggerEventHandler;
			};
			_killed setVariable ["MPSF_Taskmanager_taskAttr",nil,true];
		}];
	};
} forEach _units;

true;