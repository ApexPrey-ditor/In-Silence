function scr_add_combo(key) {
	struct_set(global.combo, key, struct_get(global.combo, key) + 1)
	
	global.comboTimeout = comboTimer
}