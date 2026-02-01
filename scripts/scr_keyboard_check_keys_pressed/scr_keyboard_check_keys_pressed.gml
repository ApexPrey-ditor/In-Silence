// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_keyboard_check_keys_pressed(keys){
	for (var i = 0; i < array_length(keys); i++) {
		if (keyboard_check_pressed(keys[i])) {
			return true
		}
	}
	
	return false
}