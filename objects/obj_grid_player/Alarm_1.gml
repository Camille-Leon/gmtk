if (array_length(inventory) >= instance_number(obj_grid_pickup_objective)) {
	audio_play_sound(snd_objective, 0, false, 1, 0, 1.5);
} else {
	audio_play_sound(snd_objective, 0, false)	
}