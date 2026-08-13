// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_pause_objects(objects, ids=[], excludes=[]) {
	array_push(excludes, obj_init)
	
	if (array_length(ids) == 0) {
		for (var i = 0; i < instance_count; i++) {
			if (instance_exists(instance_id[i])) {
				if (!array_contains(excludes, instance_id[i].object_index) and !array_contains(excludes, instance_id[i])) {
					if (objects == all) {
						array_push(obj_init.pausedObjects, instance_id[i])
					}
					else if (array_contains(objects, instance_id[i].object_index)) {
						array_push(obj_init.pausedObjects, instance_id[i])
					}
				}
			}
		}
	}
	else {
		for (var i = 0; i < array_length(ids); i++) {
			if (instance_exists(ids[i])) {
				if (!array_contains(excludes, ids[i].object_index) and !array_contains(excludes, ids[i])) {
					if (objects == all) {
						array_push(obj_init.pausedObjects, ids[i])
					}
					else if (array_contains(objects, ids[i].object_index)) {
						array_push(obj_init.pausedObjects, ids[i])
					}
				}
			}
		}
	}
}