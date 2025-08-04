if (picked_up) and (animation_progress < 1) {
	animation_progress += 0.05;
	
	image_xscale = curve(1, 0, animation_progress, ac_player, 1);
	image_yscale = curve(1, 0, animation_progress, ac_player, 1);
}