event_inherited()


if (trigger == "touch") {
	if (place_meeting(x, y, obj_player)) {
		scr_trigger_effect()
	}
}
if (trigger == "touchEnemy") {
	if (place_meeting(x, y, obj_enemy_parent)) {
		scr_trigger_effect()
	}
}
if (trigger == "always" and not (oneTime and waiting)) {
	scr_trigger_effect()
}