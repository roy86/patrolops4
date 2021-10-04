/* NPC Helpful Responses */
class npc_help_intro {
	displayText = "Hi, who are you?";
	options[] = {"action_help_introduce","action_help_goodbye"};
};

class npc_help_reIntro {
	displayText = "Hi, %1.";
	options[] = {"action_help_reintroduce","action_help_goodbye"};
	arguments[] = {"name player"};
};

class npc_help_question_1 {
	displayText = "%1, What can I help you with?";
	options[] = {"action_help_askIntel_1","action_help_askIntel_4","action_help_askIntel_5","action_help_goodbye"};
	arguments[] = {"name player"};
};

class npc_help_question_2 {
	displayText = "%1, What do you want?";
	options[] = {"action_help_askIntel_2","action_help_askIntel_3","action_help_askIntel_5","action_help_goodbye"};
	arguments[] = {"name player"};
};

class npc_help_question_3 {
	displayText = "%1, I'm very busy, what do you want?";
	options[] = {"action_help_askIntel_4","action_help_askIntel_2","action_help_askIntel_5","action_help_goodbye"};
	arguments[] = {"name player"};
};

class npc_help_question_4 {
	displayText = "I'm too busy to assist you, Bye. (Scared)";
	endConversation = 1;
};

class npc_help_intel_1 {
	displayText = "%1";
	options[] = {"action_help_goodbye_thanks","action_help_goodbye"};
	arguments[] = {"(_this + [[1,2]]) call PO4_fnc_conversationResponses"};
	code = "['onIntelRecieve',_this,0] call MPSF_fnc_triggerEventHandler;";
	removeAction = 1;
};

class npc_help_intel_2 {
	displayText = "%1";
	options[] = {"action_help_goodbye_thanks","action_help_goodbye"};
	arguments[] = {"(_this + [[2,3]]) call PO4_fnc_conversationResponses"};
	code = "['onIntelRecieve',_this,0] call MPSF_fnc_triggerEventHandler;";
	removeAction = 1;
};

class npc_help_intel_3 {
	displayText = "%1";
	options[] = {"action_help_goodbye_thanks","action_help_goodbye"};
	arguments[] = {"(_this + [[3,4]]) call PO4_fnc_conversationResponses"};
	//code = "['onIntelRecieve',_this,0] call MPSF_fnc_triggerEventHandler;";
	removeAction = 1;
};

class npc_help_goodbye_1 {
	displayText = "Goodbye and good luck %1.";
	arguments[] = {"name player"};
	endConversation = 1;
};

class npc_help_goodbye_2 {
	displayText = "Good luck...";
	endConversation = 1;
};

/* Player Converation Actions */
class action_help_introduce {
	displayText = "Introduce yourself";
	responses[] = {"npc_help_question_1","npc_help_question_2","npc_help_question_3"};
};

class action_help_reintroduce {
	displayText = "Exchange salutations";
	responses[] = {"npc_help_question_1","npc_help_question_2"};
};

class action_help_askIntel_1 {
	displayText = "Ask about any INTEL on enemy";
	responses[] = {"npc_help_intel_1","npc_help_intel_2","npc_help_intel_3"};
};

class action_help_askIntel_2 {
	displayText = "Ask if they have seen any hostile forces nearby";
	responses[] = {"npc_help_intel_2"};
};

class action_help_askIntel_3 {
	displayText = "Ask if they have seen anything recently";
	responses[] = {"npc_help_intel_2","npc_help_intel_3"};
};

class action_help_askIntel_4 {
	displayText = "Ask if everything is ok";
	responses[] = {"npc_help_question_4"};
};

class action_help_askIntel_5 {
	displayText = "Ask if they could point you to the nearest toilet";
	responses[] = {"npc_help_question_4"};
};

class action_help_goodbye_thanks {
	displayText = "Thank them and farewell";
	responses[] = {"npc_help_goodbye_1"};
};

class action_help_goodbye {
	displayText = "Say Goodbye";
	responses[] = {"npc_help_goodbye_1","npc_help_goodbye_2"};
};