var _didNotTouch = []

for (var i = 0; i < array_length(wasTouching); i++) {
    if (!place_meeting(x + sign(xSpeed), y - 1, wasTouching[i])) {
		array_push(_didNotTouch, wasTouching[i])
	}
}

x += xSpeed

var _onPlatform = ds_list_create()
instance_place_list(x, y, effected, _onPlatform, false)

for (var i = 0; i < ds_list_size(_onPlatform); i++) {
	var _target = ds_list_find_value(_onPlatform, i)
	array_union(wasTouching, [_target])
	
	while (place_meeting(x, y, _target)) {
		_target.x += scr_plus_minus(xSpeed)
	}
}

y += ySpeed

ds_list_clear(_onPlatform)
instance_place_list(x, y - 1, effected, _onPlatform, false)

for (var i = 0; i < ds_list_size(_onPlatform); i++) {
	var _target = ds_list_find_value(_onPlatform, i)
	array_union(wasTouching, [_target])
	
	with (_target) {
		scr_place_move(other.xSpeed, 0, solids)
	}
	
	while (place_meeting(x, y, _target)) {
		_target.y += scr_plus_minus(ySpeed)
	}
}

for (var i = 0; i < array_length(wasTouching); i++) {
	if (array_contains(_didNotTouch, wasTouching[i]) and instance_exists(wasTouching[i])) {
		wasTouching[i].xVelocity += xSpeed
		wasTouching[i].grav += ySpeed
		
		array_delete(wasTouching, i, 1)
		i--
	}
}