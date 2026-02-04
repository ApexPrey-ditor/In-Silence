enum coordinate {
	xPosition,
	yPosition
}

grav = 0
#macro baseIntensity 0.5
gravIntensity = baseIntensity
gravLimit = 35

jumpHeight = 17

// macros are constants
#macro cayoteFrameLimit 10
cayoteFrames = cayoteFrameLimit

#macro airControlFactor 10
#macro baseWalkSpeed 5
walkSpeed = baseWalkSpeed
#macro baseSprintSpeed 15
sprintSpeed = baseSprintSpeed

canMove = true
isSlamming = false
isDiving = false

#macro ladderSpeed 7
climbing = false

#macro airResistance 0.97
xVelocity = 0

spawnPointID = 0
spawnPointOffset = 0.5

function scr_find_spawn_point(spawnID) {
	var numberOfEntryPoints = instance_number(obj_room_entry_point)
	var entryID = noone
	
	for (var i = 0; i < numberOfEntryPoints; i++) {
		entryID = instance_find(obj_room_entry_point, i)
		if (entryID.ID == spawnID) {
			return entryID
		}
	}
	
	return entryId
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

solids = [obj_solid_hitbox]
hurtboxes = [obj_hurtbox]

keybinds = {left : [ord("A")],
			right : [ord("D")],
			up : [ord("W")],
			jump : [vk_space],
			sprint : [vk_shift],
			slam : [ord("S")]}