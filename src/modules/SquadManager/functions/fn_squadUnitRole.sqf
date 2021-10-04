/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-21
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "get" : {
		_params params [["_target",objNull,[objNull]]];
		_target getVariable ["MPSF_VirtualArmoury_Role","Rifle"];
	};
	case "set" : {
		_params params [["_target",objNull,[objNull]],["_roleID","",[""]],["_force",false,[false]]];

		private _availableRoles = (["getCfgRoles"] call MPSF_fnc_getCfgRoles) apply {toLower _x};
		if !(toLower _roleID in _availableRoles) exitWith {[format["Role %1 does not exist",_roleID]] call BIS_fnc_error; false};

		private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_getCfgRoles) isEqualTo _roleID});
		private _roleLimit = ["getCfgRoleLimit",[_roleID]] call MPSF_fnc_getCfgRoles;

		if !(_countRoles < _roleLimit || _force) exitWith {
			if (hasInterface) then {
				["VirtualArmoury_RoleLimitReached",[
					["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_getCfgRoles
				]] call BIS_fnc_showNotification;
			};
			false;
		};

		if (leader group _target isEqualTo player || [player] call MPSF_fnc_isAdmin) then {
			_target setVariable ["MPSF_VirtualArmoury_Role",_roleID,true];
			["onRoleAssign",[_target,_roleID],0] call MPSF_fnc_triggerEventHandler;
		};

		true;
	};
	case "init" : {
		["MPSF_Squad_onRoleAssign_EH","onRoleAssign",{
			params [["_target",objNull,[objNull]],["_roleID","",[""]]];

			if (_target isEqualTo player || local _target) then {
				private _display = uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull];
				if !(isNull _display) then { _display closedisplay 2; };

				private _allTraits = ["getTraits"] call MPSF_fnc_getCfgRoles;
				private _traits = ["getCfgRoleTraits",[_roleID]] call MPSF_fnc_getCfgRoles;
				{
					[_target,_x,_x in _traits,false] call MPSF_fnc_setUnitTrait;
				} forEach _allTraits;

				if (primaryWeapon _target isEqualTo "" || {!isPlayer _target}) then {
					[_target,_roleID] call (missionNamespace getVariable ["MPSF_fnc_setArmouryLoadout",{false}]);
				};
				["setRoleVirtualCargo",[_target,_roleID]] call (missionNamespace getVariable ["MPSF_fnc_virtualArmoury",{false}]);
			};

			if (_target in units group player) then {
				["VirtualArmoury_RoleAssigned",[
					name _target
					,["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_getCfgRoles
				]] call BIS_fnc_showNotification;
			};
		}] call MPSF_fnc_addEventHandler;
	};
};