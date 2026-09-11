dialogue = load_csv("dialogue.csv")
dialogueCharacters = []

function scr_get_dialogue(character, dialogueNumber) {
	return ds_grid_get(dialogue, array_get_index(dialogueCharacters, character), dialogueNumber)
}