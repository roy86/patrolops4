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
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

private _dist = ["MPSF_Param_BaseGriefProtection",0] call BIS_fnc_getParamValue;

if (_dist isEqualTo 0) exitWith {};

if (missionNamespace getVariable ["MPSF_BaseGriefProtectionDisabled",false]) exitWith {};

if(
	_projectile distance (getMarkerPos "respawn_west") < _dist ||
	_projectile distance (getMarkerPos "respawn_east") < _dist ||
	_projectile distance (getMarkerPos "respawn_guerrila") < _dist
)then {
		player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],localize "STR_PO4_DIALOG_CEASEFIRE"];
		player addRating -100;
		deleteVehicle _projectile;
}else{
	[_projectile,_dist] spawn {
		params ["_projectile","_dist"];
		waitUntil {
			if(
				_projectile distance (getMarkerPos "respawn_west") < _dist ||
				_projectile distance (getMarkerPos "respawn_east") < _dist ||
				_projectile distance (getMarkerPos "respawn_guerrila") < _dist
			) then {
				player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],localize "STR_PO4_DIALOG_CEASEFIRE"];
				player addRating -100;
				deleteVehicle _projectile;
			};
			if( isNull _projectile ) exitWith { true };
			false
		};
	};
};