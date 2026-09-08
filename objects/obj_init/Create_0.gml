randomise()

room_goto(rm_prison_init)
//room_goto(rm_temp_tutorial)

//audio_group_load(Music)

//game_set_speed(6, gamespeed_fps)

global.weaponsObtained = ["revolver", "grenade_launcher", "energy_rifle", "railcannon"]
//global.weaponsObtained = ["revolver", "grenade_launcher", "energy_rifle", "railcannon", "debug_gun"]
global.shotgunObtained = true

global.railcannonCharge = 0
global.railcannonChargeRequirement = 10

global.parryChargeAmount = 3

global.combo = {baseParry : 0,
					baseShotgun : 0,
					baseRevolver : 0,
					baseGrenade : 0,
					baseEnergyRifle : 0,
					baseRailcannon : 0,
					friendlyFire : 0,
					envirokill : 0,
					outOfBounds : 0}
global.comboNames = {baseParry : "Reflective",
					baseShotgun : "Point Blank",
					baseRevolver : "Blunt",
					baseGrenade : "Explosive",
					baseEnergyRifle : "Weak",
					baseRailcannon : "Massive",
					friendlyFire : "Tricky",
					envirokill : "Environmental",
					outOfBounds : "Out Of Bounds"}
global.comboKills = 0
#macro comboTimer 180
global.comboTimeout = comboTimer

global.enemiesLeft = 0

removeFromRoom = {}
				
pausedObjects = []

global.damageMult = 1
enum baseWeaponDamage {
	shotgun = 5,
	revolver = 3,
	grenadeLauncher = 5,
	energyRifle = 1,
	railcannon = 40
}
global.weaponDamage = {
	shotgun : baseWeaponDamage.shotgun,
	revolver : baseWeaponDamage.revolver,
	grenadeLauncher : baseWeaponDamage.grenadeLauncher,
	energyRifle : baseWeaponDamage.energyRifle,
	railcannon : baseWeaponDamage.railcannon
}

global.durationsMult = 1
enum baseWeaponDuration {
	shotgun = 10,
	revolver = 3,
	grenadeLauncher = 6,
	energyRifle = 3,
	railcannon = 1
}
global.attackDurations = {
	shotgun : baseWeaponDuration.shotgun,
	revolver : baseWeaponDuration.revolver,
	grenadeLauncher : baseWeaponDuration.grenadeLauncher,
	energyRifle : baseWeaponDuration.energyRifle,
	railcannon : baseWeaponDuration.railcannon
}

global.cooldownsMult = 1
enum baseWeaponCooldown {
	shotgun = 30,
	revolver = 20,
	grenadeLauncher = 60,
	energyRifle = 7,
	railcannon = 1
}
global.attackCooldowns = {
	shotgun : baseWeaponCooldown.shotgun,
	revolver : baseWeaponCooldown.revolver,
	grenadeLauncher : baseWeaponCooldown.grenadeLauncher,
	energyRifle : baseWeaponCooldown.energyRifle,
	railcannon : baseWeaponCooldown.railcannon
}

global.recoilMult = 1
enum baseWeaponRecoil {
	shotgun = 4,
	revolver = 2,
	grenadeLauncher = 4,
	energyRifle = 1,
	railcannon = 5
}
global.recoil = {
	shotgun : baseWeaponRecoil.shotgun,
	revolver : baseWeaponRecoil.revolver,
	grenadeLauncher : baseWeaponRecoil.grenadeLauncher,
	energyRifle : baseWeaponRecoil.energyRifle,
	railcannon : baseWeaponRecoil.railcannon
}

global.knockbackMult = 1
enum baseWeaponKnockback {
	shotgun = 7,
	revolver = 3,
	grenadeLauncher = 50,
	energyRifle = 1,
	railcannon = 15
}
global.knockback = {
	shotgun : baseWeaponKnockback.shotgun,
	revolver : baseWeaponKnockback.revolver,
	grenadeLauncher : baseWeaponKnockback.grenadeLauncher,
	energyRifle : baseWeaponKnockback.energyRifle,
	railcannon : baseWeaponKnockback.railcannon,
}

global.weaponDistance = {
	shotgun : 48,
	revolver : 32,
	grenadeLauncher : 32,
	energyRifle : 32,
	railcannon : 32,
	blaster : 32
}

enum baseAugments {
	shotgunRangeMultiplier = 1,
	grenadeExplosionRadiusMultiplier = 1,
	grenadeSizeMultiplier = 1,
	energyRifleSpreadIncrement = 0
}
global.augments = {
	shotgunRangeMultiplier : baseAugments.shotgunRangeMultiplier,
	grenadeExplosionRadiusMultiplier : baseAugments.grenadeExplosionRadiusMultiplier,
	grenadeSizeMultiplier : baseAugments.grenadeSizeMultiplier,
	energyRifleSpreadIncrement : baseAugments.energyRifleSpreadIncrement
}

enum initAlarms {
	unpauseAll
}

if (array_length(global.weaponsObtained) > 0) {
	instance_create_layer(0, 0, "Weapons", obj_weapon, {weaponSelected : global.weaponsObtained[0]})
}
if (global.shotgunObtained) {
	instance_create_layer(0, 0, "Weapons", obj_shotgun)
}

 window_set_fullscreen(true)
// game_set_speed(2, gamespeed_fps)

// holy moly its 10,000 lines of particle effects

// main particle system
psMain = part_system_create();
part_system_draw_order(psMain, true);

// blood trail
pBloodTrail = part_type_create();
part_type_shape(pBloodTrail, pt_shape_square);
part_type_size(pBloodTrail, 1, 1, 0, 0);
part_type_scale(pBloodTrail, 0.2, 0.2);
part_type_speed(pBloodTrail, 0, 0, 0, 0);
part_type_direction(pBloodTrail, 80, 100, 0, 0);
part_type_gravity(pBloodTrail, 0, 270);
part_type_orientation(pBloodTrail, 0, 0, 0, 0, true);
part_type_colour3(pBloodTrail, $0000CC, $0000B2, $000099);
part_type_alpha3(pBloodTrail, 0.392, 0.196, 0);
part_type_blend(pBloodTrail, false);
part_type_life(pBloodTrail, 10, 10);

// blood
pBlood = part_type_create();
part_type_shape(pBlood, pt_shape_square);
part_type_size(pBlood, 0.8, 1.2, 0, 0);
part_type_scale(pBlood, 0.2, 0.2);
part_type_speed(pBlood, 7, 13, -0.05, 0);
part_type_direction(pBlood, 0, 360, 0, 0);
part_type_gravity(pBlood, 0.35, 270);
part_type_orientation(pBlood, 0, 360, 2, 0, false);
part_type_colour3(pBlood, $0000FF, $0000E5, $0000CC);
part_type_alpha3(pBlood, 1, 0.784, 0);
part_type_blend(pBlood, false);
part_type_life(pBlood, 80, 80);
part_type_step(pBlood, 1, pBloodTrail);