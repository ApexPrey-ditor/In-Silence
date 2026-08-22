targetObjects = []
ableToTrigger = true
waiting = false

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
						if (spawnerId == other.targetId) {
							array_push(other.targetObjects, id)
						}
					}
				
					for (var m = 0; m < array_length(targetObjects); m++) {
						targetObjects[m].scr_start_spawner()
					}
					break
				case "triggerMovingPlatform":
					with (obj_moving_hitbox) {
						if (movementId == other.targetId) {
							array_push(other.targetObjects, id)
						}
					}
					if (value2 == -1) {
						value2 = infinity
					}
					
					for (var m = 0; m < array_length(targetObjects); m++) {
						targetObjects[m].movementTime = value1
						targetObjects[m].repetitions = value2
					
						targetObjects[m].scr_move_to_node(value1)
					}
					break
				case "triggerTrigger":
					with (obj_trigger) {
						if (triggerId == other.nextTriggerID) {
							array_push(other.targetObjects, id)
						}
					}
				
					for (var m = 0; m < array_length(targetObjects); m++) {
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
		waiting = true
		alarm[0] = delay
	}
}