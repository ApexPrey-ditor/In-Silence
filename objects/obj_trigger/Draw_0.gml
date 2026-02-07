draw_self()

var drawHeightOffset = 64

switch (triggerType) {
	case "Interact":
		if (place_meeting(x, y, obj_player)) {
			draw_text(x, y - drawHeightOffset, "Interact")
		}
}