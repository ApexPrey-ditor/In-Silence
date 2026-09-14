if (permakill) {
	scr_permanant_destroy()
}

if (activated) {
	scr_burst_particles(x, y, sprite_width / 2, sprite_height / 2, min(sqrt(abs(sprite_width * sprite_height)) / 2 + abs(hitpoints) * 5, 1000), obj_init.pBlood, obj_init.psMain)
	
	if (sprite_exists(deathSprite)) {
		for (var i = 0; i < sprite_get_number(deathSprite); i++) {
			instance_create_layer(irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), layer, obj_enemy_bits,
				{sprite_index : deathSprite, image_index : i, xVelocity : random_range(-bitsXVarience, bitsXVarience), grav : random_range(-bitsYVarience, 0)})
		}
	}
}

global.enemiesLeft -= 1