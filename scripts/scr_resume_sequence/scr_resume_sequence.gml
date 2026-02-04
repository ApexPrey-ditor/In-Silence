// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_resume_sequence(sequenceLayer){
	var prePosition = layer_sequence_get_headpos(sequenceLayer)
	layer_sequence_play(sequenceLayer)
	layer_sequence_headpos(sequenceLayer, prePosition)
}