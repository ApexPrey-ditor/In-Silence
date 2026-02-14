// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_get_room_size(_room=room) {
	switch (_room) {
		case rm_prelude_1_intro:
			return [2752, 1088]
		case rm_prelude_2_sprinting:
			return [2752, 1088]
		case rm_prelude_3_platforming:
			return [2304, 2016]
		case rm_prelude_4_slamming:
			return [2752, 1088]
		case rm_prelude_5_finale:
			return [2304, 1888]
		case rm_scraps_01_intro:
			return [2752, 1088]
		case rm_scraps_02_entrance:
			return [2240, 1088]
		case rm_scraps_03_shack:
			return [960, 480]
		case rm_scraps_04_drone:
			return [2240, 1088]
		case rm_scraps_04_secret_1:
			return [960, 480]
		case rm_scraps_05_wire:
			return [2752, 1088]
		case rm_scraps_06_basement:
			return [960, 480]
		case rm_scraps_07_balcony:
			return [2752, 1088]
		case rm_scraps_07_secret_2:
			return [960, 480]
		case rm_scraps_08_indoors:
			return [2752, 1088]
		case rm_scraps_09_ladder:
			return [2752, 1248]
		case rm_scraps_10_rooftops:
			return [2752, 1248]
		case rm_scraps_11_exit:
			return [2240, 1088]
		case rm_mountainside_01_intro:
			return [1920, 1088]
		case rm_mountainside_02_forest:
			return [2240, 2208]
		case rm_mountainside_03_big:
			return [3328, 2784]
		case rm_mountainside_04_side:
			return [2240, 1344]
	}
}