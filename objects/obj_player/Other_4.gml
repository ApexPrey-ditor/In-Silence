var entryPointID = scr_find_spawn_point(spawnPointID)

if (instance_exists(entryPointID)) {
	x = entryPointID.bbox_left + ((entryPointID.bbox_right - entryPointID.bbox_left) / 2)
	y = (entryPointID.bbox_top + ((entryPointID.bbox_bottom - entryPointID.bbox_top) * spawnPointOffset)) - (bbox_bottom - y)
}
else {
	show_debug_message("Unable to find entry point")
}