room_goto(rm_prison_1)
//room_goto(rm_mountainside_09_exit)

//audio_group_load(Music)

//game_set_speed(3, gamespeed_fps)

global.weaponsObtained = ["revolver", "grenade_launcher", "energy_rifle", "railcannon"]
global.shotgunObtained = true

global.railcannonCharge = 0
global.railcannonChargeRequirement = 10

global.parryChargeAmount = 3

global.combo = {baseParry : 0,
					baseShotgun : 0,
					baseRevolver : 0,
					baseGrenade : 0,
					baseEnergyRifle : 0,
					baseRailcannon : 0,
					friendlyFire : 0,
					outOfBounds : 0}
global.comboNames = {baseParry : "Reflective",
					baseShotgun : "Point Blank",
					baseRevolver : "Blunt",
					baseGrenade : "Explosive",
					baseEnergyRifle : "Weak",
					baseRailcannon : "Massive",
					friendlyFire : "Tricky",
					outOfBounds : "Out Of Bounds"}
global.comboKills = 0
#macro comboTimer 180
global.comboTimeout = comboTimer

removeFromRoom = {}
				
pausedObjects = []

global.weaponDamage = {
	shotgun : 5,
	revolver : 3,
	grenadeLauncher : 5,
	energyRifle : 1,
	railcannon : 40,
	blaster : 0
}

global.attackDurations = {
	shotgun : 10,
	revolver : 3,
	grenadeLauncher : 6,
	energyRifle : 3,
	railcannon : 1,
	blaster : 3
}

global.attackCooldowns = {
	shotgun : 30,
	revolver : 20,
	grenadeLauncher : 60,
	energyRifle : 7,
	railcannon : 1,
	blaster : 3
}

global.recoil = {
	shotgun : 4,
	revolver : 2,
	grenadeLauncher : 4,
	energyRifle : 1,
	railcannon : 5,
	baster : 0
}

global.knockback = {
	shotgun : 7,
	revolver : 3,
	grenadeLauncher : 1,
	energyRifle : 1,
	railcannon : 15,
	blaster : 0
}

global.weaponDistance = {
	shotgun : 48,
	revolver : 32,
	grenadeLauncher : 32,
	energyRifle : 32,
	railcannon : 32,
	blaster : 32
}

enum initAlarms {
	unpauseAll
}

if (array_length(global.weaponsObtained) > 0) {
	instance_create_layer(0, 0, "Weapons", obj_weapon, {weaponSelected : global.weaponsObtained[0]})
}
if (global.shotgunObtained) {
	instance_create_layer(0, 0, "Weapons", obj_shotgun)
}

 window_set_fullscreen(true)
// game_set_speed(2, gamespeed_fps)