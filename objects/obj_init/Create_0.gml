room_goto(rm_test)
//room_goto(rm_mountainside_09_exit)

//audio_group_load(Music)

//game_set_speed(6, gamespeed_fps)

global.weaponsObtained = ["revolver"]
global.stabilizerObtained = true

removeFromRoom = {rm_prelude_1_intro : [],
				rm_scraps_01_intro : [],
				rm_scraps_02_entrance : [],
				rm_scraps_03_shack : [],
				rm_scraps_04_drone : [],
				rm_scraps_05_wire : [],
				rm_scraps_06_basement : [],
				rm_scraps_07_balcony : [],
				rm_scraps_08_indoors : [],
				rm_scraps_09_ladder : [],
				rm_scraps_10_rooftops : [],
				rm_scraps_11_exit : [],
				rm_mountainside_01_intro : [],
				rm_mountainside_02_forest : [],
				rm_mountainside_03_big : [],
				rm_mountainside_04_side : [],
				rm_mountainside_05_climb : [],
				rm_mountainside_06_steep : [],
				rm_mountainside_07_vertical : [],
				rm_mountainside_08_summit : [],
				rm_mountainside_09_exit : []}
				
pausedObjects = []

global.weaponDamage = {
	stabilizer : 5,
	revolver : 3
}

enum roomSize {
	width,
	height
}

enum weaponAlarms {
	notAttacking,
	takeOffCooldown
}

enum attackDurations {
	stabilizer = 10,
	revolver = 10
}

enum attackCooldowns {
	stabilizer = 20,
	revolver = 20
}

enum recoil {
	stabilizer = 10
}

enum weaponDistance {
	stabilizer = 48,
	revolver = 32
}

enum initAlarms {
	unpauseAll
}

if (array_length(global.weaponsObtained) > 0) {
	instance_create_layer(0, 0, "Weapons", obj_weapon, {weaponSelected : global.weaponsObtained[0]})
}
if (global.stabilizerObtained) {
	instance_create_layer(0, 0, "Weapons", obj_stabilizer)
}

// window_set_fullscreen(true)
// game_set_speed(2, gamespeed_fps)