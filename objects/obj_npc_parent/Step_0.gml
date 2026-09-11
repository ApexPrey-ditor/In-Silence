if (instance_exists(obj_player)) {
	if ((distance_to_object(obj_player) < requiredProximity or talking)
			and scr_input_check_pressed(obj_player.keybinds.interact)
			and talkable) {
		if (talking) {
			if (obj_textbox_manager.textboxTextOn < string_length(obj_textbox_manager.textboxText)) {
				obj_textbox_manager.scr_draw_textbox(obj_textbox_manager.scr_get_dialogue(dialogueKeys[dialogueOn].character, dialogueKeys[dialogueOn].key), baseTextboxWidth, baseTextboxHeight, 0, dialogueKeys[dialogueOn].portrait)
			}
			else {
				obj_textbox_manager.drawTextbox = false
				event_user(NPCUserEvents.talked)
			}
		}
		else {
			obj_textbox_manager.scr_draw_textbox(obj_textbox_manager.scr_get_dialogue(dialogueKeys[dialogueOn].character, dialogueKeys[dialogueOn].key), baseTextboxWidth, baseTextboxHeight, dialogueDrawSpeed, dialogueKeys[dialogueOn].portrait)
			obj_player.canMove = false
			talking = true
		}
	}
}