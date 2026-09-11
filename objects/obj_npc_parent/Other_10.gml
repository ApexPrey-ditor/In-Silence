// talked
dialogueOn += 1

if (instance_exists(obj_player)) {
	obj_player.canMove = true
}

if (dialogueOn >= array_length(dialogueKeys)) {
	talkable = false
}