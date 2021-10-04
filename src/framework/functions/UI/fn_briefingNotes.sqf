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
if !(hasInterface) exitWith {};

/* private _diaryNotes = ["CfgMissionFramework","DiaryNotes"] call BIS_fnc_getCfg;
{
//    [] call MPSF_fnc_createDiaryNote;
} forEach _diaryNotes;
 */
["MPSF_Framework_Note","Actions","Weapon Holster"
	,format["<font size='16' face='PuristaLight'>Weapon Holstering</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>If you wish to holster your weapon, you can press the weapon selecter action for 1 second while holding that weapon to holster it.<br/><br/>%1<br/>%2<br/>%3"
	,format ["- Primary Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchPrimary",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchPrimary",1]}]
	,format ["- Handgun Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchHandgun",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchHandgun",1]}]
	,format ["- Secondary Weapon: <font color='#ffC600'>%1</font>",if (actionKeysNames ["SwitchSecondary",1] isEqualTo "") then {"Undefined"} else {actionKeysNames ["SwitchSecondary",1]}]
]] spawn {sleep 0.125; _this call MPSF_fnc_createDiaryNote;};