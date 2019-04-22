// h = Horrisontal, v = Verticle
hSpeed = 0; 
vSpeed = 0;
walkSpeed = 5; 
walkAcceleration = 1.5;
hFrictionGround = 0.5;
hFrictionAir = 0.05; //orginally 0
jumpSpeed = 6;
gravity_ = 0.1; 
hSpeedFraction = 0.0;
vSpeedFraction = 0.0;
state = pState.normal;

enum pState {
	normal,
	swing
}