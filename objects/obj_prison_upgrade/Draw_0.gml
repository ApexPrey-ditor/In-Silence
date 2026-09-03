draw_self()

if (upgrade) {
	draw_text(x, y, struct_get(upgrades, upgradeKey))
}
else {
	draw_text(x, y, struct_get(modifiers, modifier))
}

scr_reset_draw()