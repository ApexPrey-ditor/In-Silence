// Inherit the parent event
event_inherited()

xAcceleration = 0.5 * obj_prison_manager.enemyPower
topXSpeed = 15 * obj_prison_manager.enemyPower
applyFriction = false
weight = 4

calculateMovement = true

walkSpeed = 2

hitpoints = 20 * obj_prison_manager.enemyPower

jumpHeight = 16 * obj_prison_manager.enemyPower
solidJumpRange = 17

jumpRange = 60

flightSpeed = 30 * obj_prison_manager.enemyPower
slamTimer = 15
shockwaveAcceleration = 0.1 * obj_prison_manager.enemyPower
friendlyShockwaveDamage = 1
targetY = 0
targetX = 0

punchRange = 64
punchWindup = 30
parryablePunch = true
drawParryFlash = false
parryableChance = 70
parryRecovery = 90
parryXLaunch = 10
parryYLaunch = -10
parryDamage = 5

canAttack = true
attack = 0
attackPhase = 0

attackOptions = [0, 1, 2]
// 0 = slam at you, 1 = shockwave, 2 = punch
attackCooldown = 30 / obj_prison_manager.enemyPower

// this guy is named greg