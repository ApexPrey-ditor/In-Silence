targetObject = noone
ableToTrigger = true

if (delay > 0) {
	ableToTrigger = false
}

function scr_trigger_effect() {
	if (ableToTrigger) {
		for (var i = 0; i < array_length(action); i++) {
			switch action[i] {
				case "playSong":
					audio_play_sound(assetId, 0, true)
					break
				case "setCameraZoom":
					obj_camera.scr_camera_scale(value1, value2)
					break
				case "triggerSpawner":
					with (obj_enemy_spawner) {
						if (spanwerId == other.targetId) {
							other.targetObject = id
						}
					}
				
					if (targetObject != noone) {
						targetObject.scr_start_spawner()
					}
					break
				case "triggerMovingPlatform":
					with (obj_moving_hitbox) {
						if (movementId == other.targetId) {
							other.targetObject = id
						}
					}
				
					if (targetObject != noone) {
						if (value2 == -1) {
							value2 = infinity
						}
					
						targetObject.movementTime = value1
						targetObject.repetitions = value2
					
						targetObject.scr_move_to_node(value1)
					}
					break
				case "triggerTrigger":
					with (obj_trigger) {
						if (triggerId == other.nextTriggerID) {
							other.targetObject = id
						}
					}
				
					if (targetObject != noone) {
						targetObject.scr_trigger_effect()
					}
					break
			}
		}
	
		if (oneTime) {
			if (permaDestroy) {
				scr_permanant_destroy()
			}
			instance_destroy()
		}
	}
	else {
		alarm[0] = delay
	}
}