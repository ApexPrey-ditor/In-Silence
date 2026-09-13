enum NPCUserEvents {
	talked = 0,
	initiatedTalking = 1
}

dialogueKeys = [{character : "", key : 1, portrait : noone}]

talking = false
dialogueOn = 0

dialogueDrawSpeed = 1

function scr_show_dialogue(currentDialogue, drawSpeed, width=baseTextboxWidth, height=baseTextboxHeight) {
	var _text = obj_textbox_manager.scr_get_dialogue(dialogueKeys[currentDialogue].character, dialogueKeys[currentDialogue].key)
	var _portrait = dialogueKeys[currentDialogue].portrait
	obj_textbox_manager.scr_draw_textbox(_text, width, height, drawSpeed, _portrait)
}