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
params [["_objects",[],[objNull,[]]],["_attributes",[],[[]]],["_explosion",false,[false]]];

if (_objects isEqualType objNull) then {_objects = [_objects];};

{
	_x setVariable ["MPSF_Taskmanager_taskAttr",_attributes,true];
	_x setVariable ["explodeBig",_explosion,true];
	_x addEventHandler ["HandleDamage",{
		params ["_object","_hitSelection","_damage","_source","_projectile","_hitPartIndex","_instigator","_hitPoint"];
		private _return = count ((_projectile splitString "-_") arrayIntersect ["DemoCharge","SatchelCharge","Remote","TimeBombCore"]);
		if (_return > 0) then {
			private _attributes = _object getVariable ["MPSF_Taskmanager_taskAttr",[]];
			if (_object getVariable ["explodeBig",false]) then {
				[getPosWorld _object,6 + random 6,false] spawn MPSF_fnc_effectExplosionSecondaries;
			};
			_object setDamage 1;
			["onTaskObjectDestroyed",[_object,_attributes],2] call (missionNamespace getVariable ["MPSF_fnc_triggerEventHandler",{}]);
			deleteVehicle _object;
		};
		0;
	}];
} forEach _objects;

true;