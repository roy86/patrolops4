#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
// Arsenal Integration
	case "buildControl" : {
		_params params [["_display",displayNull,[displayNull]],["_displayCtrl","",[""]]];

		if !(isNull _display) then {
			private _displayCtrls = [];
			private _ctrlAnchor = getArray(missionConfigFile >> _displayCtrl >> "position");
			{ _ctrlAnchor set [_foreachindex,call compile _x]; } forEach _ctrlAnchor;

			{
				private _ctrlName = configName _x;
				private _ctrlType = getText(_x >> "Type");
				private _ctrl = _display ctrlCreate [_ctrlType,86919 + _foreachindex];

				private _ctrlPos = getArray(_x >> "Position");
				{
					_ctrlPos set [_foreachindex,call compile _x];
				} forEach _ctrlPos;
				_ctrlPos = [
					(_ctrlAnchor select 0) + (_ctrlPos select 0)
					,(_ctrlAnchor select 1) + (_ctrlPos select 1)
					,(_ctrlPos select 2)
					,(_ctrlPos select 3)
				];
				_ctrl ctrlSetPosition _ctrlPos;

				if (isArray(_x >> "colorBackground")) then {
					private _colourBackground = getArray(_x >> "colorBackground");
					{ if (typeName _x isEqualTo typeName "") then { _colourBackground set [_foreachindex,call compile _x]; }; } forEach _colourBackground;
					_ctrl ctrlSetBackgroundColor _colourBackground
				};

				if (isText(_x >> "text")) then {
					_ctrl ctrlSetText getText(_x >> "text");
				};

				if (isText(_x >> "sizeEx")) then {
					_ctrl ctrlSetFontHeight (call compile getText (_x >> "sizeEx"));
				};

				if (isArray(_x >> "columns")) then {
					private _countCols = count (lnbGetColumnsPosition _ctrl);
					private _columns = getArray(_x >> "columns");
					if (count _columns > 3) then {
						for "_i" from 3 to (count _columns - 1) do {
							_ctrl lnbAddColumn (_columns select _i);
						};
					};
					_ctrl lnbSetColumnsPos _columns;
				};

				if (isText(_x >> "onLBSelChanged")) then {
					_ctrl ctrlAddEventHandler ["lbselchanged",getText(_x >> "onLBSelChanged")];
				};

				if (isText(_x >> "onButtonClick")) then {
					_ctrl ctrlAddEventHandler ["buttonclick",getText(_x >> "onButtonClick")];
				};

				_ctrl ctrlCommit 0;

				_displayCtrls pushBack _ctrl;
				uiNamespace setVariable [format["%1_%2",_displayCtrl,_ctrlName],_ctrl];
			} forEach ("isClass _x" configClasses (missionConfigFile >> _displayCtrl >> "controls"));

			uiNamespace setVariable [_displayCtrl,_displayCtrls];
		};
	};
	case "destroyControl" : {
		_params params [["_displayCtrl","",[""]]];
		{
			ctrlDelete _x;
		} forEach (uiNamespace getVariable [_displayCtrl,[]]);
	};
