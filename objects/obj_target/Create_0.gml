event_inherited()

nextTriggers = []

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
	for (var i = 0; i < array_length(nextTriggers); i++) {
		nextTriggers[i].scr_trigger_effect()
	}
}