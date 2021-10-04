["MPSF_chairSitDown_action",player,"Sit Down",{
	player switchmove "Crew";  
	player attachTo [cursorObject,[0,-.2, -.5]]; 
	player setdir 180;
	missionNamespace setVariable ["isSitting",true];
},[],"cursorObject isKindof 'Land_CampingChair_V1_F' || cursorObject isKindof 'Land_CampingChair_V2_F'",true] call MPSF_fnc_addAction;

["MPSF_chairStandUp_action",player,"Stand Up",{
	missionNamespace setVariable ["isSitting",false];
},[],"missionNamespace getVariable ['isSitting',false];",true] call MPSF_fnc_addAction;