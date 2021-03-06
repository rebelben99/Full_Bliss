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
			vSpeed += -jumpSpeed;
		}
		
		if (keyboard_check_pressed(vk_lalt) || mouse_check_button_pressed(mb_left)) { //when mouse clicked or left alt pressed
			//hook Pos
			grappleX = mouse_x; 
			grappleY = mouse_y;
			//player Pos
			ropeX = x;
			ropeY = y;
			
			ropeAngleVelocity = hSpeed/2; //momentum added here
			
			ropeAngle = point_direction(grappleX,grappleY,x,y); //angle of fire
			
			ropeLength = point_distance(grappleX,grappleY,x,y); //rope length
			
			state = pState.swing;			
		}
		
	}break;
	
	case pState.swing: { //7:25 https://www.youtube.com/watch?v=2prKyETuTaA
		var _ropeAngleAcceleration = -0.2 * dcos(ropeAngle); //rope acceleration downwards, must be multiplied by a negative number
		ropeAngleVelocity += _ropeAngleAcceleration;
		ropeAngle += ropeAngleVelocity;
		ropeAngleVelocity *= 0.999; //air friction
		
		ropeX = grappleX + lengthdir_x(ropeLength,ropeAngle);
		ropeY = grappleY + lengthdir_y(ropeLength,ropeAngle)
		
		hSpeed = ropeX - x;
		vSpeed = ropeY - y;
		
		if(_keyJump) {	
			state = pState.normal;
			vSpeedFraction = 0;
			vSpeed = -jumpSpeed + vSpeed;
		}
		
	}break;
}


hSpeed += hSpeedFraction;
vSpeed += vSpeedFraction;
hSpeedFraction = frac (hSpeed);
vSpeedFraction = frac (vSpeed);
hSpeed -= hSpeedFraction;
vSpeed -= vSpeedFraction;



//Collision w/ terrain
if(place_meeting(x+hSpeed,y,o_wall) || place_meeting(x+hSpeed,y,o_wall2) || place_meeting(x+hSpeed,y,o_wall4 || place_meeting(x+hSpeed,y,o_wall5))) {
	var _hStep = sign(hSpeed);	
	hSpeed = 0;
	hSpeedFraction = 0;
	while(!place_meeting(x+_hStep,y,o_wall)) 
		x += _hStep;
	if (state == pState.swing) {
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity = 0;//bounce
	}
}
x += hSpeed;




if(place_meeting(x,y+vSpeed,o_wall) || place_meeting(x,y+vSpeed,o_wall2) || place_meeting(x,y+vSpeed,o_wall4) || place_meeting(x,y+vSpeed,o_wall5)) {
	var _vStep = sign(vSpeed);	
	vSpeed = 0;
	vSpeedFraction = 0;
	while(!place_meeting(x,y+_vStep,o_wall)) 
		y += _vStep;
	if (state == pState.swing) {
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity = 0;//bounce
	}
}
y += vSpeed;