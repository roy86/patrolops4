/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-07-06
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "getCfgRoles" : {
		_params params [["_sideID",side group player,[0,sideUnknown]],["_resolve",false,[false]]];

		if !(_sideID isEqualType 0) then { _sideID = _sideID call BIS_fnc_sideID; };

		private _roles = (["CfgVirtualArmoury"] call BIS_fnc_getCfgSubClasses) select {
            private _roleSideID = ["CfgVirtualArmoury",_x,"side"] call MPSF_fnc_getCfgDataNumber;
            _roleSideID < 0 || _roleSideID isEqualTo _sideID || _sideID < 0
        };

		if (_resolve) then {
			_roles = _roles apply { ["getCfgRoleData",[_x]] call MPSF_fnc_getCfgRoles; };
		};

		_roles;
	};
	case "getCfgRoleData" : {
		_params params [["_roleID","",[""]]];
		[
			_roleID
			,["getCfgRoleSideID",[_roleID]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleIcon",[_roleID]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleLimit",[_roleID]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"crewman"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"pilotHeli"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"pilotPlane"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"medic"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"engineer"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"explosiveSpecialist"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"UAVHacker"]] call MPSF_fnc_getCfgRoles
			,["getCfgRoleTrait",[_roleID,"halo"]] call MPSF_fnc_getCfgRoles
		]
	};
	case "getCfgRoleSideID" : {
		_params params [["_roleID","",[""]]];
		["CfgVirtualArmoury",_roleID,"side"] call MPSF_fnc_getCfgDataNumber;
	};
	case "getCfgRoleDisplayName" : {
		_params params [["_roleID","",[""]]];
		["CfgVirtualArmoury",_roleID,"displayName"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgRoleIcon" : {
		_params params [["_roleID","",[""]]];
		["CfgVirtualArmoury",_roleID,"icon"] call MPSF_fnc_getCfgDataText;
	};
	case "getCfgRoleLimit" : {
		_params params [["_roleID","",[""]]];
		private _limit = ["CfgVirtualArmoury",_roleID,"limit"] call MPSF_fnc_getCfgDataNumber;
		if (_limit <= 0) then { _limit = 1e3; };
		_limit;
	};
	case "getCfgRoleTraits" : {
		_params params [["_roleID","",[""]]];
		(["CfgVirtualArmoury",_roleID,"traits"] call MPSF_fnc_getCfgDataArray) apply {toLower _x};
	};
	case "getCfgRoleTrait" : {
		_params params [["_roleID","",[""]],["_trait","",[""]]];
		private _traits = (["CfgVirtualArmoury",_roleID,"traits"] call MPSF_fnc_getCfgDataArray) apply {toLower _x};
		(toLower _trait) in _traits
	};
    case "getTraits" : {
        (["CfgVirtualArmoury","allTraits"] call MPSF_fnc_getCfgDataArray) apply {toLower _x};
    };
	case "getCfgRoleFullLoadout" : {
		_params params [["_roleID","",[""]]];
		["CfgVirtualArmoury",_roleID,"fullArmoury"] call MPSF_fnc_getCfgDataBool;
	};
	case "getCfgRoleLoadout" : {
		_params params [["_roleID","",[""]],["_type","",[""]]];
		private _cfgLoadout = missionConfigFile >> "CfgVirtualArmoury" >> _roleID >> "Armoury";

		private _typeNames = [];
		{
			if !((configName _x) find _type < 0) then {
				{
					_typeNames pushBackUnique _x;
				} forEach getArray(_x);
			};
		} foreach configProperties [_cfgLoadout,"true",true];

		switch (_type) do {
			case "items" : {
				private _uniforms = ["getCfgRoleLoadout",[_roleID,"gear"]] call MPSF_fnc_getCfgRoles;
				{ _typeNames pushBackUnique _x; } forEach _uniforms;
				{ _typeNames pushBackUnique _x; } forEach getArray (_cfgLoadout >> "linkedItems");

				if (isText(_cfgLoadout >> "uniformClass")) then {
					_typeNames pushBackUnique getText(_cfgLoadout >> "uniformClass");
				};

				if (isText(_cfgLoadout >> "uniform")) then {
					_typeNames pushBackUnique getText(_cfgLoadout >> "uniform");
				};
			};
			case "backpacks" : {
				if (isText(_cfgLoadout >> "backpack")) then {
					_typeNames pushBackUnique getText(_cfgLoadout >> "backpack");
				};
			};
			case "weapons" : {
				_typeNames = _typeNames apply { _x call BIS_fnc_baseWeapon; };
			};
		};
		_typeNames select {!(_x isEqualTo "")};
	};
	case "checkVehicleRole" : {
		_params params [["_target",objNull,[objNull]],["_vehicle",objNull,[objNull]]];

		if (_target IN assignedCargo _vehicle) exitWith { true };

		private _accessExempt = ["CfgVirtualArmoury","enableVehicleAccess"] call MPSF_fnc_getCfgDataArray;
		if ({ _vehicle isKindOf _x } count _accessExempt > 0) exitWith { true };

		private _return = switch (true) do {
			case (_vehicle isKindOf "Helicopter") : { ["getUnitTrait",[_target,"pilotHeli"]] call MPSF_fnc_virtualArmoury; };
			case (_vehicle isKindOf "Plane") : { ["getUnitTrait",[_target,"pilotPlane"]] call MPSF_fnc_virtualArmoury; };
			case (_vehicle isKindOf "Tank") : { ["getUnitTrait",[_target,"crewman"]] call MPSF_fnc_virtualArmoury; };
			default { true };
		};

		_return
	};
};