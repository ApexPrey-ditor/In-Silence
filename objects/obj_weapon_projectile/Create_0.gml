enum grenadeAlarms {
	detonate
}

xVelocity = dcos(direction) * speed
grav = -dsin(direction) * speed

speed = 0

solids = scr_get_objects_of_tag("solid")
effected = [obj_player, obj_weapon_projectile, obj_destructable, obj_target]

gravIntensity = baseIntensity
gravLimit = 35

bounceEfficiency = 0.7
blastKnockback = 1

alarm[grenadeAlarms.detonate] = detonationTime