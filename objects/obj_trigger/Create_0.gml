function scr_apply_action() {
	switch (action) {
		case "SetSequenceSpeed":
			var layerElements = layer_get_all_elements(layerID)
			var translatedAssetID = assetID
			show_debug_message(layerElements)
			for (var i = 0; i <= translatedAssetID; i++) {
				if (!layer_sequence_exists(layerID, layerElements[i])) {
					translatedAssetID += 1
				}
			}
			var targetSequence = layerElements[translatedAssetID]
			layer_sequence_speedscale(targetSequence, abs(value))
			if (value < 0) {
				layer_sequence_headdir(targetSequence, seqdir_left)
			}
			layer_sequence_play(targetSequence)
			break;
	}
}