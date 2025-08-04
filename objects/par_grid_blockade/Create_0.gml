var _pin_top = instance_create_layer(x, y - sprite_height / 2, "Pins", obj_grid_pin);
_pin_top.tied = true;

var _pin_bottom = instance_create_layer(x, y + sprite_height / 2, "Pins", obj_grid_pin);
_pin_bottom.tie(_pin_top);
_pin_bottom.thread.following_player = false;