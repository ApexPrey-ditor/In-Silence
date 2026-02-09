switch (room) {
	case rm_prelude_0_init:
		show_debug_message("ye")
		audio_group_stop_all(Music)
		audio_play_sound(TheBeginningOfTheEnd, 0, true)
		room_goto(rm_prelude_1_intro)
		break
	case rm_scraps_0_init:
		audio_group_stop_all(Music)
		audio_play_sound(FuzzyPiano, 0, true)
		room_goto(rm_scraps_1_intro)
		break
}