var pushedVelocity = scr_shove_out(nonpassable)
//xVelocity += pushedVelocity[coordinate.xPosition]
//grav += pushedVelocity[coordinate.yPosition]

grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids, nonpassable)

var _velocityCap = 0
var movement = false

if (!place_meeting(x, y + 1, solids)) {
	_velocityCap = walkSpeed
	
	if (canWalk and canMove) {
		if (scr_keyboard_check_keys(array_union(keybinds.left, keybinds.right))) {
			movement = true
		}
		if (scr_keyboard_check_keys(keybinds.left) and xVelocity > -walkSpeed) {
			xVelocity -= walkSpeed / airControlFactor
			image_xscale = -1
		}
		if (scr_keyboard_check_keys(keybinds.right) and xVelocity < walkSpeed) {
			xVelocity += walkSpeed / airControlFactor
			image_xscale = 1
		}
	}
}
else {
	if (canWalk and canMove) {
		if (scr_keyboard_check_keys(keybinds.left)) {
			xVelocity -= walkSpeed
			_velocityCap = walkSpeed
			image_xscale = -1
			movement = true
		}
		if (scr_keyboard_check_keys(keybinds.right)) {
			xVelocity += walkSpeed
			_velocityCap = walkSpeed
			image_xscale = 1
			movement = true
		}
	}
}

if (scr_keyboard_check_keys_pressed(keybinds.dash) and canMove and stamina >= 1) {
	alarm[playerAlarms.cancelDash] = baseDashDuration
	xVelocity = sign(image_xscale) * baseDashSpeed
	isDashing = true
	grav = 0
	gravIntensity = 0
	stamina -= 1
}
if (isDashing) {
	movement = true
	_velocityCap = 20
}

var prebbox_bottom = bbox_bottom
image_yscale = 1 / sprite_height
if (place_meeting(x, prebbox_bottom + 1, solids)) {
	cayoteFrames = cayoteFrameLimit
	
	if (isDiving) {
		isDiving = false
		canWalk = true
	}
	if (isSlamming) {
		isSlamming = false
		if (!isSliding) {
			canWalk = true
		}
	}
	if (scr_keyboard_check_keys(keybinds.slam) and canMove) {
		if (abs(xVelocity) < baseSlideSpeed) {
			xVelocity = baseSlideSpeed * scr_plus_minus(image_xscale)
		}
		
		if (isDashing) {
			alarm[playerAlarms.cancelDash] = -1
			isDashing = false
			gravIntensity = baseIntensity
		}
		canWalk = false
		isSliding = true
		_velocityCap = infinity
		sprite_index = spr_jimBob_sliding
	}
	else if (isSliding) {
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
}
else {
	cayoteFrames -= 1
	
	if (isSliding and !isDiving and canMove) {
		isDiving = true
		grav = gravLimit
	}

	if (scr_keyboard_check_keys_pressed(keybinds.slam) and !scr_keyboard_check_keys(keybinds.jump) and canWalk and canMove) {
		if (movement and abs(xVelocity) >= walkSpeed) {
			isDiving = true
			grav = gravLimit
			canWalk = false
		}
		else {
			isSlamming = true
			grav = gravLimit
			xVelocity = 0
			canWalk = false
		}
	}
}
image_yscale = 1

if (scr_keyboard_check_keys_pressed(keybinds.jump) and cayoteFrames > 0 and canMove) {
	cayoteFrames = 0
	grav = -jumpHeight
	
	if (isDashing) {
		alarm[playerAlarms.cancelDash] = -1
		isDashing = false
		gravIntensity = baseIntensity
	}
	if (isSliding) {
		isSliding = false
		canWalk = true
		sprite_index = spr_jimBob
	}
}

if (place_meeting(x, y, hurtboxes)) {
	scr_hit(0, 0, 15)
	room_restart()
}

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

xVelocity = scr_apply_x_velocity(xVelocity, _velocityCap, solids, isDiving, nonpassable, xVelocityFrictionless, movement)