with (obj_node) {
	if (movementId == other.movementId) {
		array_push(other.nodeObjects, id)
		array_push(other.nodes, noone)
	}
}

for (var i = 0; i < array_length(nodeObjects); i++) {
	nodes[nodeObjects[i].nodeNumber] = nodeObjects[i]
}