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

PColor = make_color_hsv(irandom_range(0,225),225,random_range(200,225));
ribbonFallOff = 0.985; //the amount by which the next segment is smaller, 1 = no change, any less than .95 is not desirable.

list = ds_list_create();

enum e_point {
	x,
	y,
	width,
	length,
}

length = 60*2;
width = 10;









