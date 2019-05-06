if(!surface_exists(surface)) {
	surface = surface_create(room_width,room_height);
}

surface_set_target(surface);

surface_reset_target();