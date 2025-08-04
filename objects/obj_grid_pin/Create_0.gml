tied = false;

thread = noone;
loop_start = false;

tie = function(_pin) {
	tied = true;
	var _direction = point_direction(x, y, _pin.x, _pin.y);
	thread = instance_create_layer(x + lengthdir_x(8, _direction), y + lengthdir_y(8, _direction), "Thread", obj_thread);
	thread.tied_to = _pin;
}