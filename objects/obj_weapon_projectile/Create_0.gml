enum grenadeAlarms {
	detonate
}

xVelocity = dcos(direction) * speed
grav = -dsin(direction) * speed

speed = 0

solids = scr_get_objects_of_tag("solid")

gravIntensity = baseIntensity
gravLimit = 35

bounceEfficiency = 0.7

alarm[grenadeAlarms.detonate] = detonationTime