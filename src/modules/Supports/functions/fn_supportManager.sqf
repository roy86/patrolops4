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
#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"
#define ICONNATO(natoIcon) ("\a3\ui_f\data\Map\Markers\NATO\" + natoIcon + ".paa")
#define GRIDSIZE 8
#define MISSIONTIME (if (isMultiplayer) then {serverTime} else {time})

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
/* Support Menu */
	case "onLoadSupportMenu" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayAmrelTabletMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayAmrelTabletSupport"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["setCrtlMenu",[
			["Issue orders for Artillery",{ ["switchControlGroup",["AmrelTabletSupportFiremission","RscDisplayAmrelTabletSupport",0]] call MPSF_fnc_itemAmrelTablet; }]
			,["Issue orders for an Airstrike",{ ["switchControlGroup",["AmrelTabletSupportCAS","RscDisplayAmrelTabletSupport",0]] call MPSF_fnc_itemAmrelTablet; }]
			,["Request Supply Drop",{ ["switchControlGroup",["AmrelTabletSupportSupplyDrop","RscDisplayAmrelTabletSupport",0]] call MPSF_fnc_itemAmrelTablet; }]
			,["No Menu",{ ["switchControlGroup",["","RscDisplayAmrelTabletSupport"]] call MPSF_fnc_itemAmrelTablet; }]
			,["No Menu",{ ["switchControlGroup",["","RscDisplayAmrelTabletSupport"]] call MPSF_fnc_itemAmrelTablet; }]
			,["View Map",{ ["switchControlGroup",["","RscDisplayAmrelTabletSupport"]] call MPSF_fnc_itemAmrelTablet; }]
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc1","F1: Artillery"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc2","F2: Airstrike"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc3","F3: Supply Drop"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4: UAV"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc5","F5:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc6","F6: MAP"]] call MPSF_fnc_itemAmrelTablet;
		
		if !(isNull laserTarget player) then {
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportTargetPos",(laserTarget player) call BIS_fnc_position];
		};

		["supportUpdateGridEdit",[0,0]] call MPSF_fnc_supportManager;
		["supportUpdateInfoPanes"] call MPSF_fnc_supportManager;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionGridXSubButton","MouseButtonClick",{
			["supportUpdateGridEdit",[-1,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionGridXEdit","KeyUp",{
			["supportUpdateGridEdit",[0,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionGridXAddButton","MouseButtonClick",{
			["supportUpdateGridEdit",[1,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionGridYSubButton","MouseButtonClick",{
			["supportUpdateGridEdit",[0,-1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionGridYEdit","KeyUp",{
			["supportUpdateGridEdit",[0,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionGridYAddButton","MouseButtonClick",{
			["supportUpdateGridEdit",[0,1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionSalvoSubButton","MouseButtonClick",{
			["supportUpdateBatterySalvoEdit",[-1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionSalvoEdit","KeyUp",{
			["supportUpdateBatterySalvoEdit",[0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionSalvoAddButton","MouseButtonClick",{
			["supportUpdateBatterySalvoEdit",[1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionDelaySubButton","MouseButtonClick",{
			["supportUpdateBatteryDelayEdit",[-1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionDelayEdit","KeyUp",{
			["supportUpdateBatteryDelayEdit",[0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionDelayAddButton","MouseButtonClick",{
			["supportUpdateBatteryDelayEdit",[1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportCASGridXSubButton","MouseButtonClick",{
			["supportUpdateGridEdit",[-1,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportCASGridXEdit","KeyUp",{
			["supportUpdateGridEdit",[0,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportCASGridXAddButton","MouseButtonClick",{
			["supportUpdateGridEdit",[1,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportCASGridYSubButton","MouseButtonClick",{
			["supportUpdateGridEdit",[0,-1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportCASGridYEdit","KeyUp",{
			["supportUpdateGridEdit",[0,0]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSupportCASGridYAddButton","MouseButtonClick",{
			["supportUpdateGridEdit",[0,1]] call MPSF_fnc_supportManager;
			["supportUpdateInfoPanes",[]] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["AmrelTabletSupportSupplyDropAmmo","MouseButtonClick",{
			if !([player] call MPSF_fnc_isAdmin || leader group player isEqualTo player) exitWith {};
			private _display = uiNamespace getVariable ["RscDisplayAmrelTabletActive",(displayNull)];
			_display closeDisplay 1;
			["onStartSupplyDropRequest",[],true] call MPSF_fnc_triggerEventhandler;
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["AmrelTabletSupportSupplyDropVehicle","KeyUp",{
			if !([player] call MPSF_fnc_isAdmin || leader group player isEqualTo player) exitWith {};
		}]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["AmrelTabletSupportSupplyDropUAV","MouseButtonClick",{
			if !([player] call MPSF_fnc_isAdmin || leader group player isEqualTo player) exitWith {};
			private _display = uiNamespace getVariable ["RscDisplayAmrelTabletActive",(displayNull)];
			_display closeDisplay 1;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionCommitButton","MouseButtonClick",{
			if (["canUseSupport",[player,["admin","jtac"]]] call MPSF_fnc_supportManager) then {
				["supportExecuteBatteryFiremission"] call MPSF_fnc_supportManager;
			} else {
				["You cannot request support as you are not the mission administrator"] call BIS_fnc_error;
			};
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSupportCASCommitButton","MouseButtonClick",{
			if (["canUseSupport",[player,["admin","jtac"]]] call MPSF_fnc_supportManager) then {
				["supportExecuteCASStrike"] call MPSF_fnc_supportManager;
			} else {
				["You cannot request support as you are not the mission administrator"] call BIS_fnc_error;
			};
		}]] call MPSF_fnc_itemAmrelTablet;

		if !(["canUseSupport",[player,["admin","jtac"]]] call MPSF_fnc_supportManager) then {
			["setCtrlText",["RscControlAmrelTabletSupportFiremissionCommitButton","Contact Command for Request"]] call MPSF_fnc_itemAmrelTablet;
			["setCtrlEnable",["RscControlAmrelTabletSupportFiremissionCommitButton",false]] call MPSF_fnc_itemAmrelTablet;

			["setCtrlText",["RscControlAmrelTabletSupportCASCommitButton","Contact Command for Request"]] call MPSF_fnc_itemAmrelTablet;
			["setCtrlEnable",["RscControlAmrelTabletSupportCASCommitButton",false]] call MPSF_fnc_itemAmrelTablet;
		};

		["supportUpdateBatteryList"] call MPSF_fnc_supportManager;
		["supportUpdateBatterySpreadList"] call MPSF_fnc_supportManager;
		["supportUpdateBatterySalvoEdit",[0]] call MPSF_fnc_supportManager;
		["supportUpdateBatteryDelayEdit",[0]] call MPSF_fnc_supportManager;

		["supportUpdateCASList"] call MPSF_fnc_supportManager;
		["supportUpdateCASOrdnanceList"] call MPSF_fnc_supportManager;
		["supportUpdateCASIngressList"] call MPSF_fnc_supportManager;

		["switchControlGroup",["","RscDisplayAmrelTabletSupport"]] call MPSF_fnc_itemAmrelTablet;

		//["AmrelTabletSupportMap",true] call MPSF_fnc_mapDrawSquadMarkers;
		["setForceTrackMapDraw",["AmrelTabletSupportMap"]] call (missionNamespace getVariable ["MPSF_fnc_forcetracker",{}]);

		true
	};
	case "canUseSupport" : {
		_params params [["_target",objNull,[objNull]],["_checks",[],[[],""]]];

		if (isNull _target) exitWith {};
		if !(_checks isEqualType []) then {_checks = [_checks]};

		private _return = false;

		{
			switch (_x) do {
				case "admin" : {_return = [_target] call MPSF_fnc_isAdmin};
				case "jtac" : {_return = [_target,"JTAC",false] call MPSF_fnc_getUnitTrait};
			};
			if (_return) exitWith {_return};
		} forEach _checks;

		_return;
	};
	case "getSupportUnits" : {
		_params params [["_side",sideUnknown,[sideUnknown]],["_types",[],[[]]]];

		private _supports = [];
		{
			if (_side isEqualTo side _x) then {
				private _group = _x;
				private _leader = leader _x;
				if !(vehicle _leader isEqualTo _leader) then {
					private _vehicle = vehicle _leader;
					private _supportTypes = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "availableForSupportTypes");
					if (count _supportTypes > 0) then {
						if (count _types isEqualTo 0 || count (_supportTypes arrayIntersect _types) > 0) then {
							private _vehicles = [];
							{
								if (typeOf vehicle _x isKindOf typeOf _vehicle) then {_vehicles pushBackUnique vehicle _x};
							} forEach (units _group);
							_supports pushBackUnique [_group,_leader,typeOf _vehicle,count _vehicles,-1];
						};
					};
				};
			};
		} forEach allGroups;

		private _cfgSupports = "isclass _x && {getnumber (_x >> 'scope') == 2}" configclasses (missionConfigFile >> "CfgMissionSupports" >> "AvailableSupports");
		{
			private _supportTypes = getArray (_x >> "availableForSupportTypes");
			if (count _types isEqualTo 0 || count (_supportTypes arrayIntersect _types) > 0) then {
				private _timing = 15;
				if (isText(_x >> "delay")) then {
					_timing = (call compile format["private _dist = player distance2D [0,0]; %1",getText(_x >> "delay")]) max _timing;
				};
				_supports pushBackUnique [grpNull,getText(_x >> "displayName"),getText(_x >> "classname"),getNumber(_x >> "size"),_timing];
			};
		} forEach _cfgSupports;

		_supports;
	};
	case "supportUpdateTargetPos" : {
		_params params [["_gridPos","",[""]]];
		private _position = [_gridPos] call MPSF_fnc_getPosGrid;
		missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportTargetPos",_position];
		_position;
	};
	case "supportUpdateGridEdit" : {
		_params params [["_gridXAdd",0,[0]],["_gridYAdd",0,[0]]];

		private _gridPartSize = GRIDSIZE/2;
		private _targetPos = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportTargetPos",getPos player];

		private _ctrlGridX = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionGridXEdit",controlNull];
		private _ctrlGridY = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionGridYEdit",controlNull];
		
		private _gridX = ctrlText _ctrlGridX;
		private _gridY = ctrlText _ctrlGridY;

		_gridX = str (if (_gridX isEqualTo "") then {
			_targetGridPos = [_targetPos,GRIDSIZE] call MPSF_fnc_getGridPos;
			parseNumber ([_targetGridPos, 0,_gridPartSize-1] call BIS_fnc_trimString);
		} else { (parseNumber _gridX) + _gridXAdd });
		_gridY = str (if (_gridY isEqualTo "") then {
			_targetGridPos = [_targetPos,GRIDSIZE] call MPSF_fnc_getGridPos;
			parseNumber ([_targetGridPos,_gridPartSize,_gridPartSize+_gridPartSize-1] call BIS_fnc_trimString);
		} else { (parseNumber _gridY) + _gridYAdd });

		_gridX = switch (true) do {
			case (count _gridX == 1) : { "000" + _gridX};
			case (count _gridX == 2) : { "00" + _gridX};
			case (count _gridX == 3) : { "0" + _gridX};
			default {[_gridX,0,3] call BIS_fnc_trimString};
		};

		_gridY = switch (true) do {
			case (count _gridY == 1) : { "000" + _gridY};
			case (count _gridY == 2) : { "00" + _gridY};
			case (count _gridY == 3) : { "0" + _gridY};
			default {[_gridY,0,3] call BIS_fnc_trimString};
		};

		(uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionGridXEdit",controlNull]) ctrlSetText _gridX;
		(uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionGridYEdit",controlNull]) ctrlSetText _gridY;

		(uiNamespace getVariable ["RscControlAmrelTabletSupportCASGridXEdit",controlNull]) ctrlSetText _gridX;
		(uiNamespace getVariable ["RscControlAmrelTabletSupportCASGridYEdit",controlNull]) ctrlSetText _gridY;

		["supportUpdateTargetPos",[(_gridX) + (_gridY)]] call MPSF_fnc_supportManager;

		(_gridX) + (_gridY)
	};
	case "supportUpdateInfoPanes" : {
		private _gridPos = [getPos player,8] call MPSF_fnc_getGridPos;
		private _ctrlMap = uiNamespace getVariable "AmrelTabletSupportMap";

		private _playerPosData = [
			"JTAC:\nLongitude:\nLatitude:\nAltitude:\nAzimuth:",
			format ["%1\n%2\n%3\n%4m\n%5",
				name player,
				[_gridPos, 0, 3] call BIS_fnc_trimString,
				[_gridPos, 4, 7] call BIS_fnc_trimString,
				round ((getPosASL player) select 2),
				round (direction player)
			]
		];

		private _targetPos = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportTargetPos",[0,0,0]];
		private _gridPosX = "-";
		private _gridPosY = "-";
		private _gridASL = "-";
		private _gridDist = "-";
		if !(_targetPos isEqualTo [0,0,0]) then {
			_targetGridPos = [_targetPos,GRIDSIZE] call MPSF_fnc_getGridPos;
			_gridPosX = [_targetGridPos, 0, 3] call BIS_fnc_trimString;
			_gridPosY = [_targetGridPos, 4, 7] call BIS_fnc_trimString;
			_gridASL = round ((getPosASL player) select 2);
			_gridDist = round (player distance2D _targetPos);
			
			_ctrlMap ctrlMapAnimAdd [0,0.04,_targetPos];
			ctrlMapAnimCommit _ctrlMap;
		} else {
			_ctrlMap ctrlMapAnimAdd [0,0.04,player];
			ctrlMapAnimCommit _ctrlMap;
		};

		private _lasedTarget = "";
		private _ctrlLaser = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionCrossLaserIcon",controlNull];
		_ctrlLaser ctrlSetFade 1;
		_ctrlLaser ctrlEnable false;
		_ctrlLaser ctrlCommit 0;
		{
			private _laserTarget = laserTarget _x;
			if (_laserTarget distance2D _targetPos < 150) exitWith {
				_lasedTarget = "Laser";
				_ctrlLaser ctrlSetFade 0;
				_ctrlLaser ctrlEnable true;
				_ctrlLaser ctrlSetTooltip name _x;
				_ctrlLaser ctrlCommit 0;
			};
		} forEach ((playableUnits + switchableUnits) select {side _x isEqualTo side player});

		private _targetPosData = [
			"Target\nLongitude:\nLatitude:\nAltitude:\nDistance:",
			format ["%1\n%2\n%3\n%4m\n%5m",
				if (_lasedTarget isEqualTo "") then { format ["GRD %1",mapGridPosition _targetPos] } else { _lasedTarget },
				_gridPosX,
				_gridPosY,
				_gridASL,
				_gridDist
			]
		];

		["setCtrlText",["RscControlAmrelTabletSupportFiremissionPlayerPos1",_playerPosData select 0,""]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletSupportFiremissionPlayerPos2",_playerPosData select 1,""]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletSupportFiremissionTargetPos1",_targetPosData select 0,""]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletSupportFiremissionTargetPos2",_targetPosData select 1,""]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletSupportCASPlayerPos1",_playerPosData select 0,""]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletSupportCASPlayerPos2",_playerPosData select 1,""]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletSupportCASTargetPos1",_targetPosData select 0,""]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletSupportCASTargetPos2",_targetPosData select 1,""]] call MPSF_fnc_itemAmrelTablet;

	};
	case "supportUpdateBatteryList" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionBatteryCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionBatteryCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_group","_leader","_vehicle","_vehicles","_timing"];
			_cfgx = (configFile >> "CfgVehicles" >> _vehicle);
			private _timingText = format ["%1",if (_timing >0) then {format[" Strike in: %1 mins",str ceil (_timing/60)]} else {""}];
			if (_group isEqualTo grpNull) then {
				_ctrl lbAdd format["%1 (%2)",_leader,_vehicles];
				_ctrl lbSetPicture [_foreachindex,gettext (_cfgx >> "picture")];
				_ctrl lbSetTooltip [_foreachindex,format["%2x %1%3",getText (_cfgx >> "displayName"),_vehicles,_timingText]];
				_ctrl lbSetData [_foreachindex,str ["",_leader,_vehicle,_vehicles,_timing]];
			} else {
				_ctrl lbAdd format["%1 (%2)",getText (_cfgx >> "displayName"),_vehicles];
				_ctrl lbSetPicture [_foreachindex,gettext (_cfgx >> "picture")];
				_ctrl lbSetTooltip [_foreachindex,format["%2x %1%3",getText (_cfgx >> "displayName"),_vehicles,_timingText]];
				_ctrl lbSetData [_foreachindex,str [_group call BIS_fnc_netId,_leader call BIS_fnc_netId,_vehicle,_vehicles,-1]];
			};
		} forEach (["getSupportUnits",[playerSide,["Artillery"]]] call MPSF_fnc_supportManager);

		_ctrl lbAdd "Select Support";
		_ctrl lbSetCurSel lbSize _ctrl;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionBatteryCombo","LBSelChanged",{
			['supportUpdateBatteryOrdnanceList',_this] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "supportUpdateBatteryOrdnanceList" : {
		_params params [["_ctrlList",controlNull,[controlNull]]];

		private _cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};

		private _lbData = call compile (_ctrlList lbData _cursel);
		missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportGroupData",_lbData];
		_lbData params ["_groupID","_leaderID","_vehicle","_vehicles"];

		private _magazines = [];
		{
			_magazines pushBackUnique _x
		} forEach (getArray(configfile >> "CfgVehicles" >> _vehicle >> "Turrets" >> "MainTurret" >> "magazines"));
		if !(_groupID isEqualTo "") then {
			private _units = units (_groupID call BIS_fnc_groupFromNetId);
			{
				_magazines pushBackUnique _x
			} forEach (getArtilleryAmmo (_units apply {vehicle _x}));
		};

		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionAmmoTypeCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionAmmoTypeCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			private _cfgMag = configFile >> "CfgMagazines" >> _x;
			private _cfgAmmo = configFile >> "CfgAmmo" >> getText(_cfgMag >> "ammo");
			_ctrl lbAdd getText (_cfgMag >> "displayName");
			_ctrl lbSetTooltip [_foreachindex,configName _cfgAmmo];
			_ctrl lbSetData [_foreachindex,configName _cfgMag];
		} forEach _magazines;

		_ctrl lbAdd "Select Ordnance";
		_ctrl lbSetCurSel lbSize _ctrl;

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionAmmoTypeCombo","LBSelChanged",{
			params [["_ctrlList",controlNull,[controlNull]]];
			private _cursel = lbcursel _ctrlList;
			private _lbData = _ctrlList lbData (_cursel max 0);
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportOrdnanceType",_lbData];
			["supportUpdateInfoPanes"] call MPSF_fnc_supportManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "supportUpdateBatterySpreadList" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionSpreadCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionSpreadCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_spreadName","_spreadValue"];
			_ctrl lbAdd _spreadName;
			_ctrl lbSetTooltip [_foreachindex,format ["%1 (%2m)",_spreadName,_spreadValue]];
			_ctrl lbSetData [_foreachindex,str _spreadValue];
		} forEach [
			["Precise",5],
			["Tight",50],
			["Wide",100]
		];
		_ctrl lbSetCurSel (missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportArtilleryPrecisionID",0]);

		["setCtrlAction",["RscControlAmrelTabletSupportFiremissionSpreadCombo","LBSelChanged",{
			params ["_ctrlList","_index"];
			private _lbData = _ctrlList lbData _index;
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportArtilleryPrecisionID",_index];
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportArtilleryPrecision",parseNumber _lbData];
		}]] call MPSF_fnc_itemAmrelTablet;

		_ctrl lbSetCurSel 0;

		true;
	};
	case "supportUpdateBatterySalvoEdit" : {
		_params params [["_addSalvo",0,[0]]];

		private _ctrlSalvo = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionSalvoEdit",controlNull];
		private _SalvoVol = parseNumber ctrlText _ctrlSalvo;
		if (_SalvoVol isEqualTo 0) then {
			_SalvoVol = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportArtillerySalvoVol",1];
		};
		_SalvoVol = _SalvoVol + _addSalvo;
		_ctrlSalvo ctrlSetText str _SalvoVol;
		missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportArtillerySalvoVol",_SalvoVol];
		_SalvoVol
	};
	case "supportUpdateBatteryDelayEdit" : {
		_params params [["_addDelay",0,[0]]];

		private _ctrlDelay = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionDelayEdit",controlNull];
		private _delayVol = parseNumber ctrlText _ctrlDelay;
		if (_delayVol isEqualTo 0) then {
			_delayVol = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportArtilleryDelayVol",10];
		};
		_delayVol = (_delayVol + _addDelay) max 5;
		_ctrlDelay ctrlSetText str _delayVol;
		missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportArtilleryDelayVol",_delayVol];
		_delayVol
	};
	case "supportExecuteBatteryFiremission" : {
		if !(["canUseSupport",[player,["admin","jtac"]]] call MPSF_fnc_supportManager) exitWith {};

		private _groupData = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportGroupData",[]];
		if (_groupData isEqualTo []) exitWith {};

		_groupData params ["_groupID","_leaderID","_vehicle","_vehicles","_timing"];
		if !(_groupID isEqualTo "") then {
			_groupID = _groupID call BIS_fnc_groupFromNetId;
		} else {
			_groupID = _vehicles;
		};

		private _targetPos = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportTargetPos",[]];
		if (_targetPos isEqualTo []) exitWith {};

		private _ctrlOrdnance = uiNamespace getVariable ["RscControlAmrelTabletSupportFiremissionAmmoTypeCombo",controlNull];
		private _curselOrdnance = lbcursel _ctrlOrdnance;
		if (_curselOrdnance < 0) exitwith {};

		private _ordnance = _ctrlOrdnance lbData _curselOrdnance;
		if (_ordnance isEqualTo "") exitwith {};

		private _radius = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportArtilleryPrecision",10];
		private _rounds = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportArtillerySalvoVol",1];
		private _delay = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportArtilleryDelayVol",10];

		private _lasedTargets = [_targetPos] call MPSF_fnc_getNearLaserTargets;

		["onRequestFiremission",[
			player,
			[_groupID,_targetPos,_ordnance,_radius,_rounds,_delay,_timing,{false}],
			_lasedTargets
		],0] call MPSF_fnc_triggerEventhandler;
	};
	case "supportUpdateCASList" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSupportCASListCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletSupportCASListCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_group","_leader","_vehicle","_vehicles"];
			private _cfgx = (configFile >> "CfgVehicles" >> _vehicle);
			private _supportTypes = getArray (_cfgx >> "availableForSupportTypes");
			if (_group isEqualTo grpNull) then {
				_ctrl lbAdd format["%1 (%2)",_leader,_vehicles];
				_ctrl lbSetPicture [_foreachindex,gettext (_cfgx >> "picture")];
				_ctrl lbSetTooltip [_foreachindex,format["%1 (%2)",getText (_cfgx >> "displayName"),_vehicles]];
				_ctrl lbSetData [_foreachindex,str ["",_leader,_vehicle,_vehicles,_supportTypes]];
			} else {
				_ctrl lbAdd format["%1 (%2)",getText (_cfgx >> "displayName"),_vehicles];
				_ctrl lbSetPicture [_foreachindex,gettext (_cfgx >> "picture")];
				_ctrl lbSetTooltip [_foreachindex,format["%1 (%2)",getText (_cfgx >> "displayName"),_vehicles]];
				_ctrl lbSetData [_foreachindex,str [_group call BIS_fnc_netId,_leader call BIS_fnc_netId,_vehicle,_vehicles,_supportTypes]];
			};
		} forEach (["getSupportUnits",[playerSide,["CAS_Bombing","CAS_Heli"]]] call MPSF_fnc_supportManager);

		_ctrl lbAdd "Select Support";
		_ctrl lbSetCurSel lbSize _ctrl;

		true;
	};
	case "supportUpdateCASOrdnanceList" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSupportCASAmmoTypeCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletSupportCASAmmoTypeCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_spreadName","_spreadValue"];
			_ctrl lbAdd _spreadName;
			_ctrl lbSetTooltip [_foreachindex,format ["%1",_spreadName,_spreadValue]];
			_ctrl lbSetData [_foreachindex,str _spreadValue];
		} forEach [
			["Precision Strike (Laser)",0],
			["Missile Strikes (Lasers)",1],
			["Bombing Run (Suppression)",2],
			["Gun Run (Suppression)",3]
		];
		_ctrl lbSetCurSel (missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportCASOrdnanceID",0]);

		["setCtrlAction",["RscControlAmrelTabletSupportCASAmmoTypeCombo","LBSelChanged",{
			params ["_ctrlList","_index"];
			private _lbData = _ctrlList lbData _index;
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportCASOrdnanceID",_index];
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportCASOrdnance",parseNumber _lbData];
		}]] call MPSF_fnc_itemAmrelTablet;

		_ctrl lbSetCurSel 0;

		true;
	};
	case "supportUpdateCASIngressList" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSupportCASIngressCombo",controlNull];
		["setCtrlAction",["RscControlAmrelTabletSupportCASIngressCombo","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_spreadLetter","_spreadName","_spreadValue"];
			_ctrl lbAdd _spreadName;
			_ctrl lbSetPicture [_foreachindex,format["\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\%1_ca.paa",_spreadLetter]];
			//_ctrl lbSetTextRight [_foreachindex,_spreadName];
			//_ctrl lbSetPictureRight [_foreachindex,format["\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\%1_ca.paa",_spreadLetter]];
			_ctrl lbSetTooltip [_foreachindex,format ["%1 (%2)",_spreadName,_spreadValue]];
			_ctrl lbSetData [_foreachindex,str _spreadValue];
		} forEach [
			["n","North",0],
			["n","North East",45],
			["e","East",90],
			["e","South East",135],
			["s","South",180],
			["s","South West",225],
			["w","West",270],
			["w","North West",315]
		];
		_ctrl lbSetCurSel (missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportCASIngressID",0]);

		["setCtrlAction",["RscControlAmrelTabletSupportCASIngressCombo","LBSelChanged",{
			params ["_ctrlList","_index"];
			private _lbData = _ctrlList lbData _index;
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportCASIngressID",_index];
			missionNamespace setVariable ["MPSF_itemAmrelTablet_var_supportCASIngress",parseNumber _lbData];
		}]] call MPSF_fnc_itemAmrelTablet;

		_ctrl lbSetCurSel 0;

		true;
	};
	case "supportExecuteCASStrike" : {
		if !(["canUseSupport",[player,["admin","jtac"]]] call MPSF_fnc_supportManager) exitWith {};

		private _ctrlList = uiNamespace getVariable ["RscControlAmrelTabletSupportCASListCombo",controlNull];
		private _cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};

		private _groupData = call compile (_ctrlList lbData _cursel);
		if (_groupData isEqualTo []) exitWith {};

		_groupData params ["_groupID","_leaderID","_vehicle","_vehicles","_supportTypes","_timing"];
		if !(_groupID isEqualTo "") then {
			_groupID = _groupID call BIS_fnc_groupFromNetId;
		} else {
			_groupID = _vehicles;
		};

		private _ordnance = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportCASOrdnance",0];
		private _ingressDir = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportCASIngress",0];

		private _targetPos = missionNamespace getVariable ["MPSF_itemAmrelTablet_var_supportTargetPos",[]];
		if (_targetPos isEqualTo []) exitWith {};

		private _lasedTargets = [_targetPos] call MPSF_fnc_getNearLaserTargets;

		["onRequestCASStrike",[
			player,
			[_groupID,_targetPos,_vehicle,_ordnance,_ingressDir,_supportTypes,_timing,{false}],
			_lasedTargets
		],0] call MPSF_fnc_triggerEventhandler;
	};
/* Init */
	case "postInit" : {
        if (isServer) then {
            ["MPSF_Server_onRequestFiremission_EH","onRequestFiremission",{_this spawn {
				params [
					["_requestor",objNull,[objNull]],
					["_requestData",[],[[]]],
					["_lasedTargets",[],[[]]]
				];

				if !(["canUseSupport",[_requestor,["admin","jtac"]]] call MPSF_fnc_supportManager) exitWith {};

				_requestData params [
					["_battery",objNull,[objNull,grpNull,0]],
					["_targetPos",objNull,[objNull,[],""]],
					["_ordnance","",[""]],
					["_radius",50,[999]],
					["_rounds",10,[999]],
					["_delay",10,[999,[]]],
					["_splash",-1,[0]],
					["_condition",{false},[{}]]
				];

				["onRequestFiremissionComms",[_requestor,0],_requestor] call MPSF_fnc_triggerEventHandler;
				sleep 6;

				["onRequestFiremissionComms",[_requestor,1],_requestor] call MPSF_fnc_triggerEventHandler;
				if !(["missionDebugMode"] call MPSF_fnc_getCfgDataBool) then {
					sleep (_splash max 10);
				};
				["onRequestFiremissionComms",[_requestor,102],_requestor] call MPSF_fnc_triggerEventHandler;
				sleep 5;

				_lasedTargets = _lasedTargets select {!isNull _x};
				if (count _lasedTargets isEqualTo 0) then {
					_lasedTargets = [_targetPos] call MPSF_fnc_getNearLaserTargets;
				};

				private _lasedTarget = _lasedTargets param [0,objNull,[objNull]];
				if !(isNull _lasedTarget) then {
					_targetPos = _lasedTarget;
				};

				if (_battery isEqualType 0) then {
					for "_i" from 1 to _battery do {
						private _ordnance = getText(configfile >> "CfgMagazines" >> _ordnance >> "ammo");
						[_targetPos,_ordnance,_radius,_rounds,_delay,_condition] spawn MPSF_fnc_fireSupportVirtual;
					};
				} else {
					{
						[vehicle _x,_targetPos,_ordnance,_radius,_rounds,_delay,_condition] spawn MPSF_fnc_fireSupport;
					} forEach (units _battery);
				};

				["onRequestFiremissionComms",[_requestor,2],_requestor] call MPSF_fnc_triggerEventHandler;
			};}] call MPSF_fnc_addEventhandler;

			["MPSF_Server_onRequestCASStrike_EH","onRequestCASStrike",{_this spawn {
				params [
					["_requestor",objNull,[objNull]],
					["_requestData",[],[[]]],
					["_lasedTargets",[],[[]]]
				];

				if !(["canUseSupport",[_requestor,["admin","jtac"]]] call MPSF_fnc_supportManager) exitWith {};

				_requestData params [
					["_casGroup",objNull,[objNull,grpNull,0]],
					["_targetPos",objNull,[objNull,[],""]],
					["_vehicleClass","",[""]],
					["_ordnance",0,[0]],
					["_ingressDir",0,[0]],
					["_supportTypes",[],[[]]],
					["_splash",-1,[0]],
					["_condition",{false},[{}]]
				];

				private _supportComms = switch (true) do {
					case ("CAS_Bombing" in _supportTypes): {[5,6,7,8]};
					case ("CAS_Heli" in _supportTypes): {[9,10,11,12]};
					default {[5,6,7,8]};
				};

				["onRequestFiremissionComms",[_requestor,_supportComms select 0],_requestor] call MPSF_fnc_triggerEventHandler;
				sleep 6;
				["onRequestFiremissionComms",[_requestor,_supportComms select 1],_requestor] call MPSF_fnc_triggerEventHandler;

				if !(["missionDebugMode"] call MPSF_fnc_getCfgDataBool) then {
					sleep (_splash max 10);
				} else {
					sleep 5;
				};

				_lasedTargets = _lasedTargets select {!isNull _x};
				if (count _lasedTargets isEqualTo 0) then {
					_lasedTargets = [_targetPos] call MPSF_fnc_getNearLaserTargets;
				};

				private _lasedTarget = _lasedTargets param [0,objNull,[objNull]];
				if !(isNull _lasedTarget) then {
					_targetPos = _lasedTarget;
				};

				switch (true) do {
					case ("CAS_Bombing" in _supportTypes): {
						[_vehicleClass,_targetPos,_ordnance,_ingressDir,_supportTypes,_condition] call MPSF_fnc_casSupport;
					};
					case ("CAS_Heli" in _supportTypes): {
						//
					};
				};

				["onRequestFiremissionComms",[_requestor,_supportComms select 3],_requestor] call MPSF_fnc_triggerEventHandler;
			};}] call MPSF_fnc_addEventhandler;
        };
        if (hasInterface) then {
			["MPSF_Client_onRequestFiremission_EH","onRequestFiremissionComms",{
				params ["_player","_sequenceID"];

				if !(side player isEqualTo side _player) exitWith {};

				switch (_sequenceID) do {
					case 0:{ playSound3D ["A3\dubbing_f\modules\supports\artillery_request.ogg",player]; };
					case 1:{ playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg",player]; };
					case 2:{ playSound3D ["A3\dubbing_f\modules\supports\artillery_rounds_complete.ogg",player]; };
					case 3:{ playSound3D ["A3\dubbing_f\modules\supports\artillery_destroyed.ogg",player]; };
					case 4:{ playSound3D ["A3\dubbing_f\modules\supports\artillery_accomplished.ogg",player]; };

					case 5:{ playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_request.ogg",player]; };
					case 6:{ playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_acknowledged.ogg",player]; };
					case 7:{ playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_destroyed.ogg",player]; };
					case 8:{ playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_accomplished.ogg",player]; };

					case 9:{  playSound3D ["A3\dubbing_f\modules\supports\cas_heli_request.ogg",player]; };
					case 10:{ playSound3D ["A3\dubbing_f\modules\supports\cas_heli_acknowledged.ogg",player]; };
					case 11:{ playSound3D ["A3\dubbing_f\modules\supports\cas_heli_destroyed.ogg",player]; };
					case 12:{ playSound3D ["A3\dubbing_f\modules\supports\cas_heli_accomplished.ogg",player]; };

					case 13:{ playSound ["A3\dubbing_f\modules\supports\drop_request.ogg",player]; };
					case 14:{ playSound ["A3\dubbing_f\modules\supports\drop_acknowledged.ogg",player]; };
					case 15:{ playSound ["A3\dubbing_f\modules\supports\drop_destroyed.ogg",player]; };
					case 16:{ playSound ["A3\dubbing_f\modules\supports\drop_accomplished.ogg",player]; };

					case 17:{ playSound3D ["A3\dubbing_f\modules\supports\uav_request.ogg",player]; };
					case 18:{ playSound3D ["A3\dubbing_f\modules\supports\uav_acknowledged.ogg",player]; };
					case 19:{ playSound3D ["A3\dubbing_f\modules\supports\uav_destroyed.ogg",player]; };
					case 20:{ playSound3D ["A3\dubbing_f\modules\supports\uav_accomplished.ogg",player]; };

					case 102 : {
						// Artillery Inbound
						["45_Artillery","GroundSupport",[selectRandom ["mp_groundsupport_45_artillery_BHQ_0","mp_groundsupport_45_artillery_BHQ_1","mp_groundsupport_45_artillery_BHQ_2"],true], "SIDE", nil,true, 1, true] spawn {sleep 2; _this call BIS_fnc_kbTell};
					};
					case 201 : {
						// CAS Inbound
						["01_CasRequested","GroundSupport",[selectRandom ["mp_groundsupport_01_casrequested_BHQ_0","mp_groundsupport_01_casrequested_BHQ_1","mp_groundsupport_01_casrequested_BHQ_2"],true], "SIDE", nil,true, 1, true] spawn {sleep 2; _this call BIS_fnc_kbTell};
					};
					case 202 : {
						// CAS Inbound
						["50_Cas","GroundSupport",[selectRandom ["mp_groundsupport_50_cas_BHQ_0","mp_groundsupport_50_cas_BHQ_1","mp_groundsupport_50_cas_BHQ_2"],true], "SIDE", nil,true, 1, true] spawn {sleep 2; _this call BIS_fnc_kbTell};
					};
					case 502 : {
						// CAS Inbound
						["60_Uav","GroundSupport",[selectRandom ["mp_groundsupport_60_uav_BHQ_0","mp_groundsupport_60_uav_BHQ_1","mp_groundsupport_60_uav_BHQ_2"],true], "SIDE", nil,true, 1, true] spawn {sleep 2; _this call BIS_fnc_kbTell};
					};
				};
			}] call MPSF_fnc_addEventhandler;
			
			// MPSF AMREL PDA
			if !(["MPSF_openAmrelPDA",player] call MPSF_fnc_hasAction) then {
				/* ["MPSF_openAmrelPDA",player,"<t color='#ffC600'>Amrel PDA</t>",{
					private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelPDA";
				},[],"vehicle player isEqualTo player",true,false,0] spawn {sleep 0.2; _this call MPSF_fnc_addAction}; */
			};

			// MPSF AMREL TABLET
			if !(["MPSF_openAmrelTablet",player] call MPSF_fnc_hasAction) then {
			//	["MPSF_openAmrelTablet",player,"<t color='#ffC600'>Amrel Tablet</t>",{
			//		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelTabletSupport";
			//	},[],"alive player",true,false,0] spawn { sleep 0.5; _this call MPSF_fnc_addAction };
			};
		};
		["init"] call MPSF_fnc_supportAirdrop;
    };
};