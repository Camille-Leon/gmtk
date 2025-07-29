var _viewport_width = obj_window_manager.viewport_width;
var _viewport_height = obj_window_manager.viewport_height;

var _inverse_zoom = 1 - viewport_zoom;

shake = max(shake - 0.1, 0);

var _shake_angle = random(360);
var _shake_x = lengthdir_x(random(shake / 3), _shake_angle);
var _shake_y = lengthdir_y(random(shake / 3), _shake_angle);

camera_set_view_pos(view_camera[0], x + ((_viewport_width / 2) * _inverse_zoom) + _shake_x, y + ((_viewport_height / 2) * _inverse_zoom) + _shake_y);
camera_set_view_size(view_camera[0], _viewport_width * viewport_zoom, _viewport_height * viewport_zoom);
camera_set_view_angle(view_camera[0], viewport_angle + ((_shake_x + _shake_y) / 2));