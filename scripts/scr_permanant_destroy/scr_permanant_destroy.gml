function scr_permanant_destroy(){
	var newList = array_concat(struct_get(obj_init.removeFromRoom, room_get_name(room)), [id])

	struct_set(obj_init.removeFromRoom, room_get_name(room), newList)
}