enum movingHitboxAlarms {
	stopMovement
}

effected = [obj_player, obj_enemy_parent, obj_grenade]

nodeOn = 0

nodeObjects = [instance_create_layer(x, y, layer, obj_node, {movementId : movementId, nodeNumber : 0})]
nodes = []

xSpeed = 0
ySpeed = 0

movementTime = 1
repetitions = 0

wasTouching = []

// add easing later
function scr_move_to_node(time) {
	nodeOn += 1
	if (nodeOn >= array_length(nodes)) {
		nodeOn = 0
	}
	var _nextNode = nodes[nodeOn]
	
	direction = point_direction(x, y, _nextNode.x, _nextNode.y)
	var _distance = point_distance(x, y, _nextNode.x, _nextNode.y)
	xSpeed = dcos(direction) * _distance / time
	ySpeed = -dsin(direction) * _distance / time
	
	alarm[movingHitboxAlarms.stopMovement] = time + 1
}

function scr_squish_object(target) {
	with (target) {
		if (object_is_ancestor(object_index, obj_enemy_parent)) {
			if (place_meeting(x, y, nonpassable)) {
				instance_destroy()
			}
		}
		if (object_index = obj_player) {
			if (place_meeting(x, y, nonpassable)) {
				hitpoints = 0
			}
		}
	}	
}