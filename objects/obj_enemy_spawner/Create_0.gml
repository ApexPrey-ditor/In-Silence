event_inherited()

inherit = {permakill : false}

for (var i = 0; i < array_length(inheritKeys); i++) {
	struct_set(inherit, inheritKeys[i], inheritValues[i])
}

function scr_start_spawner() {
	if (onlyCountWhenActivated) {
		global.enemiesLeft += 1
	}
	
	if (amount == -1) {
		amount = infinity
	}
	else {
		if (repeatDelay > 0) {
			alarm[0] = repeatDelay
		}
		else {
			repeat (amount) {
				instance_create_layer(x, y, layer, enemy, inherit)
			}
			
			instance_destroy()
		}
	}
}