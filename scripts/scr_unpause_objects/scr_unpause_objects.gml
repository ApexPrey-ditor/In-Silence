// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unpause_objects(objects, ids=[], excludes=[]) {
	array_push(excludes, obj_init)
	
	if (array_length(ids) == 0) {
		ids = obj_init.pausedObjects
	}
	
	for (var i = 0; i < array_length(ids); i++) {
		try {
			if (!array_contains(excludes, ids[i].object_index) and !array_contains(excludes, ids[i])) {
				if (objects == all) {
					instance_activate_object(ids[i])
					array_delete(obj_init.pausedObjects, i, 1)
					i -= 1
				}
				else if (array_contains(objects, ids[i].object_index)) {
					instance_activate_object(ids[i])
					array_delete(obj_init.pausedObjects, i, 1)
					i -= 1
				}
			}
		}
		catch (expection) {
			show_debug_message("Unpause threw error")
			show_debug_message(expection.message)
			
			array_delete(obj_init.pausedObjects, i, 1)
			i -= 1
		}
	}
}