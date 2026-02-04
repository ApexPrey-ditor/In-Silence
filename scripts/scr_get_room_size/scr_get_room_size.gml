// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_get_room_size(_room=room) {
	switch (_room) {
		case rm_prelude_1_intro:
			return [2752, 1088]
		case rm_prelude_2_sprinting:
			return [2752, 1088]
		case rm_prelude_3_platforming:
			return [2304, 1888]
		case rm_prelude_4_slamming:
			return [2752, 1088]
		case rm_prelude_5_finale:
			return [2304, 1888]
	}
}