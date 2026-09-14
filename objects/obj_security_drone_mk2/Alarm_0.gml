if (instance_exists(obj_player)) {
	instance_create_layer(x, y, layer, obj_enemy_projectile, {creator : object_index, friendlyDamage : friendlyDamage, direction : point_direction(x, y, obj_player.x, obj_player.y), speed : projectileSpeed})
}

charging = false