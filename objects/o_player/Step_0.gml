grounded = (place_meeting(x,y+1,o_wall));
//Keybinds::
var _keyLeft = keyboard_check(ord("A"));
var _keyRight = keyboard_check(ord("D"));
var _keyUp = keyboard_check(ord("W"));
var _keyDown = keyboard_check(ord("S"));
var _keyJump = keyboard_check_pressed(vk_space);




switch (state) {
	case pState.normal: {
		var dir = _keyRight - _keyLeft; // 1=right, 0=stand, -1=left
		hSpeed += dir * walkAcceleration;
		
		if (dir == 0) { //if standing still
			var hFriction = hFrictionGround;
			if (!grounded) hFriction = hFrictionAir;
			hSpeed = Approach(hSpeed,0,hFriction);
		}
		hSpeed = clamp(hSpeed,-walkSpeed,walkSpeed);
		
		vSpeed += gravity_;
		
		if (_keyJump) && (grounded) {
			grounded = false;
			vSpeedFraction = 0;
			vSpeed = -jumpSpeed;
		}
		
		if (mouse_check_button_pressed(mb_left)) { //when mouse clicked
			//hook Pos
			grappleX = mouse_x; 
			grappleY = mouse_y;
			//player Pos
			ropeX = x;
			ropeY = y;
			
			ropeAngleVelocity = 0; //momentum added here
			
			ropeAngle = point_direction(grappleX,grappleY,x,y); //angle of fire
			
			ropeLength = point_distance(grappleX,grappleY,x,y); //rope length
			
			state = pState.swing;			
		}
		
	}break;
	
	case pState.swing: { //7:25 https://www.youtube.com/watch?v=2prKyETuTaA
		
	}break;
}


hSpeed += hSpeedFraction;
vSpeed += vSpeedFraction;
hSpeedFraction = frac (hSpeed);
vSpeedFraction = frac (vSpeed);
hSpeed -= hSpeedFraction;
vSpeed -= vSpeedFraction;



//Collision w/ terrain
if(place_meeting(x+hSpeed,y,o_wall)) {
	var _hStep = sign(hSpeed);	
	hSpeed = 0;
	hSpeedFraction = 0;
	while(!place_meeting(x+_hStep,y,o_wall)) 
		x += _hStep;
}
x += hSpeed

if(place_meeting(x,y+vSpeed,o_wall)) {
	var _vStep = sign(vSpeed);	
	vSpeed = 0;
	vSpeedFraction = 0;
	while(!place_meeting(x,y+_vStep,o_wall)) 
		y += _vStep;
}
y += vSpeed
