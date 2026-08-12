enum coordinate {
	xPosition,
	yPosition
}

enum playerAlarms {
	hit,
	removeFrictionlessXVelocity,
	cancelDash
}

grav = 0
#macro baseIntensity 0.5
gravIntensity = baseIntensity
gravLimit = 35

jumpHeight = 17

// macros are constants
#macro cayoteFrameLimit 6
cayoteFrames = cayoteFrameLimit

#macro airControlFactor 10
#macro baseWalkSpeed 7
walkSpeed = baseWalkSpeed
#macro baseSlideSpeed 13
#macro baseSlideBoost 4

#macro baseDashSpeed 20
#macro baseDashDuration 15
#macro maxStamina 3
#macro staminaRegenDuration 60
stamina = 3
isDashing = false

canWalk = true
canMove = true
isSlamming = false
isDiving = false
isSliding = false

#macro baseLadderSpeed 7
ladderSpeed = baseLadderSpeed
climbing = false

#macro airResistance 0.97
#macro groundResistance 0.7
#macro stepUpHeight 32
xVelocity = 0
xVelocityFrictionless = 0

hitpoints = 5
invincibility = false

spawnPointID = 0
spawnPointOffset = 1

function scr_find_spawn_point(spawnID) {
	var numberOfEntryPoints = instance_number(obj_room_entry_point)
	var entryID = noone
	
	for (var i = 0; i < numberOfEntryPoints; i++) {
		entryID = instance_find(obj_room_entry_point, i)
		if (entryID.ID == spawnID) {
			return entryID
		}
	}
	
	return entryID
}

function scr_mount_ladder() {
	climbing = true
	canWalk = false
	gravIntensity = 0
	grav = 0
	xVelocity = 0
}

function scr_dismount_ladder() {
	climbing = false
	canWalk = true
	gravIntensity = baseIntensity
}

function scr_dash_cancel() {
	isDashing = false
	canWalk = true

	gravIntensity = baseIntensity
	if (abs(xVelocity) > baseDashSpeed) {
		xVelocity = max(abs(xVelocity) / 1.5, baseDashSpeed) * sign(xVelocity)
	}
	xVelocity = xVelocity * 1.2
}

function scr_hit(angle, impact = 10, recovery = 30, damage = 1) {
	xVelocity = impact * angle
	grav = -impact
	xVelocityFrictionless = 0
	canWalk = true
	
	alarm[playerAlarms.hit] = recovery
	
	if (climbing) {
		scr_dismount_ladder()
	}
	
	if (!invincibility) {
		hitpoints -= damage
		invincibility = true
		
		canMove = false
		alarm[playerAlarms.hit] = recovery
	}
}

solids = [obj_solid_hitbox, obj_moving_hitbox, obj_destructable, obj_passable]
nonpassable = [obj_solid_hitbox, obj_moving_hitbox, obj_destructable]
hurtboxes = [obj_hurtbox]

keybinds = {left : [ord("A")],
			right : [ord("D")],
			up : [ord("W")],
			jump : [vk_space, ord("W")],
			dash : [vk_shift],
			slam : [ord("S"), vk_control],
			shoot : mb_left,
			quickShotgun : mb_right}