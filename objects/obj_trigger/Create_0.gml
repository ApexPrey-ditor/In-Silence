function scr_apply_action() {
	switch (action) {
		case "SetSequenceSpeed":
			var layerElements = layer_get_all_elements(layerID)
			var translatedAssetID = assetID
			for (var i = 0; i <= translatedAssetID; i++) {
				if (!layer_sequence_exists(layerID, layerElements[i])) {
					translatedAssetID += 1
				}
			}
			layer_sequence_speedscale(layerElements[translatedAssetID], value)
			break;
	}
}