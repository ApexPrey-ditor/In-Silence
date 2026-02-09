if (action == "SetSongVolume") {
	var level = min(1, max((distance_to_object(obj_player) - minDistance) / (maxDistance - minDistance), 0))
	
	audio_sound_gain(targetID, (level * (maxValue - minValue)) + minValue)
}