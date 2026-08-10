function scr_trigger_effect() {
	for (var i = 0; i < array_length(action); i++) {
		switch action[i] {
			case "playSong":
				audio_play_sound(asset_id, 0, true)
				break
		}
	}
	
	if (oneTime) {
		scr_permanant_destroy()
		instance_destroy()
	}
}