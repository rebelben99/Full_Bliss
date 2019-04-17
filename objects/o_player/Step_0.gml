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
			









/*
//Calculate Movement
var move = key_right - key_left; // 1=right, 0=stand, -1=left

hsp = move * walksp; //horisontal move speed.

vsp = vsp + grv;

//jump check
if (place_meeting(x,y+1,o_wall)) && (key_jump) {
	vsp = -10;
}


//Horisontal Collision
if (place_meeting(x+hsp,y,o_wall)) //placemeeting = boolean collision check
{
	while (!place_meeting(x+sign(hsp),y,o_wall)) { //sign = returns 1 or -1 depending on positive or negative variable
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp; //Change in horisontal position.

//Verticle Collision
if (place_meeting(x,y+vsp,o_wall)) //placemeeting = boolean collision check
{
	while (!place_meeting(x,y+sign(vsp),o_wall)) { //sign = returns 1 or -1 depending on positive or negative variable
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp; //Change in horisontal position.
*/