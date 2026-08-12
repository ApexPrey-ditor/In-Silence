enum movingHitboxAlarms {
	stopMovement
}

nodeOn = 0
	
nodeObjects = [instance_create_layer(x, y, layer, obj_node, {movementId : movementId, nodeNumber : 0})]
nodes = []

xSpeed = 0
ySpeed = 0

wasTouching = false

// add easing later
function scr_move_to_node(time) {
	nodeOn =+ 1
	var _nextNode = nodes[nodeOn]
	
	direction = point_direction(x, y, _nextNode.x, _nextNode.y)
	var _distance = point_distance(x, y, _nextNode.x, _nextNode.y)
	xSpeed = dcos(direction) * _distance / time
	ySpeed = -dsin(direction) * _distance / time
	
	alarm[movingHitboxAlarms.stopMovement] = time + 1
}