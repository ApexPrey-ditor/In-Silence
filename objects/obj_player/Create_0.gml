enum coordinate {
	xPosition,
	yPosition
}

enum playerAlarms {
	hit
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
#macro baseWalkSpeed 5
walkSpeed = baseWalkSpeed
#macro baseSprintSpeed 15
sprintSpeed = baseSprintSpeed

canWalk = true
isSlamming = false
isDiving = false
isSliding = false

#macro ladderSpeed 7
climbing = false

#macro airResistance 0.97
#macro stepUpHeight 32
xVelocity = 0

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
	gravIntensity = 0
	grav = 0
}

function scr_dismount_ladder() {
	climbing = false
	gravIntensity = baseIntensity
}

function scr_hit(angle, impact = 10, recovery = 30, damage = 1) {
	xVelocity = impact * angle
	grav = -impact
	if (!invincibility) {
		hitpoints -= damage
		invincibility = true
		
		canWalk = false
		alarm[playerAlarms.hit] = recovery
	}
}

solids = [obj_solid_hitbox, obj_destructable, obj_passable]
nonpassable = [obj_solid_hitbox, obj_destructable]
hurtboxes = [obj_hurtbox]

keybinds = {left : [ord("A")],
			right : [ord("D")],
			up : [ord("W")],
			jump : [vk_space],
			sprint : [vk_shift],
			slam : [ord("S"), vk_control],
			shoot : mb_left,
			quickStabilizer : mb_right}