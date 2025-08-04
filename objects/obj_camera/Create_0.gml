viewport_zoom = 1; // camera zoom, lower values = more zoom
viewport_angle = 0;

shake = 0;

var _window_manager = obj_window_manager;

camera_set_view_pos(view_camera[0], x, y);
camera_set_view_size(view_camera[0], _window_manager.viewport_width, _window_manager.viewport_height);

offset_x = 0;
offset_y = 0;

audio_play_sound(mus_pre, 0, true, 0.1);
audio_sound_gain(mus_pre, 0.5, 0);

full_swing = false;