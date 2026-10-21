if (sprite_index == spr_jimBob_jump) {
	image_speed = 0
	image_index = image_index - 1
}
if (sprite_index == spr_jimBob_land) {
	isInAnimation = false
}
if (sprite_index == spr_jimBob_crouch_down) {
	sprite_index = spr_jimBob_sliding
}
if (sprite_index == spr_jimBob_crouch_up) {
	isInAnimation = false
}