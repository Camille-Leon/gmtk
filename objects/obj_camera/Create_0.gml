viewport_zoom = 1; // camera zoom, lower values = more zoom
viewport_angle = 0;

shake = 0;

var _window_manager = obj_window_manager;

camera_set_view_pos(view_camera[0], x, y);
camera_set_view_size(view_camera[0], _window_manager.viewport_width, _window_manager.viewport_height);