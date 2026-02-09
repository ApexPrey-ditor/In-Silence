layerElements = []
translatedAssetID = 0
targetSequence = pointer_null
nextTrigger = noone

// Set up target
switch (action) {
	case "SetSequenceSpeed":
		layerElements = layer_get_all_elements(layerID)
		translatedAssetID = assetID
	
		for (var i = 0; i <= translatedAssetID; i++) {
			if (!layer_sequence_exists(layerID, layerElements[i])) {
				translatedAssetID += 1
			}
		}
		targetSequence = layerElements[translatedAssetID]
		break;
}

// apply to target
function scr_apply_action() {
	with (nextTrigger) {
		scr_apply_with_delay()
	}
	
	switch (action) {
		case "SetSequenceSpeed":
			layer_sequence_speedscale(targetSequence, abs(value))
			if (value < 0) {
				layer_sequence_headdir(targetSequence, seqdir_left)
			}
			else {
				layer_sequence_headdir(targetSequence, seqdir_right)
			}
			scr_resume_sequence(targetSequence)
			break
		case "GoToRoom":
			if (instance_exists(obj_player)) {
				obj_player.spawnPointID = assetID
				obj_player.spawnPointOffset = 1
			}
			room_goto(objectID)
			break
		case "PlaySong":
			audio_play_sound(objectID, 0, true)
			break
		case "SetSongVolume":
			audio_sound_gain(objectID, value, assetID)
			break
		case "StopSongs":
			audio_group_stop_all(Music)
			break
		case "StopSong":
			audio_stop_sound(objectID)
			break
	}
	
	if (oncePerRoom) {
		instance_destroy()
	}
}

// aplies including delay
function scr_apply_with_delay() {
	if (delay > 0) {
		alarm[0] = delay
	}
	else {
		scr_apply_action()
	}
}