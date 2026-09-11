#macro textboxSpacing 16

dialogue = load_csv("dialogue.csv")
dialogueCharacters = []

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