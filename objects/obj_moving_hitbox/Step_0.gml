x += xSpeed

var didNotTouch = true

if (place_meeting(x, y, obj_player)) {
	wasTouching = true
	didNotTouch = false
	
	while (place_meeting(x, y, obj_player)) {
		obj_player.x += scr_plus_minus(xSpeed)
	}
}

y += ySpeed

if (place_meeting(x, y - 1, obj_player)) {
	wasTouching = true
	didNotTouch = false
	
	obj_player.x += xSpeed
	
	while (place_meeting(x, y, obj_player)) {
		obj_player.y += scr_plus_minus(ySpeed)
	}
}

if (wasTouching and didNotTouch) {
	wasTouching = false
	
	obj_player.xVelocity += xSpeed
	obj_player.grav += ySpeed
}