// Role/Loadout Functions
	case "onRoleRequest" : {
		_params params [["_target",objNull,[objNull]],["_roleID","",[""]]];

		private _assignState = ["getCfgAssignRoles"] call MPSF_fnc_virtualArmoury;
		private _cleared = switch (_assignState) do {
			case 1 : { ([player] call MPSF_fnc_isAdmin) }; // Admin Only
			case 2 : { ([player] call MPSF_fnc_isAdmin) || (player isEqualTo leader group _target) }; // Admin & Squad Leaders
			default { false };
		};

		if (_cleared || !(isMultiplayer)) then {
			private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_getCfgRoles) isEqualTo _roleID});
			private _roleLimit = ["getCfgRoleLimit",[_roleID]] call MPSF_fnc_getCfgRoles;
			if !(_countRoles < _roleLimit) exitWith {};

			if (_target isEqualTo player || local _target) exitWith {
				["setUnitRole",[_target,_roleID]] call MPSF_fnc_getCfgRoles;
			};

			["VirtualArmoury_RoleRequest",[
				name _target
				,["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_getCfgRoles
			]] call BIS_fnc_showNotification;
		};
	};
	case "setRoleVirtualCargo" : {
		_params params [["_target",player,[objNull]],["_roleID","",[""]]];

		if (isNull _target) exitWith {
			["VirtualArmoury has No Vaild Target"] call BIS_fnc_error
		};
		if !(_target isEqualTo player) exitWith {
			["VirtualArmoury has No Vaild Target"] call BIS_fnc_error
		};

		if (_roleID isEqualTo "") then {_roleID = ["get",[_target]] call MPSF_fnc_squadUnitRole;};
		private _virtualArmouryBox = uiNamespace getVariable ["MPSF_VirtualArmoury_Ammobox",objNull];
		if (isNull _virtualArmouryBox) exitWith { 
			["VirtualArmoury has no Vaild ammobox"] call BIS_fnc_error;
		};

		(["getCompatibleRoleWeapons",[_roleID]] call MPSF_fnc_virtualArmoury) params ["_weapons","_items","_unknownVar","_backpacks","_magazines"];

		private _fastLookupTable = uiNamespace getVariable ["bis_fnc_arsenal_data", locationNull];
		private _CFGVEHICLES = configfile >> "CfgVehicles";
		private _CFGWEAPONS = configfile >> "CfgWeapons";
		private _CFGMAGAZINES = configfile >> "CfgMagazines";
		private _CFGGLASSES = configfile >> "CfgGlasses";
		{
			if (isClass(_CFGVEHICLES >> _x) || isClass(_CFGWEAPONS >> _x) || isClass(_CFGMAGAZINES >> _x) || isClass(_CFGGLASSES >> _x) ) then {
				_fastLookupTable setVariable [_x,_x in _weapons || _x in _magazines || _x in _items || _x in _backpacks];
			};
		} forEach allVariables _fastLookupTable;

		// Clear Existing Cargo
		if (_virtualArmouryBox isEqualType objNull) then {
			clearWeaponCargoGlobal _virtualArmouryBox;
			clearItemCargoGlobal _virtualArmouryBox;
			clearBackpackCargoGlobal _virtualArmouryBox;
			clearMagazineCargoGlobal _virtualArmouryBox;
		};
		[_virtualArmouryBox,(_virtualArmouryBox call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
		[_virtualArmouryBox,(_virtualArmouryBox call BIS_fnc_getVirtualWeaponCargo)] call BIS_fnc_removeVirtualWeaponCargo;

		// Add Gear to Ammobox
		if (count _items > 0) then { [_virtualArmouryBox,_items,false,false] call BIS_fnc_addVirtualItemCargo; };
		if (count _weapons > 0) then { [_virtualArmouryBox,_weapons,false,false] call BIS_fnc_addVirtualWeaponCargo; };
		if (count _magazines > 0) then { [_virtualArmouryBox,_magazines,false,false] call BIS_fnc_addVirtualMagazineCargo; };
		if (count _backpacks > 0) then { [_virtualArmouryBox,_backpacks,false,false] call BIS_fnc_addVirtualBackpackCargo; };

		true;
	};
	case "setRoleVirtualCargoX" : {
		_params params [["_ammoboxes",[],[objNull,[],missionNamespace]],["_roleID","",[""]]];

		if (_roleID isEqualTo "") then { _roleID = ["get",[player]] call MPSF_fnc_squadUnitRole; };

		(["getCompatibleRoleWeapons",[_roleID]] call MPSF_fnc_virtualArmoury) params ["_weapons","_magazines","_items","_backpacks"];

		if (_ammoboxes isEqualTo []) then { _ammoboxes = ["getArmouryLogics"] call MPSF_fnc_virtualArmoury; };
		if !(_ammoboxes isEqualType []) then { _ammoboxes = [_ammoboxes]; };
		{
			private _ammobox = _x;

			// Clear Existing Cargo
			if (_ammobox isEqualType objNull) then {
				clearWeaponCargoGlobal _ammobox;
				clearItemCargoGlobal _ammobox;
				clearBackpackCargoGlobal _ammobox;
				clearMagazineCargoGlobal _ammobox;
			};
			[_ammobox,(_ammobox call BIS_fnc_getVirtualItemCargo)] call BIS_fnc_removeVirtualItemCargo;
			[_ammobox,(_ammobox call BIS_fnc_getVirtualWeaponCargo)] call BIS_fnc_removeVirtualWeaponCargo;

			// Add Gear to Ammobox
			if (count _items > 0) then { [_ammobox,_items,false,false,1,0] call BIS_fnc_addVirtualItemCargo; };
			if (count _weapons > 0) then { [_ammobox,_weapons,false,false,1,1] call BIS_fnc_addVirtualItemCargo; };
			if (count _magazines > 0) then { [_ammobox,_magazines,false,false,1,2] call BIS_fnc_addVirtualItemCargo; };
			if (count _backpacks > 0) then { [_ammobox,_backpacks,false,false,1,3] call BIS_fnc_addVirtualItemCargo; };
		} forEach _ammoboxes;

		true;
	};
	case "getUnitTrait" : {
		_params params [["_target",objNull,[objNull]],["_trait","",[""]],["_default",false,[false,""]]];

		private _traitValue = _target getUnitTrait _trait;
		if (_traitValue isEqualType _default) exitWith {
			_traitValue
		};

		_default;
	};
	case "setUnitTrait" : {
		_params params [["_target",objNull,[objNull]],["_trait","",[""]],["_value",false,[false]],["_showChat",true,[false]]];

		private _hasTrait = ["getUnitTrait",[_target,_trait,false]] call MPSF_fnc_virtualArmoury;
		private _knownTraits = ["medic","engineer","explosiveSpecialist","UAVHacker"] apply {toLower _x};
		_target setUnitTrait [_trait,_value,!(toLower _trait in _knownTraits)];

		if (_showChat) then {
			switch (true) do {
				case (_value && !_hasTrait): {[west, "HQ"] sideChat format ["%1 assigned as %2",name _target,_trait];};
				case (_hasTrait && !_value): {[west, "HQ"] sideChat format ["%1 unassigned from %2",name _target,_trait];};
			};
		};

		true;
	};
	case "nearbyLogic" : {
		_params params [["_logic",objNull,[objNull,""]]];
		if (_logic isEqualType "") then {
			_logic = _logic call BIS_fnc_objectFromNetId;
		};
		private _nearby = player distance2D _logic < 15;
		if !(_nearby) then {["deactivateActionLoadoutPoint"] call MPSF_fnc_virtualArmoury};
		_nearby
	};
// Loadout Role Point
	case "activateActionLoadoutPoint" : {
		_params params [["_trigger",objNull],["_list",[],[[]]]];

		if !(player in _list) exitWith {};

		private _logic = attachedTo _trigger;
		player setVariable ["ArmouryLogic",_logic];
		// Set Loadout Action
		private _preDefinedLoadout = _logic getVariable ["MPSF_VirtualArmoury_LoadoutPoint_Loadout",""];
		if (_preDefinedLoadout isEqualTo "") then {
			["MPSF_VirtualArmoury_LoadoutPoint_Action",player,"Access Virtual Armoury",[
				["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,{ ["openArsenal",[player]] call MPSF_fnc_virtualArmoury }
				,{}
				,0.5,false,101
			],[],
				"speed vehicle player isEqualTo 0"
				+ " && vehicle player isEqualTo player"
				+ format [" && ['nearbyLogic',[%1]] call MPSF_fnc_virtualArmoury",str (_logic call BIS_fnc_netId)]
			,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
		} else {
			["MPSF_VirtualArmoury_LoadoutPoint_Action",player,format["Assign %1 Loadout",_preDefinedLoadout],[
				["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
				,compile format ["['assignLoadout',[player,%1]] call MPSF_fnc_virtualArmoury;",str _preDefinedLoadout]
				,{}
				,0.5,false,101
			],[],
				"speed vehicle player isEqualTo 0"
				+ " && vehicle player isEqualTo player"
				+ format [" && ['nearbyLogic',[%1]] call MPSF_fnc_virtualArmoury",str (_logic call BIS_fnc_netId)]
			,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
		};
	};
	case "deactivateActionLoadoutPoint" : {
		["MPSF_VirtualArmoury_LoadoutPoint_Action",player] call MPSF_fnc_removeAction;
	};
	case "assignLoadout" : {
		_params params [["_target",player,[objNull]],["_roleID","",[""]]];
		if (["set",[_target,_roleID]] call MPSF_fnc_squadUnitRole) then {
			["openArsenal",[_target]] call MPSF_fnc_virtualArmoury
		};
	};
	case "openArsenal" : {
		_params params [["_target",player,[objNull]]];

		if (isNull _target) exitWith {
			["VirtualArmoury has No Vaild Target"] call BIS_fnc_error
		};

		private _roleID = ["get",[_target]] call MPSF_fnc_squadUnitRole;
		private _virtualArmouryBox = uiNamespace getVariable ["MPSF_VirtualArmoury_Ammobox",locationNull];
		if (isNull _virtualArmouryBox) exitWith { 
			["VirtualArmoury has no Vaild ammobox"] call BIS_fnc_error;
			["init"] call MPSF_fnc_virtualArmoury;
		};

		private _fullArsenal = (["getCfgFullArmoury"] call MPSF_fnc_virtualArmoury) || (["getCfgRoleFullLoadout",[_roleID]] call MPSF_fnc_getCfgRoles);

		if (count (_virtualArmouryBox getVariable [format["%1",_roleID],[]]) isEqualTo 0 && !_fullArsenal) exitWith {
			[format["No Role ID Exists that is assigned to %1",name _target]] call BIS_fnc_error;
		};

		["Open",[_fullArsenal,_virtualArmouryBox,_target]] call BIS_fnc_arsenal;

		true;
	};
// Configuration
	case "getArmouryLogics" : { (allMissionObjects "All") select { _x getVariable ["MPSF_VirtualArmoury_LoadoutPoint",false]; }; };
	case "getCfgAssignRoles" : { ["CfgVirtualArmoury","assignRoles"] call MPSF_fnc_getCfgDataNumber; };
	case "getCfgFullArmoury" : { ["CfgVirtualArmoury","enableFullArmoury"] call MPSF_fnc_getCfgDataBool; };
	case "getCfgVehicleAccess" : { ["CfgVirtualArmoury","enableVehicleAccess"] call MPSF_fnc_getCfgDataArray; };
	case "getCfgLoadout" : {
		_params params [["_roleID",typeOf player,[""]]];
		private _cfgLoadout = configNull;
		{
			if (isClass(_x >> _roleID)) exitWith {
				_cfgLoadout = (_x >> _roleID);
			};
		} forEach [
			//(missionConfigFile >> "CfgVirtualArmoury" >> "Roles"),
			(missionConfigFile >> "CfgRoles"),
			(missionConfigFile >> "CfgRespawnInventory"),
			(configFile >> "CfgVehicles")
		];
		_cfgLoadout
	};
	case "getCompatibleRoleWeapons" : {
		_params params [["_roleID","",[""]],["_weaponsList",[],[[]]]];

		if !(isNil format ["MPSF_ArmouryWeaponTypes_type%",_roleID]) exitWith {
			missionNamespace getVariable [format ["MPSF_ArmouryWeaponTypes_type%",_roleID],[[],[],[],[]]];
		};

		private _types = ["CfgVirtualArmoury",_roleID,"weaponTypes"] call MPSF_fnc_getCfgDataArray;
		private _list = [[],[],[],[],[]];
		private _itemFilter = [
			["AssaultRifle","Shotgun","Rifle","SubmachineGun","MachineGun","SniperRifle","Launcher","MissileLauncher","RocketLauncher","Handgun"],
			["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod","Uniform","Vest","Headgear","Glasses","Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal","Grenade"],
			["UnknownWeapon"],
			["Backpack"],
			["Magazines","Grenade"]
		];

		private _cfgWeapons = configfile >> "CfgWeapons";
		private _cfgMagazines = configfile >> "CfgMagazines";
		private _weaponsArray = "true" configClasses _cfgWeapons;
		private _magazinesArray = "true" configClasses _cfgMagazines;
		private _glassesArray = "true" configClasses (configFile >> "CfgGlasses");
		private _vehiclesArray = "true" configClasses (configFile >> "CfgVehicles");

		{
			private _weaponCfg = _x;
			private _weapon = toLower configName _weaponCfg;
			private _itemScope = if (isNumber (_x >> "scopeArsenal")) then { getNumber (_x >> "scopeArsenal") } else { getNumber (_x >> "scope") };
			(_weapon call bis_fnc_itemType) params ["_weaponTypeCategory", "_weaponTypeSpecific"];

			if (_weaponTypeSpecific in _types || count _types isEqualTo []) then {
				{ 
					if (_weaponTypeSpecific in _x || _x isEqualTo []) then { 
						if !(_weaponTypeCategory isEqualTo "VehicleWeapon") then {
							private _weaponPublic = _itemScope isEqualTo 2;
							private _listType = _list select _forEachIndex;
							if (_weaponPublic) then {
								_listType pushback _weapon;
							};

							//--- Add magazines compatible with the weapon
							if (_weaponPublic || _weapon in ["throw", "put"]) then {
								{
									private _muzzle = if (_x == "this") then { _weaponCfg } else { _weaponCfg >> _x };
									private _magazinesList = getArray (_muzzle >> "magazines");
									{ { _magazinesList append (getArray _x) } forEach configproperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"] } forEach getArray (_muzzle >> "magazineWell");

									{
										private _mag = toLower _x;
										if (_listType findIf { _x isEqualTo _mag } < 0) then {
											private _magCfg = configFile >> "CfgMagazines" >> _mag;
											if (getNumber (_magCfg >> "scope") isEqualTo 2) then {
												_list select 4 pushBackUnique _mag;
											};
										};
									} forEach _magazinesList;
								} forEach getArray (_weaponCfg >> "muzzles");
							};
						};
					};
				} forEach _itemFilter;
			} else {
				_list select 4 pushback _weapon;
			};
		} forEach _weaponsArray;

		//--- Magazines - Put and Throw
		{
			private _weapon  = _x;
			{
				{
					private _mag = toLower _x;
					private _cfgMag = _cfgMagazines >> _mag;
					if (getNumber (_cfgMag >> "scope") == 2 || getNumber (_cfgMag >> "scopeArsenal") == 2) then {
						_list select 4 pushBackUnique _mag;
					};
				} foreach getarray (_x >> "magazines");
			} foreach ("true" configClasses (_cfgWeapons >> _weapon));
		} foreach ["throw","put"];

		//--- Glasses
		{
			private _weaponCfg = _x;
			private _weapon = toLower configName _weaponCfg;
			if (getnumber (_weaponCfg >> "scope") == 2) then {
				_list select 1 pushback _weapon;
			};
		} forEach _glassesArray;

		//--- Backpacks
		{
			private _weaponCfg = _x;
			private _weapon = toLower configName _weaponCfg;
			_weapon call bis_fnc_itemType params ["", "_weaponTypeSpecific"];
			{
				if (_weaponTypeSpecific isEqualTo _x) exitWith {
					if (getnumber (_weaponCfg >> "scope") == 2) then {
						_list select 3 pushback _weapon;
					};
				};
			} forEach (_itemFilter select 3);
		} forEach _vehiclesArray;

		missionNamespace setVariable [format ["MPSF_ArmouryWeaponTypes_type%",_roleID],_list];
		//copyToClipboard ("List: " + str (_list apply {_x apply {[_x,_x call bis_fnc_itemType]}}));
		_list;
	};
// Init
	case "preInit";
	case "init": {
		private _virtualArmouryBox = uiNamespace getVariable ["MPSF_VirtualArmoury_Ammobox",locationNull];
		if (isNull _virtualArmouryBox) then {
			_virtualArmouryBox = [[0,0,0]] call MPSF_fnc_createLogic;// createLocation ["Invisible", [0,0,0], 0, 0];
			uiNamespace setVariable ["MPSF_VirtualArmoury_Ammobox",_virtualArmouryBox];
		};
		{
			_x params ["_roleID","_SideID","_DisplayName","_Icon","_Limit"];
			if (count (_virtualArmouryBox getVariable [format["%1",_roleID],[]]) isEqualTo 0) then {
				_virtualArmouryBox setVariable [format["%1",_roleID],
					["getCompatibleRoleWeapons",[_roleID]] call MPSF_fnc_virtualArmoury
				];
			};
		} forEach (["getCfgRoles",[-1,true]] call MPSF_fnc_getCfgRoles);
	};
	case "postInit" : {
		/* Respawn Loadout Event Handler */
		if (hasInterface) then {
			BIS_fnc_arsenal_fullArsenal = false;
			[] spawn {
				{
					[_x] call MPSF_fnc_createVirtualArmoury;
				} forEach (["getArmouryLogics"] call MPSF_fnc_virtualArmoury);
			};

			["MPSF_VirtualArmoury_onKilled_EH","onKilled",{
				[player,"VirtualInventoryKilled"] call MPSF_fnc_getUnitLoadout;
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_onKilled_EH","onRespawn",{
				[player,"VirtualInventoryKilled"] call MPSF_fnc_setUnitLoadout;
			}] call MPSF_fnc_addEventHandler;

			["MPSF_VirtualArmoury_onNewAmmoBox_EH","onNewAmmoBox",{
				_this call MPSF_fnc_createVirtualArmoury;
			}] call MPSF_fnc_addEventHandler;

			private _defaultRoleID = (["getCfgRoles",[playerSide]] call MPSF_fnc_getCfgRoles) param [0,"Rifle",[""]];
			["set",[player,_defaultRoleID,true]] call MPSF_fnc_squadUnitRole;
		};
		["init"] call MPSF_fnc_rscVirtualArmoury;
	};
};