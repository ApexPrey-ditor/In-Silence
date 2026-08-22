event_inherited()

inherit = {permakill : false}

for (var i = 0; i < array_length(inheritKeys); i++) {
	struct_set(inherit, inheritKeys[i], inheritValues[i])
}

if (not triggered) {
	scr_start_spawner()
}

function scr_start_spawner() {
	if (amount == -1) {
		amount = infinity
	}

	if (amount > 0) {
		if (repeatDelay > 0) {
			alarm[0] = repeatDelay
		}
		else {
			repeat (amount) {
				instance_create_layer(x, y, layer, enemy, inherit)
			}
		}
	}
}