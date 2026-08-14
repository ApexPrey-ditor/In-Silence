//var pushedVelocity = scr_shove_out(nonpassable)
//xVelocity += pushedVelocity[coordinate.xPosition]d a 
//grav += pushedVelocity[coordinate.yPosition]

// does gravity
grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids, nonpassable)

if (place_meeting(x, y, solids)) {
	show_debug_message("Grav Failed")
}

var movement = false
var applyFriction = true

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
		if (scr_keyboard_check_keys(array_union(keybinds.left, keybinds.right))) {
			// pressing keys counts as movement
			movement = true
		}
		// moves if not over walk speed
		if (scr_keyboard_check_keys(keybinds.left) and xVelocity > -walkSpeed) {
			xVelocity -= walkSpeed / airControlFactor
			image_xscale = -1
		}
		if (scr_keyboard_check_keys(keybinds.right) and xVelocity < walkSpeed) {
			xVelocity += walkSpeed / airControlFactor
			image_xscale = 1
		}
	}
	
	// slamming and diving
	if (scr_keyboard_check_keys_pressed(keybinds.slam) and !scr_keyboard_check_keys(keybinds.jump) and canWalk and canMove) {
		if (movement and abs(xVelocity) >= walkSpeed) {
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
	if (scr_keyboard_check_keys(keybinds.slam) and canMove) {
		if (abs(xVelocity) < baseSlideSpeed) {
			// sets slide to base speed if under
			xVelocity = baseSlideSpeed * scr_plus_minus(image_xscale)
		}
		
		if (isDashing) {
			// cancels dash if dashing
			alarm[playerAlarms.cancelDash] = -1
			scr_dash_cancel()
		}
		
		canWalk = false
		isSliding = true
		movement = true
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
		if (scr_keyboard_check_keys(array_union(keybinds.left, keybinds.right))) {
			// pressing keys counts as movement
			movement = true
		}
		// increases velocity, direction, and did movement
		if (scr_keyboard_check_keys(keybinds.left) and xVelocity > -walkSpeed) {
			xVelocity -= walkSpeed
			// if over walkspeed, sets back to walkspeed
			if (abs(xVelocity) > walkSpeed) {
				xVelocity = walkSpeed * scr_plus_minus(xVelocity)
			}
			image_xscale = -1
			movement = true
		}
		if (scr_keyboard_check_keys(keybinds.right) and xVelocity < walkSpeed) {
			xVelocity += walkSpeed
			// if over walkspeed, sets back to walkspeed
			if (abs(xVelocity) > walkSpeed) {
				xVelocity = walkSpeed * scr_plus_minus(xVelocity)
			}
			image_xscale = 1
			movement = true
		}
	}
}

// dashing
if (scr_keyboard_check_keys_pressed(keybinds.dash) and canWalk and stamina >= 1) {
	alarm[playerAlarms.cancelDash] = baseDashDuration
	isDashing = true
	stamina -= 1
	
	if (abs(xVelocity * 1.5) < abs(baseDashSpeed)) {
		xVelocity = sign(image_xscale) * baseDashSpeed
	}
	else {
		xVelocity = sign(image_xscale) * abs(xVelocity) * 1.5
	}
	
	canWalk = false
	
	grav = 0
	gravIntensity = 0
}

// jumping
if (scr_keyboard_check_keys_pressed(keybinds.jump) and cayoteFrames > 0 and canMove) {
	cayoteFrames = 0
	grav = min(grav, 0) - jumpHeight
	applyFriction = false
	
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
	scr_hit(0, 0, 15)
	room_restart()
}

// climing
if (place_meeting(x, y, obj_ladder)) {
	if (scr_keyboard_check_keys(keybinds.up) and !climbing and canMove) {
		scr_mount_ladder()
	}
	else {
		if (scr_keyboard_check_keys_pressed(keybinds.jump) and climbing) {
			scr_dismount_ladder()
			grav = -jumpHeight
		}
	}
	if (climbing) {
		var xMagnitude = 0
		var yMagnitude = 0
		_velocityCap = 0
		
		if (scr_keyboard_check_keys(keybinds.up)) yMagnitude -= ladderSpeed
		if (scr_keyboard_check_keys(keybinds.slam)) yMagnitude += ladderSpeed
		if (scr_keyboard_check_keys(keybinds.left)) xMagnitude -= ladderSpeed
		if (scr_keyboard_check_keys(keybinds.right)) xMagnitude += ladderSpeed
		
		scr_place_move(xMagnitude, yMagnitude, nonpassable)
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
	applyFriction = false
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

xVelocity = scr_apply_x_velocity(xVelocity, solids, applyFriction, nonpassable, xVelocityFrictionless, movement)

if (place_meeting(x, y, solids)) {
	show_debug_message("x Failed")
}