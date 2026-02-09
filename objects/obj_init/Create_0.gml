room_goto(rm_scraps_1_intro)
//room_goto(rm_prelude_1_intro)

audio_group_load(Music)

//game_set_speed(6, gamespeed_fps)

global.weaponsObtained = []
global.stabilizerObtained = false

global.weaponsObtained = ["revolver"]
global.stabilizerObtained = true

removeFromRoom = {rm_prelude_1_intro : [],
				rm_scraps_1_intro : [],
				rm_scraps_2_entrance : [],
				rm_scraps_3_shack : [],
				rm_scraps_4_drone : [],
				rm_scraps_5_wire : [],
				rm_scraps_6_basement : [],
				rm_scraps_7_balcony : []}

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

if (array_length(global.weaponsObtained) > 0) {
	instance_create_layer(0, 0, "Weapons", obj_weapon, {weaponSelected : global.weaponsObtained[0]})
}
if (global.stabilizerObtained) {
	instance_create_layer(0, 0, "Weapons", obj_stabilizer)
}

window_set_fullscreen(true)