// Inherit the parent event
event_inherited()

if (not array_contains(stopPoints, dialogueOn)) {
	scr_show_dialogue(dialogueOn, dialogueDrawSpeed)
	event_user(NPCUserEvents.initiatedTalking)
}
else {
	talkable = false
}