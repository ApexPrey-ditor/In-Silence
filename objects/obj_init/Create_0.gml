room_goto(rm_prison_1)
//room_goto(rm_mountainside_09_exit)

//audio_group_load(Music)

//game_set_speed(3, gamespeed_fps)

global.weaponsObtained = ["revolver", "grenade_launcher"] // "revolver", "grenade_launcher"
global.shotgunObtained = true

global.combo = {baseRevolver : 0,
					baseGrenade : 0,
					baseParry : 0,
					friendlyFire : 0,
					outOfBounds : 0}
global.comboNames = {baseRevolver : "Blunt",
					baseGrenade : "Explosive",
					baseParry : "Reflective",
					friendlyFire : "Tricky",
					outOfBounds : "Out Of Bounds"}
global.comboKills = 0
#macro comboTimer 120
global.comboTimeout = comboTimer

removeFromRoom = {}
				
pausedObjects = []

global.weaponDamage = {
	shotgun : 5,
	revolver : 3,
	grenadeLauncher : 5
}

global.attackDurations = {
	shotgun : 10,
	revolver : 3,
	grenadeLauncher : 6
}

global.attackCooldowns = {
	shotgun : 30,
	revolver : 20,
	grenadeLauncher : 60
}

global.recoil = {
	shotgun : 4,
	revolver : 2,
	grenadeLauncher : 4
}

global.knockback = {
	shotgun : 7,
	revolver : 3,
	grenadeLauncher : 1
}

global.weaponDistance = {
	shotgun : 48,
	revolver : 32,
	grenadeLauncher : 32
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