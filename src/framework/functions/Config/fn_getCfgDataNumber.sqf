/*
	Author: Ji?? Wainar (Warka), optimised by Killzone_Kid, modified by Eightysix
*/
private _cfg = _this call BIS_fnc_getCfg;
if (isNumber _cfg) exitWith { getNumber _cfg };
if (isText _cfg) exitWith { parseNumber getText _cfg };
-1;