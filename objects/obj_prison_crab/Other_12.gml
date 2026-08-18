if (parryable) {
	if (parryablePunch) {
		scr_add_combo("baseParry")
		hitpoints -= parryDamage
		
		sprite_index = spr_prison_crab
		calculateMovement = true
		applyFriction = true
		attackPhase = -1
		parryable = false
		
		xVelocity = sign(xVelocity) * parryXLaunch
		grav = parryYLaunch
		alarm[0] = parryRecovery
		
		global.railcannonCharge += global.parryChargeAmount
		
		obj_init.alarm[initAlarms.unpauseAll] = baseParryFreezeFrame
		
		scr_pause_objects(all)
	}
}