var _window_width = viewport_width * window_scale;
var _window_height = viewport_height * window_scale;

window_set_size(_window_width, _window_height);
surface_resize(application_surface, viewport_width, viewport_height);

window_center();