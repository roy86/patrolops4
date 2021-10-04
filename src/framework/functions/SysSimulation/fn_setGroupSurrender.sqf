/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_setGroupHold.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Sets a group to hold position
*/
params [["_units",[],[grpNull,objNull,[]]]];

if (_units isEqualType grpNull) then { _units = units _groupID; };
if (_units isEqualType objNull) then { _units = [_units]; };

{
	if (count (_x getVariable ["MPSF_Taskmanager_taskAttr",[]]) == 0) then {
		_x addEventHandler ["Killed",{
			params ["_killed","_killer"];
			private _group = group _killed;
			if ({alive _x} count units _group <= 2) then {
				["onKilledSurrender",[_killed,_group],0] call MPSF_fnc_triggerEventHandler;
			};
		}];
	};
} forEach _units;

true;