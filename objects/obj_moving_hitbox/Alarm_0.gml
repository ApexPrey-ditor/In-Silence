// stops movement

if (launch) {
	for (var i = 0; i < array_length(wasTouching); i++) {
		wasTouching[i].xVelocity += xSpeed
		wasTouching[i].grav += ySpeed
		
		with (wasTouching[i]) {
			scr_place_move(other.xSpeed, other.ySpeed, solids)
		}
		
		array_delete(wasTouching, i, 1)
		i--
	}
}

xSpeed = 0
ySpeed = 0

if (repetitions > 0) {
	repetitions -= 1
	scr_move_to_node(movementTime)
}