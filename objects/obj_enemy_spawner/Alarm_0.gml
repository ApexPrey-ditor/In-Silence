// spawn enemy
instance_create_layer(x, y, layer, enemy, inherit)

amount -= 1

if (amount > 0) {
	alarm[0] = repeatDelay
}
else {
	if (countAsEnemy) {
		global.enemiesLeft -= 1
	}
	
	if (permaDestroy) {
		scr_permanant_destroy()
	}
}