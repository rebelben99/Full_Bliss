with(other){
	sprite_index = sprite16;
}
PColor = other.color;

if(colour_get_hue(PColor) <= 80 && colour_get_hue(PColor) >= 300) {
	maxRopeSpeed = 15;
	jumpSpeed = 15;
	gravity_ = 0.6; //Standard Gravity
	rGravity = 0.2;
}
if(colour_get_hue(PColor) > 80 && colour_get_hue(PColor) < 150) {
	gravity_ = 0.6; //Standard Gravity
	rGravity = 0.09;
	jumpSpeed = 10;
	maxRopeSpeed = 5;
}
if(colour_get_hue(PColor) >= 150 && colour_get_hue(PColor) < 300) {
	gravity_ = 0.1; //Standard Gravity
	hFrictionAir = 0.01;
	maxRopeSpeed = 5;
	jumpSpeed = 10;
}