x_animation = curve(x_previous, x, animation_progress, ac_player, 0);
y_animation = curve(y_previous, y, animation_progress, ac_player, 0);

draw_sprite_ext(sprite_index, image_index, x_animation, y_animation, image_xscale, image_yscale, image_angle, c_white, 1);