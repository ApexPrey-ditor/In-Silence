if (permakill) {
	scr_permanant_destroy()
}

if (activated) {
	scr_burst_particles(x, y, sprite_width / 2, sprite_height / 2, min(sqrt(abs(sprite_width * sprite_height)) / 2, 1000), obj_init.pBlood, obj_init.psMain)
}

global.enemiesLeft -= 1