if !(surface_exists(gui_surf)) {
	gui_surf = surface_create(obj_window_manager.viewport_width, obj_window_manager.viewport_height);	
}

surface_set_target(gui_surf);

if !(finishing) {

	draw_clear_alpha(c_black, 0);

	draw_set_font(fnt_game);

	var _scale = 3;

	draw_set_halign(fa_center)
	draw_set_valign(fa_center)

	draw_set_color(c_yellow);

	var _string = string(array_length(inventory)) + "/" + string(instance_number(obj_grid_pickup_objective));

	if (collect_objectives_message) {
		draw_set_color(c_red);
		_string = "Get yellow!"
		_scale = 2;
	}

	var _offset_y = curve(0, (string_height(_string) * _scale) + 12, progress_animation_progress, ac_player, 2);
	draw_text_ext_transformed(obj_window_manager.viewport_width / 2, -(string_height(_string) * _scale) + _offset_y, _string, 0, obj_window_manager.viewport_width, _scale, _scale, 0);

	undoredo_animation_progress += 0.04
	if (undoredo_animation_progress < 1) and (surface_exists(undoredo_surf)) {
		if (undo_animation) {
			var _offset_x = curve(0, surface_get_width(undoredo_surf), undoredo_animation_progress, ac_player, 3);
		
			draw_surface_part(undoredo_surf, 0, 0, surface_get_width(undoredo_surf), surface_get_height(undoredo_surf) / 2, _offset_x, 0);
			draw_surface_part(undoredo_surf, 0, surface_get_height(undoredo_surf) / 2, surface_get_width(undoredo_surf), surface_get_height(undoredo_surf) / 2, -_offset_x, surface_get_height(gui_surf) / 2);	
		} else {
			var _offset_x = curve(surface_get_width(application_surface), 0, undoredo_animation_progress, ac_player, 4);
		
			draw_surface(undoredo_surf, 0, 0);
		
			draw_surface_part(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface) / 2, _offset_x, 0);
			draw_surface_part(application_surface, 0, surface_get_height(application_surface) / 2, surface_get_width(application_surface), surface_get_height(application_surface) / 2, -_offset_x, surface_get_height(gui_surf) / 2);	
		}	
	} else {
		undoredo_animation_progress = 1;	
	}
} else {
	draw_clear_alpha(c_black, 0)
	
	var _offset_x = curve(0, surface_get_width(gui_surf), finished_animation_progress, ac_player, 5);	
	
	draw_set_color(c_black);
	draw_set_alpha(clamp(remap(alarm[0], 5, 0, 0, 0.7), 0, 0.7));
	draw_rectangle(_offset_x, 0, _offset_x + surface_get_width(gui_surf), surface_get_height(gui_surf), false);
	
	if (finished) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		
		draw_set_color(c_white);
		draw_set_alpha(1);
		
		if (keyboard_check_pressed(vk_left)) {
			finished_looking = true;	
		}
		
		if (finished_looking) {
			if (keyboard_check_pressed(vk_right)) {
				finished_looking = false;
			}
			
			finished_animation_progress += 0.015;
		} else {
			if (keyboard_check_pressed(vk_right)) and (finished_animation_progress <= 0.1) {
				audio_sound_gain(mus_main, 0.5, 1000)
				room_goto_next()
			}
			
			finished_animation_progress -= 0.015;
		}	
		
		finished_animation_progress = clamp(finished_animation_progress, 0, 1);
		
		var _scale = 2;
		var _text = "Loop finished\nMoves: " + string(global.moves) + "\n\nRight arrow\nto continue\n\nLeft arrow\nTo view"
		draw_text_ext_transformed((surface_get_width(gui_surf) / 2) + _offset_x, surface_get_height(gui_surf) / 2, _text, string_height("A"), surface_get_width(gui_surf), _scale, _scale, 0);
	}	
}

surface_reset_target();

draw_surface_ext(gui_surf, 0, 0, obj_window_manager.window_scale, obj_window_manager.window_scale, 0, c_white, 1);