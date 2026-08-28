enum coordinate {
	xPosition,
	yPosition
}

enum playerAlarms {
	hit,
	removeFrictionlessXVelocity,
	cancelDash
}

repeatNames = ["Very ", "Super ", "Ultra ", "OMEGA ", "in silence "]
repeatValues = [1, 3, 5, 10, 100]

jumpHeightMult = 1
moveSpeedMult = 1

grav = 0
#macro baseIntensity 0.5
gravIntensity = baseIntensity
gravLimit = 35

jumpHeight = 17 * jumpHeightMult

// macros are constants
#macro cayoteFrameLimit 6
cayoteFrames = cayoteFrameLimit
#macro baseFrictionlessFrames 3
frictionlessFrames = 0

#macro baseJumpBuffer 3
#macro baseDashBuffer 3
jumpBuffer = 0
dashBuffer = 0

#macro airControlFactor 10
#macro baseWalkSpeed 7
walkSpeed = baseWalkSpeed * moveSpeedMult
#macro baseSlideSpeed 13
slideSpeed = baseSlideSpeed * moveSpeedMult
#macro baseSlideBoost 4

#macro baseDashSpeed 20
dashSpeed = baseDashSpeed * moveSpeedMult
#macro baseDashDuration 15
#macro baseMaxStamina 3
maxStamina = baseMaxStamina
#macro staminaRegenDuration 60
stamina = 3
isDashing = false

canWalk = true
canMove = true
isSlamming = false
isDiving = false
isSliding = false

#macro baseLadderSpeed 7
ladderSpeed = baseLadderSpeed * moveSpeedMult
climbing = false

#macro airResistance 0.97
#macro groundResistance 0.7
#macro stepUpHeight 8
xVelocity = 0
xVelocityFrictionless = 0

#macro afterImageDissapearRate 0.05
#macro afterImageBaseCooldown 70
afterImages = []
afterImageCooldown = 0

maxHealth = 5
hitpoints = maxHealth
invincibility = false
weight = 3

spawnPointID = 0
spawnPointOffset = 1

function scr_reset_player() {
	grav = 0
	gravIntensity = baseIntensity
	gravLimit = 35

	jumpHeight = 17 * jumpHeightMult

	cayoteFrames = cayoteFrameLimit
	frictionlessFrames = 0

	jumpBuffer = 0
	dashBuffer = 0

	walkSpeed = baseWalkSpeed * moveSpeedMult
	slideSpeed = baseSlideSpeed * moveSpeedMult

	dashSpeed = baseDashSpeed * moveSpeedMult
	maxStamina = baseMaxStamina
	stamina = 3
	isDashing = false

	canWalk = true
	canMove = true
	isSlamming = false
	isDiving = false
	isSliding = false

	ladderSpeed = baseLadderSpeed * moveSpeedMult
	climbing = false

	xVelocity = 0
	xVelocityFrictionless = 0

	afterImages = []
	afterImageCooldown = 0

	maxHealth = 5
	hitpoints = maxHealth
	invincibility = false
	weight = 3
	
	global.railcannonCharge = 0
	
	global.comboTimeout = 0
	
	for (var i = 0; i < array_length(struct_get_names(global.combo)); i++) {
		struct_set(global.combo, struct_get_names(global.combo)[i], 0)
	}
	
	global.comboKills = 0
	global.enemiesLeft = 0
}

function scr_recalc_stats() {
	jumpHeight = 17 * jumpHeightMult
	
	walkSpeed = baseWalkSpeed * moveSpeedMult
	slideSpeed = baseSlideSpeed * moveSpeedMult

	dashSpeed = baseDashSpeed * moveSpeedMult
	
	ladderSpeed = baseLadderSpeed * moveSpeedMult
}

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

function scr_hit(impact = 10, recovery = 30, damage = 1) {
	if (!invincibility) {
		hitpoints -= damage
		invincibility = true
		
		canMove = true
		canWalk = true
		
		alarm[playerAlarms.hit] = recovery
		
		obj_init.alarm[initAlarms.unpauseAll] = impact
		
		scr_pause_objects(all)
	}
}

solids = scr_get_objects_of_tag("solid")
nonpassable = scr_get_objects_of_tag("nonpassable")
hurtboxes = [obj_hurtbox]

keybinds = {left : [ord("A")],
			right : [ord("D")],
			up : [ord("W")],
			jump : [vk_space, ord("W")],
			dash : [vk_shift],
			slam : [ord("S"), vk_control],
			shoot : [mb_left],
			quickShotgun : [mb_right],
			switchWeapon : [ord("E")],
			switchBackwards : [ord("Q")],
			switchRevolver : [ord("1")],
			switchGrenadeLauncher : [ord("2")],
			switchEnergyRifle : [ord("3")],
			switchRailcannon : [ord("4")],}