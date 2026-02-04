// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function moment_reset_speed(){
	layer_sequence_speedscale(self.elementID, 1)
	layer_sequence_headdir(self.elementID, seqdir_right)
	layer_sequence_play(self.elementID)
}