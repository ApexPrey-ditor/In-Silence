function scr_burst_particles(x, y, xRange, yRange, number, particle, particleSystem) {
	var _emmiter = part_emitter_create(particleSystem)
	part_emitter_region(particleSystem, _emmiter, x - xRange, x + xRange, y - yRange, y + yRange, ps_shape_rectangle, ps_distr_linear)

	part_emitter_burst(particleSystem, _emmiter, particle, number)
	part_emitter_destroy(particleSystem, _emmiter)
}