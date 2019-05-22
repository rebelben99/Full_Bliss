image_blend = PColor;
grounded = (place_meeting(x,y+1,o_wall));
//Keybinds::
var _keyLeft = keyboard_check(ord("A"));
var _keyRight = keyboard_check(ord("D"));
var _keyUp = keyboard_check(ord("W"));
var _keyDown = keyboard_check(ord("S"));
var _keyJump = mouse_check_button_pressed(mb_right);
var _keyDrop = mouse_check_button_pressed(mb_left);

//Length Check
grappleDistance = point_distance(mouse_x,mouse_y,x,y); //distance from crosshair to player

if(grappleDistance <= maxRopeLength) {
	cursor_sprite = cursor_True;
} else {
	cursor_sprite = cursor_False;
}

if(colour_get_hue(PColor) <= 65 && colour_get_hue(PColor) >= 330) {
	maxRopeSpeed = 8;
	gravity_ = 0.6; //Standard Gravity
	rGravity = 0.09;
} else if(colour_get_hue(PColor) > 65 && colour_get_hue(PColor) < 150) {
	gravity_ = 0.6; //Standard Gravity
	rGravity = 0.09;
	maxRopeSpeed = 5;
} else if(colour_get_hue(PColor) >= 150 && colour_get_hue(PColor) < 330) {
	gravity_ = 0.1; //Standard Gravity
	hFrictionAir = 0.01;
	maxRopeSpeed = 5;
}

/*var size_list = ds_list_size(list);
if (size_list >= length){
	var grid = list[| 0];
	if ds_exists(grid,ds_type_grid) {
		ds_grid_destroy(grid);
	}
	ds_list_delete(list,0);
}

//add a point each step//
var grid = ds_grid_create(1,e_point.length);
grid[# 0, e_point.x] = o_player.x;
grid[# 0, e_point.y] = o_player.y;
grid[# 0, e_point.width] = width;
ds_list_add(list, grid);

//test for whether ribbon is constant width or pointed
if(keyboard_check_pressed(vk_numpad1)) { //constant
	ribbonFallOff = 1;
}
if(keyboard_check_pressed(vk_numpad2)) { //pointed
	ribbonFallOff = 0.98;	
}



//refresh width of trail
for (var i = 0; i < size_list; i++) {
	var gridP1 = list[| i];
	gridP1[# 0, e_point.width] *= ribbonFallOff;
}*/









switch (state) {
	case pState.normal: {
		var dir = _keyRight - _keyLeft; // 1=right, 0=stand, -1=left
		//hSpeed += dir * walkAcceleration;
		
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
		
		if (mouse_check_button_pressed(mb_left)) { //when mouse clicked or left alt pressed
			//hook Pos
			grappleX = mouse_x; 
			grappleY = mouse_y;
			//player Pos
			ropeX = x;
			ropeY = y;
			
			if(grappleY >= ropeY) { 		//Rope Direction Fix 1
					ropeAngleVelocity = -hSpeed;			
			} else {
					ropeAngleVelocity = hSpeed;
			}
			
			ropeAngle = point_direction(grappleX,grappleY,x,y); //angle of fire
			
			ropeLength = point_distance(grappleX,grappleY,x,y); //rope length
			
			//Rope Direction Fix 2
			if(ropeAngle mod 360 > 315) { //lower right
				if(sign(hSpeed) = 1 && sign(vSpeed) = 1)
					ropeAngleVelocity *= -1;
			}
			if(ropeAngle mod 360 > 0 && ropeAngle mod 360 < 45) {  //upper right
				if(sign(hSpeed) = 1 && sign(vSpeed) = -1)
					ropeAngleVelocity *= -1;
			}
			
			if(ropeAngle mod 360 > 135 && ropeAngle mod 360 < 180) { //upper left
				if(sign(hSpeed) = -1 && sign(vSpeed) = -1)
					ropeAngleVelocity *= -1;
			}
			if(ropeAngle mod 360 > 180 && ropeAngle mod 360 < 225) { //lower right
				if(sign(hSpeed) = -1 && sign(vSpeed) = 1)
					ropeAngleVelocity *= -1;
			}
			
			
			if(ropeLength <= maxRopeLength) {
				state = pState.swing;	
			} /*else {
				ropeLength = maxRopeLength;
				state = pState.swing;
			}*/
		}
		
	}break;
	
	case pState.swing: { 
		var _ropeAngleAcceleration = -rGravity * dcos(ropeAngle); //rope acceleration downwards, must be multiplied by a negative number
		//_ropeAngleAcceleration += (_keyRight - _keyLeft)*0.08;
		
		ropeAngleVelocity += _ropeAngleAcceleration;
		
		if(ropeAngleVelocity > maxRopeSpeed) { ////////////////////Create Script using code to limit Value1 to a positive and negative Value2
			ropeAngleVelocity = maxRopeSpeed;
		}
		if(ropeAngleVelocity < -maxRopeSpeed) {
			ropeAngleVelocity = -maxRopeSpeed;
		}
		
		var lengthFraction = 150;
		
		ropeAngle += ropeAngleVelocity/(ropeLength/lengthFraction);
		
		ropeAngleVelocity *= rFriction; //air friction when swinging
		
		//Rope Length Controlls
		
			/*if (_keyDown && ropeLength >= 10) { //reel rope in ("s" and ?)
				ropeLength -= 3.5;
			}
			if (_keyUp && ropeLength <= 500) { //push rope out ("w" and ?)
				ropeLength += 3.5;
			}*/
			
		ropeX = grappleX + lengthdir_x(ropeLength,ropeAngle);
		ropeY = grappleY + lengthdir_y(ropeLength,ropeAngle)
		

		vSpeed = ropeY - y;
		hSpeed = ropeX - x;
		
		if(_keyJump ) {	
			state = pState.normal;
			vSpeedFraction = 0;
			vSpeed = -jumpSpeed + vSpeed;
		}
		if(_keyDrop) {	
			state = pState.normal;
			vSpeedFraction = 0;
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
	if(hit_play) { //audio
		if(hit = 0) {
			audio_play_sound(collide, 10, false); 
		}
		/*if(hit = 1) {
			audio_play_sound(sound1, 10, false);
		}*/
		
		hit_play = false;	
		hit += 1;
		if (hit >= 1) {
			hit = 0;
		}
	}
	
	//collision logic
	var _hStep = sign(hSpeed);	
	
	if (abs(hSpeed) > 1) {
		hSpeed *= -0.7;
	} else {
		hSpeed = 0;
	}
	
	hSpeedFraction = 0;
	while(!place_meeting(x+_hStep,y,o_wall) || place_meeting(x+hSpeed,y,o_border)) {
		hit_play = true;
		x += _hStep;
	}
	if (state == pState.swing) {
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity *= -0.99;//bounce
	}
}
x += hSpeed



if(place_meeting(x,y+vSpeed,o_wall) || place_meeting(x,y+vSpeed,o_border)) {
	if(hit_play) { //audio
		if(hit = 0) {
			audio_play_sound(collide, 10, false); 
		}
		/*if(hit = 1) {
			audio_play_sound(sound1, 10, false);
		}*/
		
		hit_play = false;	
		hit += 1;
		if (hit >= 1) {
			hit = 0;
		}
	}
	
	//collision logic
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
	while(!place_meeting(x,y+_vStep,o_wall) || place_meeting(x,y+vSpeed,o_border)) {
		hit_play = true;
		y += _vStep;	
	}
	if (state == pState.swing) {
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity *= -0.99;//bounce
	}
}
y += vSpeed
