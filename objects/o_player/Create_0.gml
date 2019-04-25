window_set_cursor(cr_cross)

// h = Horrisontal, v = Verticle
maxRopeSpeed = 4; //Max speed when grappled
hSpeed = 0; 
vSpeed = 0;
walkSpeed = 5; 
walkAcceleration = 0.5;
hFrictionGround = 0.5; //When Sliding Across Ground                               -might not need due to bounce?-
hFrictionAir = 0.005; //When Floating in air and not grappled
rFriction = 0.99999; //Air Friction Applied while grappled
jumpSpeed = 6;  //Jump Strength
gravity_ = 0.1; //Standard Gravity
rGravity = 0.1; //Rope Gravity (Acceleration Downwards when rope is active)
hSpeedFraction = 0.0; //???
vSpeedFraction = 0.0; //???


state = pState.normal;

enum pState {
	normal,
	swing
}

color = make_color_rgb(0,100,100);

list = ds_list_create();

enum e_point {
	x,
	y,
	width,
	length,
}

length = 60;
width = 10;