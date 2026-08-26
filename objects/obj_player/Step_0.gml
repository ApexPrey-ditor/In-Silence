//var pushedVelocity = scr_shove_out(nonpassable)
//xVelocity += pushedVelocity[coordinate.xPosition]d a 
//grav += pushedVelocity[coordinate.yPosition]

// does gravity
grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids, nonpassable)

if (place_meeting(x, y, solids)) {
	//show_debug_message("Grav Failed")
}

var _movement = false
var _applyFriction = true

// directional movement
if (!place_meeting(x, y + 1, solids)) {
	// if in the air
	cayoteFrames -= 1
	
	if (isSliding and !isDiving and canMove) {
		// if sliding, not diving, and can move, initiates a dive
		isDiving = true
		grav = gravLimit
	}
	
	if (canWalk and canMove) {
		// if can walk and move
		if (scr_input_check(array_union(keybinds.left, keybinds.right))) {
			// pressing keys counts as movement
			_movement = true
		}
		// moves if not over walk speed
		if (scr_input_check(keybinds.left) and xVelocity > -walkSpeed) {
			xVelocity -= walkSpeed / airControlFactor
			image_xscale = -1
		}
		if (scr_input_check(keybinds.right) and xVelocity < walkSpeed) {
			xVelocity += walkSpeed / airControlFactor
			image_xscale = 1
		}
	}
	
	// slamming and diving
	if (scr_input_check_pressed(keybinds.slam) and !scr_input_check(keybinds.jump) and canWalk and canMove) {
		if (_movement and abs(xVelocity) >= walkSpeed) {
			// diving
			isDiving = true
			grav = gravLimit
			canWalk = false
		}
		else {
			// slamming
			isSlamming = true
			grav = gravLimit
			xVelocity = 0
			canWalk = false
		}
	}
}
else {
	// if on the ground
	cayoteFrames = cayoteFrameLimit
	
	if (isDiving) {
		// un-dive if diving
		isDiving = false
		canWalk = true
	}
	
	if (isSlamming) {
		// un-slam if slamming
		isSlamming = false
		if (!isSliding) {
			// also give walkability if not coming out of a slide
			canWalk = true
		}
	}
	
	// sliding
	if (scr_input_check(keybinds.slam) and canMove) {
		if (abs(xVelocity) < slideSpeed) {
			// sets slide to base speed if under
			xVelocity = slideSpeed * scr_plus_minus(image_xscale)
		}
		
		if (isDashing) {
			// cancels dash if dashing
			alarm[playerAlarms.cancelDash] = -1
			scr_dash_cancel()
		}
		
		canWalk = false
		isSliding = true
		_movement = true
		sprite_index = spr_jimBob_sliding
	}
	else if (isSliding) {
		// if sliding stopped
		canWalk = true
		sprite_index = spr_jimBob
		image_yscale = 1
		if (place_meeting(x, y, solids)) {
			sprite_index = spr_jimBob_sliding
		}
		else {
			isSliding = false
		}
	}
	
	if (canWalk and canMove) {
		// if able to move
		if (scr_input_check(array_union(keybinds.left, keybinds.right))) {
			// pressing keys counts as movement
			_movement = true
		}
		// increases velocity, direction, and did movement
		if (scr_input_check(keybinds.left) and xVelocity > -walkSpeed) {
			xVelocity -= walkSpeed
			// if over walkspeed, sets back to walkspeed
			if (abs(xVelocity) > walkSpeed) {
				xVelocity = walkSpeed * scr_plus_minus(xVelocity)
			}
			image_xscale = -1
			_movement = true
		}
		if (scr_input_check(keybinds.right) and xVelocity < walkSpeed) {
			xVelocity += walkSpeed
			// if over walkspeed, sets back to walkspeed
			if (abs(xVelocity) > walkSpeed) {
				xVelocity = walkSpeed * scr_plus_minus(xVelocity)
			}
			image_xscale = 1
			_movement = true
		}
	}
}

