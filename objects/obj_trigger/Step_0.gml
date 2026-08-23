event_inherited()


if (trigger == "touch") {
	if (place_meeting(x, y, obj_player) and not (oneTime and waiting)) {
		scr_trigger_effect()
	}
}
if (trigger == "always") {
	scr_trigger_effect()
}