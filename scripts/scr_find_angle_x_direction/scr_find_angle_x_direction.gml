// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_find_angle_x_direction(angle) {
	if (angle <= 90 or angle > 270) {
		return 1
	}
	else {
		return -1
	}
}