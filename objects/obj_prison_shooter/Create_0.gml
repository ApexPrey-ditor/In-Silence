// Inherit the parent event
event_inherited()

#macro shooterScale 0.7

image_xscale = image_xscale * shooterScale
image_yscale = image_yscale * shooterScale

xAcceleration = 0.5
walkSpeed = 2

weight = 3

hitpoints = 4 * obj_prison_manager.enemyPower

topXSpeed = 5

range = 512 * obj_prison_manager.enemyPower

friendlyPushback = 7

jumpHeight = 13
solidJumpRange = 15

charging = false
cooldown = 60 / ((obj_prison_manager.enemyPower - 1) / 3 + 1)

friendlyDamage = 2
projectileSpeed = 7