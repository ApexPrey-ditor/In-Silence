if (drawTextbox) {
	var _screenHeight = view_get_hport(view_current)
	var _screenWidth = view_get_wport(view_current)
	
	var _textboxLeft = (_screenWidth - textboxWidth) / 2
	var _textboxTop = _screenHeight - textboxHeight - textboxSpacing
	var _textDrawX = _textboxLeft + textboxSpacing
	
	draw_set_colour(c_black)
	draw_rectangle(_textboxLeft, _textboxTop, _textboxLeft + textboxWidth, _textboxTop + textboxHeight, false)
	
	if (textboxPortrait != noone) {
		draw_sprite(textboxPortrait, 0, _textDrawX, _textboxTop + textboxSpacing)
		_textDrawX += sprite_get_width(textboxPortrait) + textboxSpacing
	}
	
	draw_set_colour(c_white)
	scr_draw_text_coloured(_textDrawX, _textboxTop + textboxSpacing, string_copy(textboxText, 0, textboxTextOn), 1, 1, string_height("|"), textboxWidth - (_textDrawX - _textboxLeft) - textboxSpacing)

	draw_rectangle(_textboxLeft, _textboxTop, _textboxLeft + textboxWidth, _textboxTop + textboxHeight, true)
}