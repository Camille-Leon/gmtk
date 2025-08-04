animation_progress += 0.065;
progress_animation_progress += 0.02;

image_xscale = lerp(image_xscale, 1, 0.25);
image_yscale = lerp(image_yscale, 1, 0.25);
image_angle -= angle_difference(image_angle, 0) / 10;

var _move_horizontal = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
var _move_vertical = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

if !(audio_is_playing(mus_transition)) and (obj_camera.full_swing) and !(audio_is_playing(mus_main)){
	audio_play_sound(mus_main, 0, true, 0.1)
	audio_sound_gain(mus_main, 0.5, 0);
	if (finished) or (finishing) {
	audio_sound_gain(mus_main, 0.075, 0);	
	}
}

if (finishing) {
	exit;	
}

if (abs(_move_horizontal)) or (abs(_move_vertical)) and (animation_progress >= 0.9) {
	var _move_direction = point_direction(0, 0, _move_horizontal, _move_vertical);
	var _previous_collision = instance_place(x, y, obj_grid_pin);
	
	var _collision_list = ds_list_create();
	var _collision_number = collision_line_list(x, y, x + lengthdir_x(512, _move_direction), y + lengthdir_y(512, _move_direction), obj_grid_pin, true, false, _collision_list, false);
	
	var _collision = noone;
	for (var _i = 0; _i < _collision_number; _i++) {
		var _collision_temporary = _collision_list[| _i];
		
		if (_collision_temporary != _previous_collision) and (_collision_temporary.visible) {
			if (_collision == noone) or (point_distance(x, y, _collision_temporary.x, _collision_temporary.y) < point_distance(x, y, _collision.x, _collision.y)) {
				_collision = _collision_temporary;	
			}
		}
	}	
	
	if (_collision != noone) {
		if (!(_collision.tied) or (_collision.loop_start)) and !(collision_line(_previous_collision.x, _previous_collision.y, _collision.x, _collision.y, obj_thread, false, false)) {
			redo_list = [];
		
			if !(obj_camera.full_swing) {
				obj_camera.full_swing = true;
				audio_sound_gain(mus_pre, 0, 1670);
				audio_play_sound(mus_transition, 0, false, 0.1);
				audio_sound_gain(mus_transition, 0.5, 0);
			}
			
			global.moves++;
		
			obj_camera.offset_x = _move_horizontal * -4;
			obj_camera.offset_y = _move_vertical * -4;
			obj_camera.shake = 1;
		
			image_angle = 15 * -_move_horizontal;
		
			show_debug_message("Found collision!");
			
			global.flip_flop = !global.flip_flop;
			
			with (obj_grid_pin_flipflop) {
				alarm[0] = 10;	
			}
			
			var _action_list = [];
			
			x_previous = x;
			y_previous = y;
			
			x = _collision.x;
			y = _collision.y;
			
			audio_play_sound(snd_move, 0, false);
			
			obj_grid_player.image_xscale = 0.8;
			obj_grid_player.image_yscale = 0.8;
			
			animation_progress = 0;
			
			if (_previous_collision != noone) {
				_previous_collision.tie(_collision);
			}
			
			array_push(_action_list, new ActionMove(_previous_collision, _collision));
			
			var _collision_item = collision_line(_previous_collision.x, _previous_collision.y, _collision.x, _collision.y, par_grid_pickup, false, false);
			if (_collision_item != noone) {
				_collision_item.picked_up = true;
				progress_animation_progress = 0;
				array_push(inventory, _collision_item);
				alarm[1] = 5;
				_collision_item.animation_progress = 0;
				array_push(_action_list, new ActionPickup(_collision_item, array_length(inventory) - 1))
			}
			
			array_push(undo_list, _action_list);
			
			if (_collision.loop_start) {
				var _picked_up_all = true;
				for (var _i = 0; _i < instance_number(obj_grid_pickup_objective); _i++) {
					var _pickup_objective = instance_find(obj_grid_pickup_objective, _i);
					if !(_pickup_objective.picked_up) {
						_picked_up_all = false;	
					}
				}
				
				if (_picked_up_all) {
					alarm[0] = 30;
					finishing = true;
					audio_play_sound(snd_win, 0, false, 0.5);
					audio_sound_gain(snd_win, 0.5, 0)
					audio_sound_gain(mus_main, 0.075, 1000);
				} else {
					progress_animation_progress = 0;
					collect_objectives_message = true;
				}
			}
		}
	}		
}

if (collect_objectives_message) and (progress_animation_progress >= 0.5) {
	var _action_list = undo_list[array_length(undo_list) - 1];
	for (var _i = 0; _i < array_length(_action_list); _i++) {
		_action_list[_i].undo(self);
	}
	
	if !(surface_exists(undoredo_surf)) {
		undoredo_surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));	
	}
	
	undoredo_animation_progress = 0;
	undo_animation = true;
	
	surface_set_target(undoredo_surf);
	draw_surface(application_surface, 0, 0);
	surface_reset_target();

	array_push(redo_list, array_pop(undo_list));	
	
	collect_objectives_message = false;
	progress_animation_progress = 1;
}

if (keyboard_check(vk_control)) and (undoredo_animation_progress >= 0.9) {
	if (keyboard_check_pressed(ord("Z"))) and (array_length(undo_list) > 0)  {
		var _action_list = undo_list[array_length(undo_list) - 1];
		for (var _i = 0; _i < array_length(_action_list); _i++) {
			_action_list[_i].undo(self);
		}
		
		if !(surface_exists(undoredo_surf)) {
			undoredo_surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));	
		}
		
		undoredo_animation_progress = 0;
		undo_animation = true;
		
		audio_play_sound(snd_undo, 0, false);
		
		surface_set_target(undoredo_surf);
		draw_surface(application_surface, 0, 0);
		surface_reset_target();

		array_push(redo_list, array_pop(undo_list));
	}
	
	if (keyboard_check_pressed(ord("Y"))) and (array_length(redo_list) > 0) {
		var _action_list = redo_list[array_length(redo_list) - 1];
		for (var _i = 0; _i < array_length(_action_list); _i++) {
			_action_list[_i].redo(self);
		}
		
		if !(surface_exists(undoredo_surf)) {
			undoredo_surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));	
		}
		
		audio_play_sound(snd_redo, 0, false)
		
		surface_set_target(undoredo_surf);
		draw_surface(application_surface, 0, 0);
		surface_reset_target();

		undoredo_animation_progress = 0;
		undo_animation = false;

		array_push(undo_list, array_pop(redo_list));
	}
}