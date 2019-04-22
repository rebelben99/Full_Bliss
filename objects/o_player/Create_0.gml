// h = Horrisontal, v = Verticle
hSpeed = 0; 
vSpeed = 0;
walkSpeed = 12; 
walkAcceleration = 1.5;
hFrictionGround = 0.5;
hFrictionAir = 0.2; //orginally 0
jumpSpeed = 7;
gravity_ = 0.2; 
hSpeedFraction = 0.0;
vSpeedFraction = 0.0;
state = pState.normal;

enum pState {
	normal,
	swing
}