grav = 0
#macro baseIntensity 0.5
gravIntensity = 0.5
gravLimit = 25

jumpHeight = 17

// macros are constants
#macro cayoteFrameLimit 10
cayoteFrames = cayoteFrameLimit

#macro airControlFactor 10
walkSpeed = 5
sprintSpeed = 15

canMove = true
isSlamming = false
isDiving = false

xVelocity = 0

solids = [obj_solid_hitbox]
hurtboxes = [obj_hurtbox]

keybinds = {left : [ord("A")],
			right : [ord("D")],
			jump : [vk_space],
			sprint : [vk_shift],
			slam : [ord("S")]}