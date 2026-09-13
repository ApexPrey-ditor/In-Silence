if (instance_exists(obj_player)) {
	if ((distance_to_object(obj_player) < requiredProximity or talking)
			and scr_input_check_pressed(obj_player.keybinds.interact)
			and talkable) {
		if (talking) {
			if (obj_textbox_manager.textboxTextOn < string_length(obj_textbox_manager.textboxText)) {
				scr_show_dialogue(dialogueOn, 0)
			}
			else {
				obj_textbox_manager.drawTextbox = false
				event_user(NPCUserEvents.talked)
			}
		}
		else {
			scr_show_dialogue(dialogueOn, dialogueDrawSpeed)
			obj_player.canMove = false
			talking = true
		}
	}
}