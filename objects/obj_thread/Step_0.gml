if (tied_to != noone) {
	if !(following_player) {
		image_xscale = (point_distance(x, y, tied_to.x, tied_to.y) - 8) / sprite_get_width(spr_thread);
	} else {
		image_xscale = point_distance(x, y, obj_grid_player.x_animation, obj_grid_player.y_animation) / sprite_get_width(spr_thread);	
		if (obj_grid_player.animation_progress >= 1) {
			following_player = false;
			obj_grid_player.image_xscale = 1.1;
			obj_grid_player.image_yscale = 1.1;
		}
	}
	image_angle = point_direction(x, y, tied_to.x, tied_to.y);
}