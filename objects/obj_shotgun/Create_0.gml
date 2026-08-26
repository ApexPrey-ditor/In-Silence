canAttack = true
attacking = false

#macro baseParryFreezeFrame 10
#macro grenadeLifespanIncrease 60

parryables = [obj_enemy_parent, obj_enemy_projectile, obj_destructable, obj_grenade]

hitbackPower = 3

hitChargeAmount = 1.5

damage = global.weaponDamage.shotgun * global.damageMult
knockback = global.knockback.shotgun * global.knockbackMult
attackDuration = global.attackDurations.shotgun * global.durationsMult
attackCooldown = global.attackCooldowns.shotgun * global.cooldownsMult
recoil = global.recoil.shotgun * global.recoilMult

distanceFromPlayer = global.weaponDistance.shotgun

image_alpha = 0