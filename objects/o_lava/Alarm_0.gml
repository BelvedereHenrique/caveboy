/// @description Create lava particles
with(instance_create_layer(x - sprite_width + random(sprite_width), y - sprite_height / 2  - 1, "Lava", o_particle)){
	image_blend = c_yellow;
}

alarm[0] = random_range(30,60);