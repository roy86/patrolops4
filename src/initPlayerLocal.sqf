/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-05
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params ["_player", "_didJIP"];

// Patrol Ops Logo
[] spawn {
	disableSerialization;
	waitUntil{ !isNull (findDisplay 46) };
	private _ctrlText = (findDisplay 46) ctrlCreate ["RscStructuredText",-1];
	private _sitrep = format ["<t font='PuristaMedium' align='right' size='0.8' shadow='0'>%3<br/>%1<br/>%2</t>",briefingName,getText(missionConfigFile >> "PatrolOpsVersion"),"<img image='framework\data\titles\patrolops_logo_co.paa' size='2.2'/>"];
	_ctrlText ctrlSetStructuredText parseText _sitrep;
	_ctrlText ctrlSetTextColor [1,1,1,0.7];
	_ctrlText ctrlSetBackgroundColor [0,0,0,0];
	_ctrlText ctrlSetPosition [
		(safezoneW - 22 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safeZoneX)
		,(safezoneH - 5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) + (safeZoneY)
		,20 * (((safezoneW / safezoneH) min 1.2) / 40)
		,5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
	];
	_ctrlText ctrlSetFade 0.5;
	_ctrlText ctrlCommit 0;
	true;
};