// h = Horrisontal, v = Verticle
maxRopeSpeed = 4; //Max speed when grappled
hSpeed = 0; 
vSpeed = 0;
walkSpeed = 5; 
walkAcceleration = 1.5;
hFrictionGround = 0.5; //When Sliding Across Ground                               -might not need due to bounce?-
hFrictionAir = 0.005; //When Floating in air and not grappled
rFriction = 0.999; //Air Friction Applied while grappled
jumpSpeed = 6;  //Jump Strength
gravity_ = 0.1; //Standard Gravity
rGravity = 0.2; //Rope Gravity (Acceleration Downwards when rope is active)
hSpeedFraction = 0.0; //???
vSpeedFraction = 0.0; //???


state = pState.normal;

enum pState {
	normal,
	swing
}

/*
Fix angle velocity::

Angle velocity/Length




*/