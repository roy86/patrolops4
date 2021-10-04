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

disableSerialization;

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "onLoadSquadMenu" : {
		_params params [["_display",displayNull]];
		uiNamespace setVariable ["RscDisplayAmrelTabletMenu",(_display)];
		uiNamespace setVariable ["RscDisplayAmrelTabletActive",(_display)];
		[_display,"RscDisplayAmrelTabletSquad"] call MPSF_fnc_loadCfgDisplayVariables;
		["setCtrlAction",["RscControlBackground","MouseMoving",{['onMove',_this] call MPSF_fnc_itemAmrelTablet;}]] call MPSF_fnc_itemAmrelTablet;

		["setCrtlMenu",[
			["Squads",{["switchControlGroup",["AmrelTabletSquadGroupView","RscDisplayAmrelTabletSquad",0]] call MPSF_fnc_itemAmrelTablet;}]
			,["Team",{["switchControlGroup",["AmrelTabletSquadManageView","RscDisplayAmrelTabletSquad",0]] call MPSF_fnc_itemAmrelTablet;}]
			,["Roles",{["switchControlGroup",["AmrelTabletSquadRoleView","RscDisplayAmrelTabletSquad",0]] call MPSF_fnc_itemAmrelTablet;}]
			,["",{}]
			,["",{}]
			,["",{}]
		]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc1","F1: Squads"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc2","F2: Team"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc3","F3: Roles"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc4","F4:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc5","F5:"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlText",["RscControlAmrelTabletMenuScreen_Fnc6","F6:"]] call MPSF_fnc_itemAmrelTablet;

		uiNamespace setVariable [VAR_SELECTED_PLAYER,objNull];

		["RefreshSquadUI"] call MPSF_fnc_squadManager;

		["setCtrlAction",["RscControlAmrelTabletSquadScreen_GroupTree","treeSelChanged",{
			['OnGroupsTreeSelChanged',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSquadScreen_PlayerList","LBDblClick",{
			['OnPlayerListSelChanged',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSquadRoleScreen_PlayerList","LBDblClick",{
			['OnPlayerListSelChanged',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSquadEditGroupName","KeyDown",{
			['SetGroupName',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSquadEditGroupName","KillFocus",{
			['OnGroupNameKillFocus',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["setCtrlAction",["RscControlAmrelTabletSquadCheckboxPrivate","CheckedChanged",{
			['OnPrivateStateChanged',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		["OnGroupsTreeSelChanged",["RscControlAmrelTabletSquadScreen_GroupTree"]] call MPSF_fnc_squadManager;
		["switchControlGroup",["AmrelTabletSquadGroupView","RscDisplayAmrelTabletSquad"]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "RefreshSquadUI" : {
		_params params [["_index",-1,[0]]];

		["FillGroupsListbox",[
			["getFriendlyGroups",[side group player]] call MPSF_fnc_squadManager,
			["getUnregisteredPlayers",[side group player]] call MPSF_fnc_squadManager
		]] call MPSF_fnc_squadManager;

		["FillPlayersListbox",[
			units group player,
			false,
			"RscControlAmrelTabletSquadScreen_PlayerList"
		]] call MPSF_fnc_squadManager;

		["FillPlayersListbox",[
			if ([player] call MPSF_fnc_isAdmin) then {
				["getFriendlyPlayers",[side group player]] call MPSF_fnc_squadManager
			} else {
				units group player
			},
			false,
			"RscControlAmrelTabletSquadRoleScreen_PlayerList"
		]] call MPSF_fnc_squadManager;

		["FillRoleComboBox",[
			side group player
		]] call MPSF_fnc_squadManager;

		["FillRankComboBox",[
			side group player
		]] call MPSF_fnc_squadManager;

		["RefreshSquadScreen",[_index]] call MPSF_fnc_squadManager;
		["RefreshRoleScreen",[_index]] call MPSF_fnc_squadManager;

		true;
	};
	case "RefreshSquadScreen" : {
		_params params [["_index",-1,[0]]];

		private _playerGroup = group player;
		private _groupName = groupId _playerGroup;
		private _groupPicture = _playerGroup getVariable [VAR_GROUP_INSIGNIA, ""];
		private _groupIsPrivate = _playerGroup getVariable [VAR_GROUP_PRIVATE, false];
		private _groupLeader = leader _playerGroup;
		private _groupPlayers = units _playerGroup;
		private _groupSide = side _playerGroup;
		private _playerIsLeader = player == _groupLeader;

		private _ctrlSquadNameEdit = uiNamespace getVariable ["RscControlAmrelTabletSquadEditGroupName",controlNull];
		_ctrlSquadNameEdit ctrlSetText (_groupName);
		_ctrlSquadNameEdit ctrlEnable (_groupLeader isEqualTo player);

		private _ctrlSquadColour = uiNamespace getVariable ["RscControlAmrelTabletSquadPictureSide",controlNull];
		private _sideColor = [_groupSide] call BIS_fnc_sideColor;
		private _sideColorString = switch (_groupSide) do
		{
			case WEST : 		{ format["#(argb,8,8,3)color(%1,%2,%3,0.6)", _sideColor select 0, _sideColor select 1, _sideColor select 2] };
			case EAST : 		{ format["#(argb,8,8,3)color(%1,%2,%3,0.6)", _sideColor select 0, _sideColor select 1, _sideColor select 2] };
			case RESISTANCE : 	{ format["#(argb,8,8,3)color(%1,%2,%3,0.6)", _sideColor select 0, _sideColor select 1, _sideColor select 2] };
			case default 		{ "#(argb,8,8,3)color(0.9,0.9,0.9,0.6)" };
		};
		_ctrlSquadColour ctrlSetText _sideColorString;

		private _ctrlSquadPlayerCount = uiNamespace getVariable ["RscControlAmrelTabletSquadTextPlayerCount",controlNull];
		_ctrlSquadPlayerCount ctrlSetText str (count _groupPlayers);

		private _ctrlSquadTextLeader = uiNamespace getVariable ["RscControlAmrelTabletSquadTextPlayerNameFill",controlNull];
		_ctrlSquadTextLeader ctrlSetText ([_groupLeader] call BIS_fnc_getName);

		private _ctrlSquadTextSide = uiNamespace getVariable ["RscControlAmrelTabletSquadTextPlayerSideFill",controlNull];
		private _groupSideString = switch (_groupSide) do {
			case WEST : 		{ localize "STR_A3_texturesources_blu0" };
			case EAST : 		{ localize "STR_A3_truck_02_transport_base_f_texturesources_opfor0" };
			case RESISTANCE : 	{ localize "STR_A3_cfggroups_indep0" };
			case default 		{ localize "STR_A3_cfgvehicles_c_man_10" };
		};
		_ctrlSquadTextSide ctrlSetText _groupSideString;

		private _ctrlSquadTextScore = uiNamespace getVariable ["RscControlAmrelTabletSquadTextPlayerScoreFill",controlNull];
		_ctrlSquadTextScore ctrlSetText str (score player);
		
		private _ctrlSquadGroupIcon = uiNamespace getVariable ["RscControlAmrelTabletSquadGroupIcon",controlNull];
		private _insignia = missionNamespace getVariable [VAR_FORCED_INSIGNIA, ""];
		private _insigniaTexture = if (_insignia != "") then {["GetInsigniaTexture", [_insignia]] call GROUPS} else {["GetInsigniaTexture", [_groupPicture]] call GROUPS};
		_ctrlSquadGroupIcon ctrlSetText _insigniaTexture;

		private _ctrlSquadGroupPrivateCheck = uiNamespace getVariable ["RscControlAmrelTabletSquadCheckboxPrivate",controlNull];
		_ctrlSquadGroupPrivateCheck ctrlEnable (_playerIsLeader && {!(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false])});
		_ctrlSquadGroupPrivateCheck cbSetChecked _groupIsPrivate;
		_ctrlSquadGroupPrivateCheck ctrlEnable (_groupLeader isEqualTo player);
	};
	case "RefreshRoleScreen" : {
		_params params [["_index",-1,[0]]];

		private _checkboxes = [
			["RscControlAmrelTabletSquadCheckboxCrewman","Crewman"],
			["RscControlAmrelTabletSquadCheckboxPilotHeli","PilotHeli"],
			["RscControlAmrelTabletSquadCheckboxPilotPlane","PilotPlane"],
			["RscControlAmrelTabletSquadCheckboxMedic","Medic"],
			["RscControlAmrelTabletSquadCheckboxEngineer","Engineer"],
			["RscControlAmrelTabletSquadCheckboxExplosiveSpecialist","ExplosiveSpecialist"],
			["RscControlAmrelTabletSquadCheckboxHALO","HALO"],
			["RscControlAmrelTabletSquadCheckboxJTAC","JTAC",true]
		];

        private _ctrlRank = uiNamespace getVariable ["RscControlAmrelTabletSquadUnitRankDropdown",controlNull];
        private _ctrlRole = uiNamespace getVariable ["RscControlAmrelTabletSquadUnitRoleDropdown",controlNull];
		private _listbox = uiNamespace getVariable ["RscControlAmrelTabletSquadRoleScreen_PlayerList",controlNull];
		if (_index >= 0) then {
			_listbox lbSetCurSel _index;
		};

		private _selected = uiNamespace getVariable [VAR_SELECTED_PLAYER,objNull];
		if (isNull _selected) exitWith {
			{
				private _ctrl = uiNamespace getVariable [_x select 0,controlNull];
				_ctrl ctrlEnable false;
			} forEach (_checkboxes+[
				["RscControlAmrelTabletSquadUnitRankDropdown"],
				["RscControlAmrelTabletSquadUnitRoleDropdown"]
			]);
		};

		{
			private _ctrl = uiNamespace getVariable [_x select 0,controlNull];
			_ctrl ctrlEnable true;
		} forEach (_checkboxes+[
			["RscControlAmrelTabletSquadUnitRankDropdown"],
			["RscControlAmrelTabletSquadUnitRoleDropdown"]
		]);

		private _ctrlName = uiNamespace getVariable ["RscControlAmrelTabletSquadUnitRankText",controlNull];
		_ctrlName ctrlSetText format ["%1. %2",[_selected,"displayNameShort"] call BIS_fnc_rankParams,[_selected] call BIS_fnc_getName];

		private _unitRole = ["get",[_selected]] call MPSF_fnc_squadUnitRole;
		["FillRankComboBox"] call MPSF_fnc_squadManager;
		["FillRoleComboBox"] call MPSF_fnc_squadManager;

		{
			_x params ["_ctrlID","_trait"];
			private _ctrl = uiNamespace getVariable [_ctrlID,controlNull];
			private _hasTrait = [_selected,_trait,false] call MPSF_fnc_getUnitTrait;

			["setCtrlAction",[_ctrlID,"CheckedChanged",""]] call MPSF_fnc_itemAmrelTablet;

			_ctrl cbSetChecked (_hasTrait);

			["setCtrlAction",[_ctrlID,"CheckedChanged",
				compile format ["['OnRoleCheckedChanged',_this+[%1]] call MPSF_fnc_squadManager;",str _trait]
			]] call MPSF_fnc_itemAmrelTablet;
		} forEach _checkBoxes;

		true;
	};
	case "FillGroupsListbox" : {
		_params params [["_groupsList",[],[[]]],["_unsortedPlayers",[],[[]]]];
		private _selectedIndex 	= [-1, -1];
		private _totalIndex	= -1;
		private _listbox = uiNamespace getVariable ["RscControlAmrelTabletSquadScreen_GroupTree",controlNull];

		tvClear _listbox;
		{
			private _index = _forEachIndex;
			_totalIndex = _totalIndex + 1;

			private _groupName 		= groupId _x;
			private _groupPicture 	= _x getVariable [VAR_GROUP_INSIGNIA, ["LoadRandomInsignia"] call BIS_fnc_dynamicGroups];
			private _groupIsPrivate = _x getVariable [VAR_GROUP_PRIVATE, false];
			private _groupLeader 	= leader _x;
			private _groupPlayers 	= units _x;
			private _wasKickedFrom	= ["WasPlayerKickedFrom", [_x, player]] call BIS_fnc_dynamicGroups;
			private _hasInvite		= ["HasInvite", [_x, player]] call BIS_fnc_dynamicGroups;
			private _locked			= (_groupIsPrivate || {_wasKickedFrom}) && /* {!(player in _groupPlayers)} && */ {!_hasInvite};
			private _maxUnitCount	= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];
			private _isFull			= count units _x >= _maxUnitCount;
			private _autoName		= if (_maxUnitCount < 99) then { format ["%1  (%2/%3)", _groupName, count units _x, missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99]] } else { _groupName };

			if ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 0 == _x) then {
				_selectedIndex = [_index, -1];
			};

			private _parent = _listbox tvAdd [[], _autoName];
			_listbox tvSetData [[_parent], _groupName];
			_listbox tvSort [[_parent], true];
			_listbox tvSetPicture [[_parent], ["GetInsigniaTexture", [_groupPicture]] call BIS_fnc_dynamicGroups];
			if (_locked) then {
				_listbox tvSetPictureRight [[_parent], "a3\Ui_f\data\GUI\Rsc\RscDisplayDynamicGroups\Lock.paa"];
				_listbox tvSetPictureRightColor [[_parent], COLOR_LOCKED];
				_listbox tvSetPictureColor [[_parent], COLOR_LOCKED];
			} else {
				_listbox tvSetPictureColor [[_parent], [1,1,1,1]];
			};
			_listbox tvSetPictureColorSelected [[_parent], [1,1,1,1]];
			_listbox tvSetPictureColorDisabled [[_parent], [1,1,1,1]];
			if (_x in (uiNamespace getVariable [VAR_COLLAPSED_GROUPS, []])) then { _listbox tvCollapse [_parent]; } else { _listbox tvExpand [_parent]; };

			{
				private _groupPlayerName 	= [_x] call BIS_fnc_getName;
				private _isLeader			= _x == _groupLeader;
				private _sameGroup			= group player == group _x;
				private _groupPlayerIcon	= if (!_isLeader) then { ["GetPlayerIcon", [_x]] call DISPLAY; } else { ICON_GENERAL; };
				private _isDead				= !alive _x;
				private _isIncapacitated	= alive _x && _x getVariable ["BIS_revive_incapacitated", false];
				private _color = switch (true) do {
					case (_isDead) : 			{ COLOR_DEAD };
					case (_isIncapacitated) : 	{ COLOR_INCAPACITATED };
					case (player == _x) : 		{ COLOR_SELF };
					case (_sameGroup) : 		{ COLOR_GROUP };
					default 					{ COLOR_DEFAULT };
				};

				if ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 1 == _x) then {
					_selectedIndex = [_index, _forEachIndex];
				};

				if (_isDead) then {
					_groupPlayerName = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
					_groupPlayerIcon = ICON_KIA;
				} else {
					if (_isIncapacitated) then { _groupPlayerIcon = ICON_REVIVE; };
				};

				private _child = _listbox tvAdd [[_parent], _groupPlayerName];
				_listbox tvSetData [[_parent, _child], _x call BIS_fnc_netId];
				_listbox tvSort [[_parent, _child], true];
				_listbox tvSetPicture [[_parent, _child], _groupPlayerIcon];
				_listbox tvSetPictureColor [[_parent, _child], _color];
			} forEach _groupPlayers;
		} forEach _groupsList;

		if (count _unsortedPlayers > 0) then {
			// Add unsorted players to the list
			private _parent = _listbox tvAdd [[], UNSORTED_GROUP_ID];
			_listbox tvSetData [[_parent], UNSORTED_GROUP_ID];
			_listbox tvSort [[_parent], true];
			_listbox tvExpand [_parent];
			_totalIndex = _totalIndex + 1;

			if (isNull ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 0)) then {
				_selectedIndex = [count _groupsList, -1];
			};

			{
				private _unsortedPlayerName = [_x] call BIS_fnc_getName;
				private _unsortedPlayerIcon = ["GetPlayerIcon", [_x]] call DISPLAY;
				private _isDead = !alive _x;
				private _isIncapacitated = alive _x && {_x getVariable ["BIS_revive_incapacitated", false]};

				private _color = switch (true) do {
					case (_isDead) : { COLOR_DEAD };
					case (_isIncapacitated) : { COLOR_INCAPACITATED };
					case (player == _x) : { COLOR_SELF };
					default { COLOR_DEFAULT };
				};

				if ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 1 == _x) then {
					_selectedIndex = [_totalIndex, _forEachIndex];
				};

				if (_isDead) then {
					_unsortedPlayerName = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
					_unsortedPlayerIcon = ICON_KIA;
				} else {
					if (_isIncapacitated) then { _unsortedPlayerIcon = ICON_REVIVE; };
				};

				private _child = _listbox tvAdd [[_parent], _unsortedPlayerName];
				_listbox tvSetData [[_parent, _child], _x call BIS_fnc_netId];
				_listbox tvSort [[_parent, _child], true];
				_listbox tvSetPicture [[_parent, _child], _unsortedPlayerIcon];
				_listbox tvSetPictureColor [[_parent, _child], _color];

				if (UNSORTED_GROUP_ID in (uiNamespace getVariable [VAR_COLLAPSED_GROUPS, []])) then {
					_listbox tvCollapse [_parent];
				} else {
					_listbox tvExpand [_parent];
				};
			} forEach _unsortedPlayers;
		};

		// If we had a previously selected element, try to re-set it if it still exists
		if (_selectedIndex select 0 != -1) then {
			if (_selectedIndex select 1 != -1) then {
				_listbox tvSetCurSel _selectedIndex;
			} else {
				_listbox tvSetCurSel [_selectedIndex select 0];
			};
		};
	};
	case "FillPlayersListbox" : {
		_params params [["_playerList",[],[[]]],["_isManageSection", false, [true]],["_listID","",[""]]];
		private _targetVar	= if (_isManageSection) then { VAR_SELECTED_MEMBER } else { VAR_SELECTED_PLAYER };
		private _targetList	= if (_isManageSection) then { VAR_OLD_MEMBERS_LIST } else { VAR_OLD_PLAYERS_LIST };
		private _listbox = uiNamespace getVariable [_listID,controlNull];
		lnbClear _listbox;
		{
			private _name 				= format ["%1. %2 (%3)",
				[_x,"displayNameShort"] call BIS_fnc_rankParams,
				[_x] call BIS_fnc_getName,
				["get",[_x]] call MPSF_fnc_squadUnitRole
			];
			private _textureIcon		= ["GetPlayerIcon", [_x]] call DISPLAY;
			private _textureRank		= "a3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";
			private _isGroupLeader		= _x == leader group _x;
			private _texture 			= if (_isGroupLeader && ["IsGroupRegistered", [group _x]] call GROUPS) then { _textureRank } else { _textureIcon };
			private _sameGroup			= group player == group _x;
			private _isDead				= !alive _x;
			private _isIncapacitated	= alive _x && _x getVariable ["BIS_revive_incapacitated", false];
			private _color = switch (true) do {
				case (_isDead) : 		{ COLOR_DEAD };
				case (_isIncapacitated) : 	{ COLOR_INCAPACITATED };
				case (player == _x) : 		{ COLOR_SELF };
				case (_sameGroup) : 		{ COLOR_GROUP };
			};

			if (_isDead) then {
				_name = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
				_texture = ICON_KIA;
			} else {
				if (_isIncapacitated) then { _texture = ICON_REVIVE; };
			};

			_listbox lnbAddRow [""];
			_listbox lnbSetData [[_forEachIndex, 0], _x call BIS_fnc_netId];
			_listbox lnbSetPicture [[_forEachIndex, 0], _texture];
			_listbox lnbSetText [[_forEachIndex, 1], _name];
			_listbox lnbSetTooltip [[_forEachIndex, 0], format ["Double click to edit %1", [_x] call BIS_fnc_getName]];
			_listbox lnbSetTooltip [[_forEachIndex, 1], format ["Double click to edit %1", [_x] call BIS_fnc_getName]];
			_listbox lnbSetColor [[_forEachIndex, 1], [1,1,1,1]];
			_listbox lnbSetPictureColor [[_forEachIndex, 0], _color];
			_listbox lnbSetPictureColorSelected [[_forEachIndex, 0], _color];

			if (player == _x) then { _curSel = _forEachIndex; };
		} forEach _playerList;
		_listbox lbSetCurSel _curSel;
	};
	case "FillRankComboBox" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSquadUnitRankDropdown",controlNull];
		private _index = 0;

		["setCtrlAction",["RscControlAmrelTabletSquadUnitRankDropdown","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_ctrl lbAdd getText (_x >> "displayName");
			_ctrl lbSetPicture [_foreachindex,getText (_x >> "texture")];
			_ctrl lbSetTooltip [_foreachindex,getText (_x >> "displayName")];
			_ctrl lbSetData [_foreachindex,getText (_x >> "displayName")];
			if (toUpper(getText(_x >> "displayName")) isEqualTo rank (uiNamespace getVariable [VAR_SELECTED_PLAYER,objNull])) then { _index = _forEachIndex; };
		} forEach ("isClass _x" configClasses (configFile >> "CfgRanks"));

		_ctrl lbSetCurSel _index;

		["setCtrlAction",["RscControlAmrelTabletSquadUnitRankDropdown","LBSelChanged",{
			['OnRankSelChanged',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "FillRoleComboBox" : {
		private _ctrl = uiNamespace getVariable ["RscControlAmrelTabletSquadUnitRoleDropdown",controlNull];
		private _roles = ["getCfgRoles",[side group player,true]] call MPSF_fnc_getCfgRoles;
		private _index = 0;

		["setCtrlAction",["RscControlAmrelTabletSquadUnitRoleDropdown","LBSelChanged",""]] call MPSF_fnc_itemAmrelTablet;

		lbClear _ctrl;
		{
			_x params ["_roleID","_SideID","_DisplayName","_Icon","_Limit"];

			_ctrl lbAdd _DisplayName;
			_ctrl lbSetPicture [_foreachindex,_Icon];
			_ctrl lbSetTooltip [_foreachindex,format ["Assign Role: %1",_DisplayName]];
			_ctrl lbSetData [_foreachindex,_roleID];
			if (_roleID isEqualTo (["get",[uiNamespace getVariable [VAR_SELECTED_PLAYER,objNull]]] call MPSF_fnc_squadUnitRole)) then {
				_index = _forEachIndex;
			};
		} forEach _roles;

		_ctrl lbSetCurSel _index;

		["setCtrlAction",["RscControlAmrelTabletSquadUnitRoleDropdown","LBSelChanged",{
			['OnRoleSelChanged',_this] call MPSF_fnc_squadManager;
		}]] call MPSF_fnc_itemAmrelTablet;

		true;
	};
	case "OnGroupsTreeSelChanged" : {
		_params params [["_listbox",controlNull,[controlNull,""]]];
		if (_listbox isEqualType "") then { _listbox = uiNamespace getVariable [_listbox,controlNull]; };

		["setCtrlText",["RscControlAmrelTabletSquadGroupButton","Action"]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlEnable",["RscControlAmrelTabletSquadGroupButton",false]] call MPSF_fnc_itemAmrelTablet;
		["setCtrlAction",["RscControlAmrelTabletSquadGroupButton","ButtonClick",{false}]] call MPSF_fnc_itemAmrelTablet;

		private _index = tvCurSel _listbox;
		if (count _index < 1 || { _index select 0 < 0 }) exitWith {};

		private _data = _listbox tvData _index;
		private _unsorted = _data == UNSORTED_GROUP_ID;
		private _hasGroup = ["PlayerHasGroup", [player]] call GROUPS;
		private _isLeader = _hasGroup && {player == leader group player};

		// If we are dealing with the unsorted group we exit
		if (_unsorted) exitWith {
			uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER,[grpNull, objNull]];
			if !(_hasGroup) then {
				["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_RscDisplayDynamicGroups_Button_Create",localize "STR_A3_RscDisplayDynamicGroups_Button_Create"]] call MPSF_fnc_itemAmrelTablet;
				["setCtrlEnable",["RscControlAmrelTabletSquadGroupButton",true]] call MPSF_fnc_itemAmrelTablet;
				["setCtrlAction",["RscControlAmrelTabletSquadGroupButton","ButtonClick",{
					["onMouseClick",_this+["create"]] call MPSF_fnc_squadManager;
				}]] call MPSF_fnc_itemAmrelTablet;
			};
		};

		private _group  = ["GetGroupByName", [_data, side group player]] call GROUPS;
		private _player = _data call BIS_fnc_objectFromNetId;
		// Validate group or player
		if (isNull _group && {isNull _player}) exitWith {
			["OnGroupsTreeSelChanged: Group (%1) or player (%1) not found", _data] call BIS_fnc_error;
		};
		// Did the user just clicked a group or a player
		if !(isNull _group) then {
			// A group was selected
			private _groupIsPrivate = _group getVariable [VAR_GROUP_PRIVATE, false];
			private _wasKickedFrom = ["WasPlayerKickedFrom", [_group, player]] call GROUPS;
			private _isInGroup = _group == group player;
			private _hasInvite = ["HasInvite", [_group, player]] call GROUPS;
			private _isFull = count units _group >= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];
			uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, [_group, objNull]];
			switch (true) do {
				// Player Group Selected
				case (_hasGroup && _isInGroup) : {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_RscDisplayDynamicGroups_Button_Leave",localize "STR_A3_RscDisplayDynamicGroups_Tooltip_LeaveGroup"]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlEnable",["RscControlAmrelTabletSquadGroupButton",true]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlAction",["RscControlAmrelTabletSquadGroupButton","ButtonClick",{
						["onMouseClick",_this+["leave"]] call MPSF_fnc_squadManager;
					}]] call MPSF_fnc_itemAmrelTablet;
				};
				case (_hasGroup);
				case (_isInGroup || {_isFull} || {!_hasInvite && {_groupIsPrivate || {_wasKickedFrom}}}) : {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_RscDisplayDynamicGroups_Button_Join",""]] call MPSF_fnc_itemAmrelTablet;
				};
				default {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_RscDisplayDynamicGroups_Button_Join",""]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlEnable",["RscControlAmrelTabletSquadGroupButton",true]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlAction",["RscControlAmrelTabletSquadGroupButton","ButtonClick",{
						["onMouseClick",_this+["join"]] call MPSF_fnc_squadManager;
					}]] call MPSF_fnc_itemAmrelTablet;
				};
			};
		} else {
			// A player was selected
			private _playerName = [_player] call BIS_fnc_getName;
			private _hasInvite = ["HasInvite", [group player, _player]] call GROUPS;
			private _sameGroup = group player == group _player;
			private _noGroup = !(["PlayerHasGroup", [player]] call GROUPS);
			uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, [group _player, _player]];
			uiNamespace setVariable [VAR_SELECTED_PLAYER, _player];
			switch (true) do {
				case (_isLeader && {_sameGroup} && {player != _player}) : {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_RscDisplayDynamicGroups_Button_KickBan",localize "STR_A3_RscDisplayDynamicGroups_Tooltip_KickPlayer"]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlEnable",["RscControlAmrelTabletSquadGroupButton",true]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlAction",["RscControlAmrelTabletSquadGroupButton","ButtonClick",{
						["onMouseClick",_this+["kick"]] call MPSF_fnc_squadManager;
					}]] call MPSF_fnc_itemAmrelTablet;
				};
				case !(_hasGroup) : {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton","",""]] call MPSF_fnc_itemAmrelTablet;
				};
				case (_hasInvite) : {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_rscdisplaydynamicgroups_button_invited",localize "STR_A3_rscdisplaydynamicgroups_tooltip_invited"]] call MPSF_fnc_itemAmrelTablet;
				};
				case (!_isLeader || {_sameGroup} || {_noGroup} || {player == _player}) : {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_rscdisplaydynamicgroups_button_invite",""]] call MPSF_fnc_itemAmrelTablet;
				};
				default {
					["setCtrlText",["RscControlAmrelTabletSquadGroupButton",localize "STR_A3_rscdisplaydynamicgroups_button_invite",""]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlEnable",["RscControlAmrelTabletSquadGroupButton",true]] call MPSF_fnc_itemAmrelTablet;
					["setCtrlAction",["RscControlAmrelTabletSquadGroupButton","ButtonClick",{
						["onMouseClick",_this+["invite"]] call MPSF_fnc_squadManager;
					}]] call MPSF_fnc_itemAmrelTablet;
				};
			};
		};
	};
	case "OnPlayerListSelChanged" : {
		_params params [["_listbox",controlNull,[controlNull,""]],["_index",-1,[0]]];
		if (_listbox isEqualType "") then { _listbox = uiNamespace getVariable [_listbox,controlNull]; };

		// Make sure we have a group, otherwise there is nothing for us to do here
		if !(["PlayerHasGroup", [player]] call GROUPS) exitWith {
			player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],"You do not have an assigned group"];
		};

		// The clicked player
		private _clickedUid = _listbox lnbData [_index, 0];

		// The player to which the uid belongs to
		private _clickedPlayer  = _clickedUid call BIS_fnc_objectFromNetId;
		private _hasInvite = ["HasInvite", [group player, _clickedPlayer]] call GROUPS;
		private _inSameGroup = group player == group _clickedPlayer;
		private _weAreLeader = player == leader group player;

		// Store the newly selected player
		uiNamespace setVariable [VAR_SELECTED_PLAYER, _clickedPlayer];
		["RefreshRoleScreen",[_index]] call MPSF_fnc_squadManager;
		["switchControlGroup",["AmrelTabletSquadRoleView","RscDisplayAmrelTabletSquad"]] call MPSF_fnc_itemAmrelTablet;
	};
	case "OnRankSelChanged" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_index",-1,[0]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };

		private _rankID = _ctrl lbData _index;
		private _selected = uiNamespace getVariable [VAR_SELECTED_PLAYER,objNull];

		[_selected,_rankID] call MPSF_fnc_setUnitRank;
		["RefreshSquadUI",[_index]] call MPSF_fnc_squadManager;

		true;
	};
	case "OnRoleSelChanged" : {
		_params params [["_ctrl",controlNull,[controlNull,""]],["_index",-1,[0]]];
		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };

		private _roleID = _ctrl lbData _index;
		private _selected = uiNamespace getVariable [VAR_SELECTED_PLAYER,objNull];

		["set",[_selected,_roleID]] call MPSF_fnc_squadUnitRole;
		["RefreshSquadUI",[_index]] call MPSF_fnc_squadManager;

		true;
	};
	case "OnRoleCheckedChanged" : {
		_params params [["_ctrl",controlNull,[0,controlNull]],["_index",0,[0]],["_trait","",[""]]];

		if (_trait isEqualTo "") exitWith {["No Trait Supplied %1",_this] call BIS_fnc_error; false};

		if (toLower _trait isEqualTo "jtac" && !([player] call MPSF_fnc_isAdmin)) exitWith {["Only Administrators can assign JTAC Roles"] call BIS_fnc_error; false};

		private _selected = uiNamespace getVariable [VAR_SELECTED_PLAYER,objNull];
		[_selected,_trait,_index==1] spawn MPSF_fnc_setUnitTrait;

		true;
	};
	case "OnPrivateStateChanged" : {
		_params params [["_checkboxPrivate",controlNull],["_isChecked",0,[0]]];
		["SendClientMessage", ["SetPrivateState", [group player,_isChecked == 1]]] call GROUPS;
		["RefreshSquadUI"] call MPSF_fnc_squadManager;
	};
	case "SetGroupName" : {
		_params params [["_editGroupName",controlNull,[controlNull]],["_key",-1,[0]]];
		if (_key == 28 || {_key == 156} || {_key == -1}) then {
			ctrlSetFocus (uiNamespace getVariable ["RscControlAmrelTabletSquadScreen_PlayerList", displayNull]);
		};
	};
	case "OnGroupNameKillFocus" : {
		_params params [["_editGroupName",controlNull,[controlNull]]];
		if (isNull _editGroupName) exitWith {};

		private _oldGroupName = groupid (group player);
		private _groupName = ctrlText _editGroupName;

		if (_oldGroupName == _groupName) exitWith {};

		private _groupsOfSide = ["GetAllGroupsOfSide", [side group player]] call GROUPS;
		private _nameTaken = false;
		{
			if (groupId _x isEqualTo _groupName) then { _nameTaken = true; };
		} forEach _groupsOfSide;

		if !(_nameTaken) then {
			(group player) setGroupId [_groupName];
			["SendClientMessage", ["SetName", [group player, _groupName]]] call GROUPS;
			playsound "ReadoutHideClick1";
		};

		["RefreshSquadUI"] call MPSF_fnc_squadManager;
	};
	case "onMouseClick" : {
		_params params [["_ctrl",controlNull,["",controlNull]],["_value","",["",0]]];

		if (_ctrl isEqualType "") then { _ctrl = uiNamespace getVariable [_ctrl,controlNull]; };
		if (_ctrl isEqualTo controlNull) exitWith {};

		switch (ctrlIDC _ctrl) do {
			case 86031 : {};
			case 86032 : {
				systemChat str [_value];
				switch (toLower _value) do {
					case "create" : {
						// Request group for player
						if (player == leader group player) then {
							["SendClientMessage", ["RegisterGroup", [group player, player]]] call GROUPS;
						} else {
							["SendClientMessage", ["CreateGroupAndRegister", [player]]] call GROUPS;
						};
					};
					case "join" : {
						_ctrl ctrlEnable false;

						//["SetDefaultFocus"] call DISPLAY:

						private _listboxGroups = uiNamespace getVariable ["RscControlAmrelTabletSquadScreen_GroupTree",controlNull];
						private _index = tvCurSel _listboxGroups;
						private _groupUniqueId = _listboxGroups tvData _index;

						private _group = ["GetGroupByName", [_groupUniqueId, side group player]] call GROUPS;

						if !(isNull _group) then {
							private _groupLeader = leader _group;
							private _groupIsPrivate = _group getVariable [VAR_GROUP_PRIVATE, false];
							private _hasInvite = ["HasInvite", [_group, player]] call GROUPS;
							private _isFull = count units _group >= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];

							if ((!_groupIsPrivate || {_hasInvite}) && {!_isFull}) then {
								if !(["PlayerHasGroup", [player]] call GROUPS) then {
									["SendClientMessage", ["AddGroupMember", [_group, player]]] call GROUPS;
								} else {
									["SendClientMessage", ["SwitchGroup", [_group, player]]] call GROUPS;
								};

								if (_hasInvite) then {
									["RemoveInvite", [_group, player]] call GROUPS;
								};

								// Event
								["OnGroupJoin", [_group, _groupLeader, player]] call GROUPS;
							};
						};
					};
					case "leave" : {
						// Request server to make player leave the current group
						["SendClientMessage", ["RemoveGroupMember", [group player, player]]] call GROUPS;
						// Event
						["OnGroupLeave", [group player, leader group player, player]] call GROUPS;
					};
					case "invite" : {
						private _listbox = uiNamespace getVariable ["RscControlAmrelTabletSquadScreen_GroupTree",controlNull];
						private _listboxIndex = tvCurSel _listbox;

						// Validate selected player in list box
						if (_listboxIndex isEqualTo []) exitWith {
							"OnInvitePlayerButtonClick: No player selected within the Tree/listNbox resource" call BIS_fnc_error;
						};

						// The local player group
						private _group = group player;
						private _clickedUid = _listbox tvData _listboxIndex;
						private _clickedPlayer = _clickedUid call BIS_fnc_objectFromNetId;

						// Validate player object
						if (isNull _clickedPlayer) exitWith {
							["OnInvitePlayerButtonClick: Player with uid (%1) not found", _clickedUid] call BIS_fnc_error;
						};

						if !(isMultiplayer) exitWith {
							["SwitchGroup",[_group,_clickedPlayer]] call GROUPS;
						};

						// Add invite
						if !(["HasInvite", [_group, _clickedPlayer]] call GROUPS) then {
							["AddInvite", [_group, player, _clickedPlayer]] call GROUPS;
						};
					};
					case "kick" : {
						(uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull,objNull]]) params [["_groupID",grpNull,[grpNull]],["_kickedPlayer",objNull,[objNull]]];
						private _group = group player;
						private _groupLeader = leader _group;
						if (!isNull _group && {!isNull _groupLeader} && {!isNull _kickedPlayer} && {_groupLeader == player}) then {
							// Request server to make player leave the current group
							["SendClientMessage", ["KickPlayer", [_group, _groupLeader, _kickedPlayer]]] call GROUPS;
							// Event
							["OnKicked", [_group, _kickedPlayer, _groupLeader]] call GROUPS;
						};
					};
					default {systemChat "Failed";};
				};
				["RefreshSquadUI"] call MPSF_fnc_squadManager;
			};
		};
		true;
	};
