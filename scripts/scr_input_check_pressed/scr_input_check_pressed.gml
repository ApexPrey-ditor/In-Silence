// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_input_check_pressed(keys){
	for (var i = 0; i < array_length(keys); i++) {
		// 5 is the numerical value assigned to the highest mb constant in gms that being mb_side2
		if (keys[i] <= 5) {
			if (mouse_check_button_pressed(keys[i])) {
				return true
			}
		}
		// otherwise this means the value givin is a key press, not a mouse press
		else {
			if (keyboard_check_pressed(keys[i])) {
				return true
			}
		}
	}
	
	return false
}