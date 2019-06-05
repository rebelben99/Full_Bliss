draw_set_color(PColor);
if (state == pState.swing) {
	//draw_line_width(grappleX,grappleY,ropeX,ropeY,2);
	draw_sprite_ext(ropesprite,0,x,y, ropeLength/4000, 0.1, ropeAngle, PColor, 1 );

/*chainWidth = sprite_get_width(s_wall); //Your chain sprite here
chainLength = ropeLength; //Get the length of the entire chain.
chainAngle = degtorad(ropeAngle); //get the angle of the chain and convert it from degrees to radians
draw_sprite_ext(ropesprite,0,
(grappleX + (cos(chainAngle)) + (cos(chainAngle) * (chainWidth/2))),
(grappleY - (sin(chainAngle)) + (sin(chainAngle) * (chainWidth/2)))
,scale,scale,ropeAngle,PColor,1);
//*/

}

if(!surface_exists(surface)) {
	surface = surface_create(room_width,room_height);
}
surface_set_target(surface);
//NewPColor = PColor + make_color_hsv(298,0,215);
	//draw_sprite_stretched_ext(watercolorstrip,watercolorstrip,x,y,sprite_width*2, sprite_height*2, PColor, 1 );
	//draw_sprite(watercolorstrip,0,x,y)
	//draw_line_width(x,y,xprevious,yprevious,10);
	if(room == Room2){ draw_sprite_ext(
		
		sprite31 //change THIS to be the chalk sprite
		
		,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	} else if(room == Room3){ draw_sprite_ext(
		
		sprite46 //change THIS to be the marker sprite
		
		,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	} else if(room == Room4){ draw_sprite_ext(
		
		sprite53 //change THIS to be the airbrush sprite
		
		,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	} else if(room == Room5){ draw_sprite_ext(
		
		sprite54 //change THIS to be the frescobrush sprite
		
		,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	} else if(room == Room6){ draw_sprite_ext(
		
		sprite55 //change THIS to be the oilpaint sprite
		
		,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	} else if(room == Room7){ draw_sprite_ext(
		
		sprite53 //change THIS to be the shale sprite
		
		,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	} else {
		draw_sprite_ext(sprite31,image_index,x,y,0.8, 0.8, 0, PColor, 1 );
	}
surface_reset_target();

draw_surface(surface,0,0);


draw_set_color(PColor);


	
/*draw_primitive_begin(pr_trianglestrip);
	var size_list = ds_list_size(list);
	for (var i = 0; i < size_list-1; i++) {
		var gridP1 = list[| i];
		var gridP2 = list[| i+1];
		
		var x1 = gridP1[# 0, e_point.x];
		var y1 = gridP1[# 0, e_point.y];
		var w1 = gridP1[# 0, e_point.width];
		
		var x2 = gridP2[# 0, e_point.x];
		var y2 = gridP2[# 0, e_point.y];
		var w2 = gridP2[# 0, e_point.width];
		
		var dir = point_direction(x1,y1,x2,y2);
		var otho_dir1 = dir + 90;
		var otho_dir2 = dir - 90;
		
		draw_vertex(x1 + lengthdir_x(w1, otho_dir1), y1 + lengthdir_y(w1, otho_dir1));
		draw_vertex(x1 + lengthdir_x(w1, otho_dir2), y1 + lengthdir_y(w1, otho_dir2));
		draw_vertex(x2 + lengthdir_x(w2, otho_dir1), y2 + lengthdir_y(w2, otho_dir1));
		draw_vertex(x2 + lengthdir_x(w2, otho_dir2), y2 + lengthdir_y(w2, otho_dir2));
	}



draw_primitive_end();*/

draw_self();


