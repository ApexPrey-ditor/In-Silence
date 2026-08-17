draw_set_colour(c_black)

draw_text(10, 10, xVelocity)
draw_text(10, 25, grav)

var _screenHeight = view_get_hport(view_current)
var _screenWidth = view_get_wport(view_current)

var _combo = ""
var _keyName = ""
var _repeatAmout = 0
var _adjectiveNumber = 0
var _adjectives = []

for (var i = 0; i < array_length(struct_get_names(global.combo)); i++) {
	_keyName = struct_get_names(global.combo)[i]
	
	if (struct_get(global.combo, _keyName) > 0) {
		_adjectiveNumber += 1
		if (_adjectiveNumber % 2 == 0) {
			_combo = _combo + "And "
		}
		
		_repeatAmout = struct_get(global.combo, _keyName) - 1
		
		if (_repeatAmout > 0) {
			for (var w = array_length(repeatNames) - 1; w >= 0; w--) {
				repeat (floor(_repeatAmout / repeatValues[w])) {
					array_push(_adjectives, repeatNames[w])
					_repeatAmout -= repeatValues[w]
				}
			}
		}
		
		for (var w = array_length(_adjectives) - 1; w >= 0; w--) {
			_combo = _combo + _adjectives[w]
		}
		_adjectives = []
		
		_combo = _combo + struct_get(global.comboNames, _keyName) + " "
	}
}

if (_combo != "") {
	if (global.comboKills == 0) {
		_combo = _combo + "Shot"
	}
	else if (global.comboKills == 1) {
		_combo = _combo + "Kill"
	}
	else if (global.comboKills == 2) {
		_combo = _combo + "Double Kill"
	}
	else if (global.comboKills == 3) {
		_combo = _combo + "Triple Kill"
	}
	else if (global.comboKills < 20) {
		_combo = _combo + "Multikill X" + string(global.comboKills)
	}
	else {
		_combo = _combo + "GENOCIDE X" + string(global.comboKills)
	}
	
	draw_healthbar(_screenWidth - 128, 30, _screenWidth - 32, 38, 100 * global.comboTimeout / 120, c_black, c_red, c_orange, 1, false, true)
}
else {
	_combo = "nothing..."	
}

draw_set_halign(fa_right)
draw_text(_screenWidth - 32, 10, "That was a " + _combo)

draw_healthbar(10, _screenHeight - 10, 60, _screenHeight - 20, hitpoints / 5 * 100, c_black, c_red, c_green, 0, true, true)

draw_healthbar(10, _screenHeight - 25, 10 + 50/3, _screenHeight - 35, stamina * 100, c_black, c_blue, c_aqua, 0, true, true)
draw_healthbar(10 + 50/3, _screenHeight - 25, 10 + 50/3*2, _screenHeight - 35, (stamina - 1) * 100, c_black, c_blue, c_aqua, 0, true, true)
draw_healthbar(10 + 50/3*2, _screenHeight - 25, 60, _screenHeight - 35, (stamina - 2) * 100, c_black, c_blue, c_aqua, 0, true, true)

scr_reset_draw()