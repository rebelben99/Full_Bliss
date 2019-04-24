grounded = (place_meeting(x,y+1,o_wall));
//Keybinds::
var _keyLeft = keyboard_check(ord("A"));
var _keyRight = keyboard_check(ord("D"));
var _keyUp = keyboard_check(ord("W"));
var _keyDown = keyboard_check(ord("S"));
var _keyJump = keyboard_check_pressed(vk_space);








var size_list = ds_list_size(list);
if (size_list >= length){
	var grid = list[| 0];
	if ds_exists(grid,ds_type_grid) {
		ds_grid_destroy(grid);
	}
	ds_list_delete(list,0);
}

//add a point each step//
var grid = ds_grid_create(1,e_point.length)
grid[# 0, e_point.x] = o_player.x;
grid[# 0, e_point.y] = o_player.y;
grid[# 0, e_point.width] = width;
ds_list_add(list, grid);













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
		
		if(ropeAngleVelocity > maxRopeSpeed) { ////////////////////Create Script using code to limit Value1 to a positive and negative Value2
			ropeAngleVelocity = maxRopeSpeed;
		}
		if(ropeAngleVelocity < -maxRopeSpeed) {
			ropeAngleVelocity = -maxRopeSpeed;
		}
		
		ropeAngle += ropeAngleVelocity/(ropeLength/150);
		
		ropeAngleVelocity *= rFriction; //air friction when swinging
		
		//Rope Length Controlls
		if _keyDown && ropeLength >= 10 { //reel rope in ("s" and ?)
			ropeLength -= 2;
		}
		if _keyUp && ropeLength <= 500 { //push rope out ("w" and ?)
			ropeLength += 2;
		}
		
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
