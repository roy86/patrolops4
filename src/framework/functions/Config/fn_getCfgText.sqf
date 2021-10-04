params [["_object","",["",objNull]],["_type","displayName",[""]]];

//(format ["CFGTEXT: %1",_this]) call BIS_fnc_logFormat;

if (_object isEqualType objNull) then {
	_object = typeOf _object;
};
if (_object isEqualTo "") exitWith { "" };

private _class = "";
{
	if (isClass (configFile >> _x >> _object)) exitWith {
		_class = toLower _x;
	};
} forEach ["CfgWeapons","CfgMagazines","CfgAmmo","CfgVehicles","CfgGlasses","CfgItems","CfgMarkers","cfgGroupIcons","CfgTaskTypes"];

if (_class isEqualTo "") exitWith {
	//format ["Detect Config text Error of %1",_object] call BIS_fnc_error;
	"";
};

if (_class isEqualTo "cfggroupicons") exitWith {
	getText (configFile >> _class >> _object >> "picture");
};

if (_class isEqualTo "cfgtasktypes") exitWith {
	getText (configFile >> _class >> _object >> "icon");
};

getText (configFile >> _class >> _object >> _type);