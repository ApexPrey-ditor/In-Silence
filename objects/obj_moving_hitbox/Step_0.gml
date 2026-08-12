var _didNotTouch = false

if (!place_meeting(x, y - 1, obj_player) and wasTouching) {
	_didNotTouch = true
}

x += xSpeed

if (place_meeting(x, y, obj_player)) {
	wasTouching = true
	
	while (place_meeting(x, y, obj_player)) {
		obj_player.x += scr_plus_minus(xSpeed)
	}
}

y += ySpeed

if (place_meeting(x, y - 1, obj_player)) {
	wasTouching = true
	
	obj_player.x += xSpeed
	
	while (place_meeting(x, y, obj_player)) {
		obj_player.y += scr_plus_minus(ySpeed)
	}
}

if (wasTouching and _didNotTouch) {
	wasTouching = false
	
	obj_player.xVelocity += xSpeed
	obj_player.grav += ySpeed
}