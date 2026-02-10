var entryPointID = scr_find_spawn_point(spawnPointID)

if (instance_exists(entryPointID)) {
	x = entryPointID.bbox_left + ((entryPointID.bbox_right - entryPointID.bbox_left) / 2)
	if (sprite_index != spr_jimBob_sliding) {
		y = (entryPointID.bbox_top + ((entryPointID.bbox_bottom - entryPointID.bbox_top) * spawnPointOffset) + (sprite_height * (0.5 - spawnPointOffset)))
	}
	else {
		y = (entryPointID.bbox_top + ((entryPointID.bbox_bottom - entryPointID.bbox_top) * spawnPointOffset) + (sprite_height * (0.5 - spawnPointOffset))) - sprite_height / 2
	}

	show_debug_message(x)
	show_debug_message(bbox_bottom)
}
else {
	show_debug_message("Unable to find entry point")
}