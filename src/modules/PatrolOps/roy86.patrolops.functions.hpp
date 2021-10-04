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
//class CfgFunctions {
	class PatrolOps {
        tag = "PO4";
        class PatrolOpsCore {
            file = "modules\PatrolOps\functions";
            class createMissionConsole {};
			class missionConsole {postInit = 1;};

            class actionCivilianIntel {};
            class conversationResponses {};
            class encounter {};
            class introSequence {};
            class logreg {};
            class missionConsoleUI {};
		    class missionFlowPlayer { ext = ".fsm"; };
            class PatrolOps { preInit = 1;  postInit = 1; };
        };
    };
//};