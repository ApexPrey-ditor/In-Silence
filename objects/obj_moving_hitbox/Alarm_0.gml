// stops movement

xSpeed = 0
ySpeed = 0

if (repetitions > 0) {
	repetitions -= 1
	scr_move_to_node(movementTime)
}