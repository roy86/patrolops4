/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2021-03-20
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_groupID",grpNull,[grpNull]]];

if (isNull _groupID) exitWith {};

private _leader = (leader _groupID) call BIS_fnc_netID;

[format['MPSF_groupQRF_%1_EH',_leader],'onEachFrame',compile format ["
	private _leader = (%1) call BIS_fnc_objectFromNetId;
	if (behaviour _leader isEqualTo 'COMBAT') then {
		['MPSF_groupQRF_%1_EH','onEachFrame'] call MPSF_fnc_removeEventHandler;
		[_leader,'FactionTypeOPF'] call MPSF_fnc_createQRFresponse;
	};
	if !(alive _leader) then {
		['MPSF_groupQRF_%1_EH','onEachFrame'] call MPSF_fnc_removeEventHandler;
	};
",_leader]] call MPSF_fnc_addEventHandler;

true;