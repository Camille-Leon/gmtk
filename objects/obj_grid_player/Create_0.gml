undo_list = [];
redo_list = [];

inventory = [];
inventory_used = [];

global.moves = 0;

x_previous = x;
y_previous = y;

x_animation = x;
y_animation = y;

finished_looking = false

finished_animation_progress = 0;

finishing = false;
finished = false;

undoredo_surf = -1;
undoredo_animation_progress = 1;
undo_animation = false;

progress_animation_progress = 1;
animation_progress = 1;

collect_objectives_message = false;

var _starting_pin = instance_place(x, y, obj_grid_pin);
if (_starting_pin) {
	_starting_pin.loop_start = true;
}

gui_surf = -1;
