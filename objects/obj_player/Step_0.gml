scr_shove_out(solids)

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
		if (movement and abs(xVelocity) >= walkSpeed) {
			isDiving = true
			grav = gravLimit
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
	grav = -jumpHeight
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

xVelocity = scr_apply_x_velocity(xVelocity, _velocityCap, solids)