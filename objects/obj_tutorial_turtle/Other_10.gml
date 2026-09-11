// Inherit the parent event
event_inherited()

if (talkable) {
	talking = true
	obj_textbox_manager.scr_draw_textbox(obj_textbox_manager.scr_get_dialogue(dialogueKeys[dialogueOn].character, dialogueKeys[dialogueOn].key), baseTextboxWidth, baseTextboxHeight, dialogueDrawSpeed, dialogueKeys[dialogueOn].portrait)
}