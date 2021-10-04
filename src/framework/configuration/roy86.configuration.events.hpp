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
class CfgMissionEvents {
	// Framework Events
	class onEachFrame {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnEachFrame";
	};
	class onMapClick {
		scope = 1;
		target = -2;
		function = "MPSF_fnc_eventOnMapClick";
	};
	class onKeyDown {
		scope = 2;
		target = -2;
		function = "MPSF_fnc_eventOnKeyDown";
	};
	class onKeyUp {
		scope = 2;
		target = -2;
		function = "MPSF_fnc_eventOnKeyUp";
	};
	class onFired {
		scope = 2;
		target = -2;
		eventTrigger = "Fired";
		function = "MPSF_fnc_eventOnFired";
	};
	class onFiredBaseProtection {
		scope = 2;
		target = -2;
		eventTrigger = "FiredMan";
		function = "MPSF_fnc_eventOnFiredBaseProtection";
	};
	class onTimeChange {
		scope = 2;
		target = -2;
		function = "MPSF_fnc_eventOnTimeChange";
	};
	class onHandleDamage {
		scope = 1;
		target = -2;
		eventTrigger = "HandleDamage";
		function = "MPSF_fnc_eventOnHandleDamage";
	};
	class onHandleRating {
		scope = 2;
		target = -2;
		eventTrigger = "HandleRating";
		function = "MPSF_fnc_eventOnHandleRating";
	};
	class onGetIn {
		scope = 2;
		target = -2;
		eventTrigger = "GetInMan";
		function = "MPSF_fnc_eventOnGetIn";
	};
	class onGetOut {
		scope = 2;
		target = -2;
		eventTrigger = "GetOutMan";
		function = "MPSF_fnc_eventOnGetOut";
	};
	class onSeatSwitch {
		scope = 2;
		target = -2;
		eventTrigger = "SeatSwitchedMan";
		function = "MPSF_fnc_eventOnSeatSwitch";
	};
	class onKilled {
		scope = 2;
		target = -2;
		eventTrigger[] = {"Killed","MPKilled"};
		function = "MPSF_fnc_eventOnKilled";
	};
	class onKilledDropIntel {
		scope = 2;
		function = "MPSF_fnc_eventOnkilledDropIntel";
	};
	class onKilledOrange {
		scope = 1;
		function = "MPSF_fnc_eventOnKilledOrange";
	};
	class onKilledSurrender {
		scope = 2;
		function = "MPSF_fnc_eventOnKilledSurrender";
	};
	class onRespawn {
		scope = 2;
		target = -2;
		eventTrigger[] = {"Respawn","MPRespawn"};
		function = "MPSF_fnc_eventOnRespawn";
	};
	class onPutItem {
		scope = 1;
		target = -2;
		eventTrigger = "Put";
		function = "MPSF_fnc_eventOnPutItem";
	};
	class onTakeItem {
		scope = 2;
		target = -2;
		eventTrigger = "Take";
		function = "MPSF_fnc_eventOnTakeItem";
	};
	class onTaskAssign {
		scope = 2;
		target = -2;
		eventTrigger = "TaskSetAsCurrent";
		function = "MPSF_fnc_eventOnTaskAssign";
	};
	class onHandcuffUnit {
		scope = 2;
		function = "MPSF_fnc_eventOnHandcuffUnit";
	};
	class onHit {
		scope = 1;
		target = 1;
		eventTrigger = "hit";
		function = "MPSF_fnc_eventOnHit";
	};
	class onSmokeThrown {
		scope = 2;
		target = 1;
		function = "MPSF_fnc_eventOnSmokeThrown";
	};
	class HasMoved {
		scope = 2;
		target = -2;
		function = "MPSF_fnc_eventOnHasMoved";
	};
	class onTriggerIED {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnTriggerIED";
	};
	// Weather
	class onWeatherChange {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnWeatherChange";
	};
	// Action Events
	class onAddAction {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnAddAction";
	};
	class onRemoveAction {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnRemoveAction";
	};
	// Task Events
	class onTaskRequestAbort {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnTaskRequestAbort";
	};
	class onTaskUnitKilled {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnTaskUnitKilled";
	};
	class onVehicleReturned {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnVehicleReturned";
	};
	class onTaskObjectDestroyed {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnTaskObjectDestroyed";
	};
	class onObjectDeploy {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnObjectDeploy";
	};
	class onObjectDeployed {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnObjectDeployed";
	};
	class onTaskComplete {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnTaskComplete";
	};
	class onTaskValidate {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnTaskValidate";
	};
	// Intel
	class onIntelCreated {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnIntelCreated";
	};
	class onIntelRecieve {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnIntelRecieve";
	};
	class onIntelPickup {
		scope = 2;
		target = 0;
		function = "MPSF_fnc_eventOnIntelPickup";
	};
	class onIntelDownloadComplete {
		scope = 2;
		target = 2;
		function = "MPSF_fnc_eventOnIntelDownloadComplete";
	};
	// UI
	class onCreateMarker3D {
		scope = 2;
		target = -2;
		function = "MPSF_fnc_eventOnCreateMarker3D";
	};
	class onEachFrame3DIcons {
		scope = 2;
		target = 1;
		function = "MPSF_fnc_eventOnEachFrame3DIcons";
	};
};