/* Common */
	case "getFriendlyGroups" : {
		_params params [["_side",sideUnknown,[sideUnknown]]];
		if (_side isEqualTo sideUnknown) exitWith {[]};

		private _groups = [];
		{
			if ((isPlayer leader _x || !isMultiplayer) && {count units _x > 0} && {side _x == _side} && {["IsGroupRegistered", [_x]] call GROUPS}) then {
				_groups pushBack _x;
			};
		} forEach allGroups;

		_groups;
	};
	case "getFriendlyPlayers" : {
		_params params [["_side",sideUnknown,[sideUnknown]]];
		private _sidePlayers = [];
		{
			if ((isPlayer _x || !isMultiplayer) && {side group _x == _side}) then {
				_sidePlayers pushBackUnique _x;
			};
		} forEach playableUnits + switchableUnits + allDeadMen + (units group player);
		_sidePlayers
	};
	case "getUnregisteredPlayers" : {
		_params params [["_side",sideUnknown,[sideUnknown]]];
		private _unRegisteredPlayers = [];
		{
			if (isPlayer _x && {side group _x == _side} && {!(["IsGroupRegistered", [group _x]] call BIS_fnc_dynamicGroups)}) then {
				_unRegisteredPlayers pushBack _x;
			};
		} forEach playableUnits + switchableUnits + allDeadMen;
		_unRegisteredPlayers
	};
	case "isGroupRegistered" : {
		_params params [["_groupID",grpNull,[grpNull]]];
		["IsGroupRegistered",[_groupID]] call BIS_fnc_dynamicGroups
	};
