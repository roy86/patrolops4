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
#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#define BANNERPO4BLK "framework\data\titles\patrolops_banner_b_co.paa"
#define BANNERPO4WHT "framework\data\titles\patrolops_banner_co.paa"

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "onArsenalOpened" : {
		_params params [["_display",displayNull,[displayNull]],["_index",false,[false]]];

		uiNamespace setVariable ["RscDisplayVirtualArmouryDisplay",_display];

		private _ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		private _ctrlButtonRandom = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM;
		_ctrlButtonRandom ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonRandom ctrlSetText "";
		_ctrlButtonRandom ctrlSetTooltip "";
		_ctrlButtonRandom ctrlEnable false;

		/*private _ctrlButtonSave = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonSave ctrlSetText "";
		_ctrlButtonSave ctrlSetTooltip "";
		_ctrlButtonSave ctrlEnable false;*/

		/*private _ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonLoad ctrlSetText "";
		_ctrlButtonLoad ctrlSetTooltip "";
		_ctrlButtonLoad ctrlEnable false;*/

		/*private _ctrlButtonExport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonExport ctrlSetText "";
		_ctrlButtonExport ctrlSetTooltip "";
		_ctrlButtonExport ctrlEnable true;*/

		private _ctrlButtonImport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonImport ctrlSetText "";
		_ctrlButtonImport ctrlSetTooltip "";
		_ctrlButtonImport ctrlEnable false;

		/* private _ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlButtonOK ctrlRemoveAllEventHandlers "buttonclick";
		_ctrlButtonOK ctrlAddEventhandler ["buttonclick",format ["with missionNamespace do { disableSerialization; ['onButtonRoleClick',['init']] call MPSF_fnc_rscVirtualArmoury; };"]];
		_ctrlButtonOK ctrlSetText "Available Roles";
		_ctrlButtonOK ctrlSetTooltip "View and Request a New Role";
		_ctrlButtonOK ctrlEnable true; */

		private _ctrl = _display ctrlCreate ["RscPictureKeepAspect",-1];
		_ctrl ctrlSetPosition [
			(safezoneW/2) - 7.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safeZoneX)
			,0.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safeZoneY)
			,15 * (((safezoneW / safezoneH) min 1.2) / 40)
			,8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
		];
		
		(date call BIS_fnc_sunriseSunsetTime) params ["_min","_max"];
		if ((date select 3) > _min && (date select 3) < _max) then {
			_ctrl ctrlSetText BANNERPO4BLK;
		} else {
			_ctrl ctrlSetText BANNERPO4WHT;
			_intensity = 1;
			_light = "#lightpoint" createvehicle position player;
			_light setLightBrightness _intensity;
			_light setLightAmbient [1,1,1];
			_light setLightColor [0,0,0];
			_light lightAttachObject [player,[0,0,-_intensity * 7]];
			missionNamespace setVariable ["MPSF_VirtualArmoury_lightpoint",_light];
		};
		_ctrl ctrlSetFade 0.2;
		_ctrl ctrlCommit 0;

		private _roleID = ["get",[player]] call MPSF_fnc_squadUnitRole;
		private _roleName = ["getCfgRoleDisplayName",[_roleID]] call MPSF_fnc_getCfgRoles;
		[
			[
				[format ["%1",name player], "<t align = 'left' shadow = '1' size = '1.1' font='PuristaBold'>%1</t>"],
				[format [": %1",_roleName], "<t align = 'left' shadow = '1' size = '1.1'>%1</t><br/>"],
				[format ["Virtual Armoury Grid #%1",mapGridPosition player],"<t align = 'left' shadow = '1' size = '0.7'>%1</t>",15]
			],
			safeZoneX + safeZoneW * 0.6,
			safeZoneY + safeZoneH * 0.7
		] spawn BIS_fnc_typeText;
	};
	case "onArsenalClosed" : {
		private _light = missionNamespace getVariable ["MPSF_VirtualArmoury_lightpoint",objNull];
		if !(isNull _light) then {
			deleteVehicle _light;
		};
	};
	case "onButtonRoleClick" : {
		if !(isNull (uiNamespace getVariable [format["%1_%2","RscDisplayUnitRoleSelect","ValueName"],controlNull])) exitWith {};
		private _display = uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull];
		["buildControl",[_display,"RscDisplayUnitRoleSelect"]] call MPSF_fnc_virtualArmoury;

		private _roles = ["getCfgRoles",[side group player,true]] call MPSF_fnc_cfgRoles;
		private _currentRole = ["getUnitRole",[player]] call MPSF_fnc_cfgRoles;
		private _ctrlListUnitRoles = uiNamespace getVariable [format["%1_%2","RscDisplayUnitRoleSelect","ValueName"],controlNull];
		lnbclear _ctrlListUnitRoles;
		private _selIndex = 0;
		{
			_x params ["_roleID","_sideID","_displayName","_icon","_limit","_crewman","_pilotHeli","_pilotPlane","_medic","_engineer","_explosiveSpecialist","_UAVHacker","_Halo"];

			private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_cfgRoles) isEqualTo _roleID});
			private _strCount = str _countRoles;
			if (_limit > 0 && _limit < 99) then { _strCount = _strCount + "/" + str _limit; };

			private _lbAdd = _ctrlListUnitRoles lnbaddrow [_displayName,"",_strCount];
			if !(_icon isEqualTo "") then {
				_ctrlListUnitRoles lnbsetpicture [[_lbAdd,0],_icon];
			};
			if (_currentRole isEqualTo _roleID) then {
				_ctrlListUnitRoles lnbsetcolor [[_lbAdd,0],[1,0.78,0,1]];
				_selIndex = _lbAdd;
			};
			if (_countRoles < _limit || _limit <= 0) then {
				_ctrlListUnitRoles lnbSetData [[_lbAdd,0],_roleID];
			} else {
				_ctrlListUnitRoles lnbSetData [[_lbAdd,0],""];
				_ctrlListUnitRoles lbsetvalue [_lbAdd,-1];
				_ctrlListUnitRoles lnbsetcolor [[_lbAdd,0],[1,1,1,0.25]];
			};
		} forEach _roles;
		_ctrlListUnitRoles lbSetCurSel _selIndex;
	};
	case "onListRoleSelect" : {
		_params params [["_ctrlList",controlNull,[controlNull]]];
		uiNamespace setVariable ["PO4_VirtualArmoury_var_selectedRole",_ctrlList lnbData [lnbCurSelRow _ctrlList,0]]
	};
	case "onButtonOkClick" : {
		_params params [["_displayID","",[""]],["_display",uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]]];
		private _roleID = uiNamespace getVariable ["PO4_VirtualArmoury_var_selectedRole",(["getUnitRole",[player]] call MPSF_fnc_cfgRoles)];

		if (_roleID isEqualTo "") exitWith {
			["showMessage",[
				uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]
				,"That role is unavailable to request and assign" // TODO localize
			]] call BIS_fnc_arsenal;
		};

		private _countRoles = count (allPlayers select {(["getUnitRole",[_x]] call MPSF_fnc_cfgRoles) isEqualTo _roleID});
		private _roleLimit = ["getCfgRoleLimit",[_roleID]] call MPSF_fnc_cfgRoles;
		if !(_countRoles < _roleLimit) exitWith {
			["showMessage",[
				uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]
				,"That role has reached its limit of players" // TODO localize
			]] call BIS_fnc_arsenal;
		};

		private _assignState = ["getCfgAssignRoles"] call MPSF_fnc_cfgRoles;
		if (_assignState <= 0) exitWith {
			["showMessage",[
				uiNamespace getVariable ["RscDisplayVirtualArmouryDisplay",displayNull]
				,"Unable to request or assign roles during a mission" // TODO localize
			]] call BIS_fnc_arsenal;
		};

		["onRoleRequest",[player,_roleID],0] call MPSF_fnc_triggerEventHandler;

		if !(isNull _display) then {
			_display closedisplay 2;
		};
	};
	case "init" : {
		["MPSF_VirtualArmoury_arsenalOpened_EH","arsenalOpened",{
			["onArsenalOpened",_this] call MPSF_fnc_rscVirtualArmoury;
		}] call MPSF_fnc_addEventHandler;

		["MPSF_VirtualArmoury_arsenalClosed_EH","arsenalClosed",{
			["onArsenalClosed"] call MPSF_fnc_rscVirtualArmoury;
			[player,"arsenal"] call MPSF_fnc_getUnitLoadout;
		}] call MPSF_fnc_addEventHandler;
	};
};