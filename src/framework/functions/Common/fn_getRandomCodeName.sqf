/*
	Multiplayer Scripted Framework (MPSF)
	Author: Roy86 (email.me@roy86.com.au)

	File: fn_getRandomOpName.sqf
	Author(s): see mpsf\credits.txt

	Description:
		Genrate a random operation name from CfgMissionFramework

	Returns:
		STRING
*/
private _content = ["CfgMissionFramework","OperationNames","object"] call MPSF_fnc_getCfgDataArray;
private _suffix = ["CfgMissionFramework","OperationNames","suffix"] call MPSF_fnc_getCfgDataArray;

private _string = "";
if (count _content > 0) then { _string = _string + "%1 "; _content = selectRandom _content; };
if (count _suffix > 0) then { _string = _string + "%2"; _suffix = selectRandom _suffix; };

format [_string,_content,_suffix];