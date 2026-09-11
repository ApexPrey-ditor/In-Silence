#macro textboxSpacing 16
#macro baseTextboxWidth 512
#macro baseTextboxHeight 128

dialogue = load_csv("dialogue.csv")
dialogueCharacters = ["turtle", "jimbob"]

show_debug_message(dialogue)

textboxWidth = 0
textboxHeight = 0
textboxText = ""
textboxTextOn = 0
textboxPortrait = noone
textboxDrawSpeed = 0
drawTextbox = false

function scr_get_dialogue(character, dialogueNumber) {
	return ds_grid_get(dialogue, array_get_index(dialogueCharacters, character), dialogueNumber)
}

function scr_draw_textbox(text, width, height, drawSpeed, characterPortrait) {
	textboxText = text
	textboxTextOn = 0
	
	textboxWidth = width
	textboxHeight = height
	
	textboxDrawSpeed = drawSpeed
	textboxPortrait = characterPortrait
	
	drawTextbox = true
	
	if (textboxDrawSpeed <= 0) {
		textboxTextOn = string_length(textboxText)
	}
	alarm[0] = textboxDrawSpeed
}