attacking = false

switch weaponSelected {
	case "revolver":
		distanceFromPlayer = global.weaponDistance.revolver
		break
	case "grenade_launcher":
		distanceFromPlayer = global.weaponDistance.grenadeLauncher
		break
}