dashBuffer -= 1
if (scr_input_check_pressed(keybinds.dash)) {
	dashBuffer = baseDashBuffer
}

// dashing
if (scr_input_check_pressed(keybinds.dash) and canWalk and stamina >= 1) {
	alarm[playerAlarms.cancelDash] = baseDashDuration
	isDashing = true
	stamina -= 1
	
	if (abs(xVelocity * 1.5) < abs(dashSpeed)) {
		xVelocity = sign(image_xscale) * dashSpeed
	}
	else {
		xVelocity = sign(image_xscale) * abs(xVelocity) * 1.5
	}
	
	canWalk = false
	
	grav = 0
	gravIntensity = 0
}

jumpBuffer -= 1
if (scr_input_check_pressed(keybinds.jump)) {
	jumpBuffer = baseJumpBuffer
}

// jumping
if (jumpBuffer > 0 and cayoteFrames > 0 and canMove) {
	cayoteFrames = 0
	grav = -jumpHeight
	_applyFriction = false
	
	if (isDashing) {
		alarm[playerAlarms.cancelDash] = -1
		scr_dash_cancel()
	}
	if (isSliding) {
		isSliding = false
		canWalk = true
		sprite_index = spr_jimBob

		// jumping out gives speed
		xVelocity += scr_plus_minus(image_xscale) * baseSlideBoost
	}
}

if (place_meeting(x, y, hurtboxes)) {
	scr_hit()
}

if (hitpoints <= 0) {
	scr_reset_player()
	room_restart()
}

// climing
if (place_meeting(x, y, obj_ladder)) {
	if (scr_input_check(keybinds.up) and !climbing and canMove) {
		scr_mount_ladder()
	}
	else {
		if (scr_input_check_pressed(keybinds.jump) and climbing) {
			scr_dismount_ladder()
			grav = -jumpHeight
		}
	}
	if (climbing) {
		var _xMagnitude = 0
		var _yMagnitude = 0
		_velocityCap = 0
		
		if (scr_input_check(keybinds.up)) _yMagnitude -= ladderSpeed
		if (scr_input_check(keybinds.slam)) _yMagnitude += ladderSpeed
		if (scr_input_check(keybinds.left)) _xMagnitude -= ladderSpeed
		if (scr_input_check(keybinds.right)) _xMagnitude += ladderSpeed
		
		scr_place_move(_xMagnitude, _yMagnitude, nonpassable)
	}
}
else {
	if (climbing) {
		scr_dismount_ladder()
	}
}

if (stamina < maxStamina) {
	stamina += 1 / staminaRegenDuration
}

if (isDiving or isSliding or isDashing) {
	frictionlessFrames = baseFrictionlessFrames
	
}
if (frictionlessFrames > 0) {
	_applyFriction = false
	frictionlessFrames -= 1
}

for (var i = 0; i < array_length(afterImages); i++) {
	afterImages[i].alpha -= afterImageDissapearRate
	
	if (afterImages[i].alpha <= 0) {
		array_delete(afterImages, i, 1)
		i--
	}
}

if (abs(xVelocity) > baseDashSpeed or -grav > jumpHeight) {
	if (afterImageCooldown <= 0) {
		array_push(afterImages, {sprite : sprite_index, subimage : image_index, x : x, y : y, xScale : image_xscale, yScale : image_yscale, alpha : 0.5})
		afterImageCooldown = afterImageBaseCooldown
	}
	else {
		afterImageCooldown -= abs(xVelocity) + abs(grav)
	}
}

global.comboTimeout -= 1

if (global.comboTimeout == 0) {
	for (var i = 0; i < array_length(struct_get_names(global.combo)); i++) {
		struct_set(global.combo, struct_get_names(global.combo)[i], 0)
	}
	
	global.comboKills = 0
}

xVelocity = scr_apply_x_velocity(xVelocity, solids, _applyFriction, nonpassable, xVelocityFrictionless, _movement)

if (place_meeting(x, y, solids)) {
	//show_debug_message("x Failed")
}