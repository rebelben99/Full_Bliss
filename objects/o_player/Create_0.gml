window_set_cursor(cr_none);
cursor_sprite = Neutral;



// h = Horrisontal, v = Verticle
maxRopeLength = 400;
maxRopeSpeed = 5; //Max speed when grappled
hSpeed = 0; 
vSpeed = 0;
walkSpeed = 10; 
walkAcceleration = 0.5;
hFrictionGround = 0.1; //When Sliding Across Ground                               -might not need due to bounce?-
hFrictionAir = 0.08; //When Floating in air and not grappled
rFriction = 0.99999; //Air Friction Applied while grappled

jumpSpeed = 10;  //Jump Strength
gravity_ = 0.25; //Standard Gravity
rGravity = 0.01; //Rope Gravity (Acceleration Downwards when rope is active)

jumpSpeed = 10;  //Jump Strength
gravity_ = 0.6; //Standard Gravity
rGravity = 0.09; //Rope Gravity (Acceleration Downwards when rope is active)

hSpeedFraction = 0.0; //???
vSpeedFraction = 0.0; //???
hit_play = true;
surface = -1;
hit = 0;

//debug
ropeLengthDebug = true;

state = pState.normal;

enum pState {
	normal,
	swing
}

PColor = make_color_hsv(irandom_range(0,225),0,215);
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










