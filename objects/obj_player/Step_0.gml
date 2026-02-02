grav = scr_apply_gravity(grav, gravIntensity, gravLimit, solids)

var _velocityCap = 0
var movement = false

if (!place_meeting(x, y + 1, solids)) {
	_velocityCap = walkSpeed
	
	if (scr_keyboard_check_keys(keybinds.left) and canMove) {
		xVelocity -= walkSpeed / airControlFactor
		movement = true
	}
	if (scr_keyboard_check_keys(keybinds.right) and canMove) {
		xVelocity += walkSpeed / airControlFactor
		movement = true
	}
}
else {
	if (scr_keyboard_check_keys(keybinds.left) and canMove) {
		xVelocity -= walkSpeed
		_velocityCap = walkSpeed
		movement = true
	}
	if (scr_keyboard_check_keys(keybinds.right) and canMove) {
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
		gravIntensity = baseIntensity
		canMove = true
	}
	if (isSlamming) {
		isSlamming = false
		canMove = true
	}
}
else {
	cayoteFrames -= 1
	
	if (scr_keyboard_check_keys(keybinds.slam) and canMove and !scr_keyboard_check_keys(keybinds.jump)) {
		if (xVelocity >= sprintSpeed and movement) {
			isDiving = true
			grav = abs(xVelocity)
			gravIntensity = 0
			canMove = false
		}
		else {
			isSlamming = true
			grav = gravLimit
			xVelocity = 0
			canMove = false
		}
	}
}

if (scr_keyboard_check_keys_pressed(keybinds.jump) and cayoteFrames > 0) {
	cayoteFrames = 0
	grav = -20
}

xVelocity = scr_apply_x_velocity(xVelocity, _velocityCap, solids)

if (place_meeting(x, y, hurtboxes)) {
	room_restart()
}