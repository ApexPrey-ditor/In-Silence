/*var pushedVelocity = scr_shove_out(solids)
xVelocity += pushedVelocity[coordinate.xPosition]
grav += pushedVelocity[coordinate.yPosition]*/

grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids)

var _velocityCap = 0
var movement = false

if (!place_meeting(x, y + 1, solids)) {
	_velocityCap = walkSpeed
	
	if (scr_keyboard_check_keys(keybinds.left) and canWalk) {
		xVelocity -= walkSpeed / airControlFactor
		movement = true
	}
	if (scr_keyboard_check_keys(keybinds.right) and canWalk) {
		xVelocity += walkSpeed / airControlFactor
		movement = true
	}
}
else {
	if (scr_keyboard_check_keys(keybinds.left) and canWalk) {
		xVelocity -= walkSpeed
		_velocityCap = walkSpeed
		movement = true
	}
	if (scr_keyboard_check_keys(keybinds.right) and canWalk) {
		xVelocity += walkSpeed
		_velocityCap = walkSpeed
		movement = true
	}
}
if (scr_keyboard_check_keys(keybinds.sprint)) {
	_velocityCap = sprintSpeed
}

if (place_meeting(x, y + 1, solids)) {
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
	if (scr_keyboard_check_keys(keybinds.slam) and abs(xVelocity) > 1) {
		canWalk = false
		isSliding = true
		_velocityCap = infinity
		sprite_index = spr_jimBob_sliding
	}
	else if (isSliding) {
		isSliding = false
		canWalk = true
		sprite_index = spr_jimBob
	}
}
else {
	cayoteFrames -= 1
	
	if (isSliding and !isDiving) {
		isDiving = true
		grav = gravLimit
	}

	if (scr_keyboard_check_keys_pressed(keybinds.slam) and canWalk and !scr_keyboard_check_keys(keybinds.jump)) {
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

if (scr_keyboard_check_keys_pressed(keybinds.jump) and cayoteFrames > 0) {
	cayoteFrames = 0
	grav = -jumpHeight
	
	if (isSliding) {
		isSliding = false
		canWalk = true
		sprite_index = spr_jimBob
	}
}

if (place_meeting(x, y, hurtboxes)) {
	room_restart()
}

if (place_meeting(x, y, obj_ladder)) {
	if (scr_keyboard_check_keys(keybinds.up) and !climbing) {
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
		
		scr_place_move(xMagnitude, yMagnitude, solids)
	}
}
else {
	if (climbing) {
		scr_dismount_ladder()
	}
}

xVelocity = scr_apply_x_velocity(xVelocity, _velocityCap, solids, isDiving)