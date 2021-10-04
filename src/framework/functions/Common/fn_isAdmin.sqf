/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_isAdmin.sqf
	Author(s): see mpsf\credits.txt
	Credit: Mackenzieexd from TaskForce72 for UID filter idea

	Description:
		Validates player as Administrator based on UID Filter and Server Commands.
		Credit to

	Parameter(s):
		0: OBJECT - Player

	Returns:
		BOOL - True if administrator permissions
*/
params [["_player",player,[objNull]]];
// AI check
if !(isPlayer _player) exitWith {false};
// Get configured Admin IDs
private _adminUIDs = ["CfgMissionFramework","AdminUIDs"] call MPSF_fnc_getCfgDataArray;
// Server command access check
if (serverCommandAvailable "#kick" && "_MP_CANKICK_" in _adminUIDs) exitWith {true};
// Specific Player UIDs
if (getPlayerUID _player IN _adminUIDs) exitWith {true};
// Specific Unit Class Types
if (count (_adminUIDs select {_player isKindOf _x}) > 0) exitWith {true};
// Else "Not Admin"
false;