/* Init */
	case "postInit" : {
		["init"] call MPSF_fnc_squadUnitRole;

		// Role check onGetIn
		["MPSF_VirtualArmoury_onGetIn_EH","onGetIn",{
			params [["_target",objNull,[objNull]],["_vehicleRole","",[""]],["_vehicle",objNull,[objNull]],["_turret",[],[[]]]];
			if !([_target,_vehicle] call MPSF_fnc_squadCheckVehicleRole) then {
				_target assignAsCargo _vehicle;
				_target moveInCargo _vehicle;
				if (_vehicle getCargoIndex _target < 0) then {
					_target action ["getOut",_vehicle];
				};
				["VirtualArmoury_RoleFailed"] call BIS_fnc_showNotification;
			};
		}] call (missionNamespace getVariable ["MPSF_fnc_addEventHandler",{false}]);

		// Role check onSeatSwitch
		["MPSF_VirtualArmoury_onSeatSwitch_EH","onSeatSwitch",{
			params ["_target", "_target2", "_vehicle"];
			private _role = (assignedVehicleRole _target) param [0,""];
			if !([_target,_vehicle] call MPSF_fnc_squadCheckVehicleRole) then {
				_target assignAsCargo _vehicle;
				_target moveInCargo _vehicle;
				if (_vehicle getCargoIndex _target < 0) then {
					_target action ["getOut",_vehicle];
				};
				["VirtualArmoury_RoleFailed"] call BIS_fnc_showNotification;
			};
		}] call (missionNamespace getVariable ["MPSF_fnc_addEventHandler",{false}]);

		if (isServer) then {
			["Initialize", [true]] call BIS_fnc_dynamicGroups;

			{
				["RegisterGroup",[group _x,_x]] call GROUPS;
			} forEach (playableUnits + switchableUnits);
		};

		if (hasInterface) then {
			[] spawn {
				waitUntil{ !(isNull player) };
				["InitializePlayer",[player, true]] call BIS_fnc_dynamicGroups;
				["RemoveKeyEvents",[displayNull]] spawn {sleep 1; _this call BIS_fnc_dynamicGroups};

				[missionnamespace,"RscDisplayRespawnKeyDown",missionNamespace getVariable [VAR_PLAYER_RESPAWN_KEYDOWN,-1]] call BIS_fnc_removeScriptedEventhandler;
				missionNamespace setVariable ["BIS_dynamicGroups_allowInterface",false];

				["MPSF_Interface_openAmrelDevice_onKeyDown_EH","onKeyDown",{
					private _key = _this param [1, -1, [0]];
					if (_key in actionKeys UI_OPEN_KEY) exitWith {
						([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelTabletMenu";
					};
					true;
				}] spawn {sleep 1; _this call MPSF_fnc_addEventHandler};
			};

			// MPSF AMREL PDA
			if !(["MPSF_openAmrelPDA",player] call MPSF_fnc_hasAction) then {
				/* ["MPSF_openAmrelPDA",player,"<t color='#ffC600'>Amrel PDA</t>",{
					private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelPDA";
				},[],"vehicle player isEqualTo player",true,false,0] spawn {sleep 0.2; _this call MPSF_fnc_addAction}; */
			};

			// MPSF AMREL TABLET
			if !(["MPSF_openAmrelTablet",player] call MPSF_fnc_hasAction) then {
			//	["MPSF_openAmrelTablet",player,"<t color='#ffC600'>Amrel Tablet</t>",{
			//		private _display = ([] call BIS_fnc_displayMission) createDisplay "RscDisplayAmrelTabletSquad";
			//	},[],"alive player",true,false,0] spawn { sleep 0.5; _this call MPSF_fnc_addAction };
			};
		};
    };
};