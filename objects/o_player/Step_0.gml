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
			
			
			if(grappleY >= ropeY) {
				ropeAngleVelocity = -hSpeed;
			} else {
				ropeAngleVelocity = hSpeed;
			}
			
			ropeAngle = point_direction(grappleX,grappleY,x,y); //angle of fire
			
			ropeLength = point_distance(grappleX,grappleY,x,y); //rope length
			
			state = pState.swing;			
		}
		
	}break;
	
	case pState.swing: { 
		var _ropeAngleAcceleration = -rGravity * dcos(ropeAngle); //rope acceleration downwards, must be multiplied by a negative number
		ropeAngleVelocity += _ropeAngleAcceleration;
		
		
		
		
		
		
		ropeAngle += ropeAngleVelocity/(ropeLength/150);
		
		
		if(ropeAngleVelocity > maxRopeSpeed) {
			ropeAngleVelocity = maxRopeSpeed;
		}
		if(ropeAngleVelocity < -maxRopeSpeed) {
			ropeAngleVelocity = -maxRopeSpeed;
		}
		
		ropeAngleVelocity *= rFriction; //air friction when swinging
		
		ropeX = grappleX + lengthdir_x(ropeLength,ropeAngle);
		ropeY = grappleY + lengthdir_y(ropeLength,ropeAngle)
		

		vSpeed = ropeY - y;
		hSpeed = ropeX - x;
		
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
if(place_meeting(x+hSpeed,y,o_wall) || place_meeting(x+hSpeed,y,o_border)) {
	var _hStep = sign(hSpeed);	
	
	if (abs(hSpeed) > 1) {
		hSpeed *= -0.7;
	} else {
		hSpeed = 0;
	}
	
	hSpeedFraction = 0;
	while(!place_meeting(x+_hStep,y,o_wall) || place_meeting(x+hSpeed,y,o_border)) 
		x += _hStep;
	if (state == pState.swing) {
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity *= -0.99;//bounce
	}
}
x += hSpeed



if(place_meeting(x,y+vSpeed,o_wall) || place_meeting(x,y+vSpeed,o_border)) {
	var _vStep = sign(vSpeed);	
	
	if(_keyJump) {	
			state = pState.normal;
			vSpeedFraction = 0;
			vSpeed = -jumpSpeed + vSpeed;
		}
	
	if (abs(vSpeed) > 1) {
		vSpeed *= -0.7;
	} else {
		vSpeed = 0;
	}
	
	vSpeedFraction = 0;
	while(!place_meeting(x,y+_vStep,o_wall) || place_meeting(x,y+vSpeed,o_border)) 
		y += _vStep;
	if (state == pState.swing) {
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity *= -0.99;//bounce
	}
}
y += vSpeed
