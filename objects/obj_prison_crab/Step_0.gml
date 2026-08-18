// Inherit the parent event
event_inherited()

if (calculateMovement) {
	grav = scr_apply_gravity(grav, baseIntensity, terminalVelocity, solids)
	xVelocity = scr_apply_x_velocity(xVelocity, solids, applyFriction)
}

// actual AI
if (not doBasicWalk and instance_exists(obj_player)) {
	if (canAttack) {
		canAttack = false
		
		attack = attackOptions[irandom_range(0, array_length(attackOptions) - 1)]
		attackPhase = 0
		// 0 = slam at you, 1 = shockwave, 2 = punch
	}
	else {
		if (attackPhase >= 0) {
			switch (attack) {
				case 0:
					if (attackPhase == 0) {
						applyFriction = false
						image_xscale = scr_plus_minus(obj_player.x - x) * abs(image_xscale)
						xVelocity += sign(image_xscale) * xAcceleration
						xVelocity = clamp(xVelocity, -topXSpeed, topXSpeed)
						
						if (place_meeting(x, y + 1, solids)) {
							if (abs((abs(obj_player.x - x) / abs(xVelocity)) - jumpRange) < 10 and (obj_player.x - x) / xVelocity >= 0) {
								grav = -jumpHeight
								attackPhase += 1
							}
							if (place_meeting(x + xVelocity * solidJumpRange, y, solids) and collision_line(x, y, x + xVelocity * solidJumpRange, y, obj_player, false, true) == noone) {
								grav = -jumpHeight
							}
						}
					}
					else {
						if (abs(obj_player.y - bbox_bottom) < 30 and grav > 0 and attackPhase == 1) {
							sprite_index = spr_prison_crab_kick
							grav = 0
							attackPhase = 2
						}
						if (image_index == sprite_get_number(sprite_index) - 1 and sprite_index == spr_prison_crab_punch) {
							sprite_index = spr_prison_crab
						}
						if (place_meeting(x, y + 1, solids)) {
							sprite_index = spr_prison_crab
							
							alarm[0] = attackCooldown
							applyFriction = true
							attackPhase = -1
						}
					}
					break
				case 1:
					if (attackPhase == 0) {
						if (place_meeting(obj_player.x, obj_player.bbox_bottom - sprite_height / 2, solids)) {
							attack = attackOptions[irandom_range(0, array_length(attackOptions) - 1)]
						}
						else {
							attackPhase += 1
							targetX = obj_player.x
							targetY = obj_player.y
						}
					}
					else if (attackPhase == 1) {
						applyFriction = true
						calculateMovement = false
						y -= flightSpeed
					
						if (bbox_bottom < 0) {
							attackPhase += 1
							x = targetX
						}
					}
					else if (attackPhase < slamTimer) {
						attackPhase += 1
					}
					else if (attackPhase == slamTimer) {
						y += terminalVelocity
					
						if (collision_line(x, y, x, targetY, solids, false, true) == noone and not place_meeting(x, y, solids)) {
							calculateMovement = true
							grav = terminalVelocity
							xVelocity = 0
							attackPhase += 1
						}
					}
					else {
						if (place_meeting(x, y + 1, solids)) {
							instance_create_layer(x, bbox_bottom, layer, obj_enemy_shockwave, {xVelocity : shockwaveSpeed, creator : id, friendlyDamage : friendlyShockwaveDamage})
							instance_create_layer(x, bbox_bottom, layer, obj_enemy_shockwave, {xVelocity : -shockwaveSpeed, creator : id, friendlyDamage : friendlyShockwaveDamage})
							
							alarm[0] = attackCooldown
							attackPhase = -1
						}
					}
					break
				case 2:
					if (attackPhase == 0) {
						applyFriction = false
						image_xscale = scr_plus_minus(obj_player.x - x) * abs(image_xscale)
						xVelocity += sign(image_xscale) * xAcceleration
						xVelocity = clamp(xVelocity, -topXSpeed, topXSpeed)
						
						if (distance_to_object(obj_player) < punchRange) {
							applyFriction = true
							drawParryFlash = true
							attackPhase += 1
							
							parryablePunch = irandom_range(0, 100) < parryableChance
						}
						
						if (place_meeting(x, y + 1, solids)) {
							if (place_meeting(x + xVelocity * solidJumpRange, y, solids) and collision_line(x, y, x + xVelocity * solidJumpRange, y, obj_player, false, true) == noone) {
								grav = -jumpHeight
							}
						}
					}
					else if (attackPhase < punchWindup) {
						attackPhase += 1
					}
					else {
						parryable = true
						drawParryFlash = false
						sprite_index = spr_prison_crab_punch
						
						if (place_meeting(x, y, obj_player)) {
							// bro got hit
						}
						
						if (image_index == sprite_get_number(sprite_index) - 1) {
							alarm[0] = attackCooldown
							
							parryable = false
							sprite_index = spr_prison_crab
							attackPhase = -1
						}
					}
					break
			}
		}
	}
}