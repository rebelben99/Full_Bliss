if (state == pState.swing) {
	draw_line_width(grappleX,grappleY,ropeX,ropeY,2);
}

draw_set_color(color);

draw_primitive_begin(pr_trianglestrip);
	var size_list = ds_list_size(list);
	for (var i = 0; i < size_list-1; i++) {
		var gridP1 = list[| i];
		var gridP2 = list[| i+1];
		
		var x1 = gridP1[# 0, e_point.x];
		var y1 = gridP1[# 0, e_point.y];
		var w1 = gridP1[# 0, e_point.width];
		
		var x2 = gridP1[# 0, e_point.x];
		var y2 = gridP1[# 0, e_point.y];
		var w2 = gridP1[# 0, e_point.width];
		
		var dir = point_direction(x1,y1,x2,y2);
		var otho_dir1 = dir + 90;
		var otho_dir2 = dir - 90;
		
		draw_vertex(x1 + lengthdir_x(w1, otho_dir1), y1 + lengthdir_y(w1, otho_dir1));
		draw_vertex(x1 + lengthdir_x(w1, otho_dir2), y1 + lengthdir_y(w1, otho_dir2));
		draw_vertex(x2 + lengthdir_x(w2, otho_dir1), y2 + lengthdir_y(w2, otho_dir1));
		draw_vertex(x2 + lengthdir_x(w2, otho_dir2), y2 + lengthdir_y(w2, otho_dir2));
	}



draw_primitive_end();

draw_self();