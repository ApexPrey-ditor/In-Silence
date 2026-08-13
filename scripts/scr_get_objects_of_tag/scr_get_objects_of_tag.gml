function scr_get_objects_of_tag(tag) {
	objects = tag_get_assets(tag)

	var _return_asset = function (_element, _index) {
		return asset_get_index(_element)
	}

	return array_map(objects, _return_asset)
}