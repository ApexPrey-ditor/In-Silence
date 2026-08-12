with (obj_node) {
	if (movementId == other.movementId) {
		array_push(other.nodeObjects, id)
		array_push(other.nodes, [])
	}
}

for (var i = 0; i < array_length(nodeObjects); i++) {
	nodes[nodeObjects[i].nodeNumber] = nodeObjects[i]
}

scr_move_to_node(300)