var pushedVelocity = scr_shove_out(nonpassable)
//xVelocity += pushedVelocity[coordinate.xPosition]
//grav += pushedVelocity[coordinate.yPosition]

grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids, nonpassable)

var _velocityCap = 0
var movement = false

if (!place_meeting(x, y + 1, solids)) {
	_velocityCap = walkSpeed
	
	if (canWalk and canMove) {
		if (scr_keyboard_check_keys(keybinds.left)) {
			xVelocity -= walkSpeed / airControlFactor
			image_xscale = -1
			movement = true
		}
		if (scr_keyboard_check_keys(keybinds.right)) {
			xVelocity += walkSpeed / airControlFactor
			image_xscale = 1
			movement = true
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
if (scr_keyboard_check_keys(keybinds.sprint) and canMove) {
	_velocityCap = sprintSpeed
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
		if (abs(xVelocity) < walkSpeed) {
			xVelocity = walkSpeed * scr_plus_minus(image_xscale)
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

xVelocity = scr_apply_x_velocity(xVelocity, _velocityCap, solids, isDiving, nonpassable, xVelocityFrictionless)