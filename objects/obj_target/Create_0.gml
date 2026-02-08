nextTrigger = noone

function scr_trigger_target() {
	if (delay > 0) {
		alarm[0] = delay
	}
	else {
		scr_apply_target_action()
	}
	
	if (destroy) {
		instance_destroy()
	}
}

function scr_apply_target_action() {
	with (nextTrigger) {
		scr_apply_with_delay()
	}
}