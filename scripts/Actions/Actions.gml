function Action() constructor {
	
}

function ActionMove(_pin_from, _pin_to) constructor {
	pin_from = _pin_from;
	pin_to = _pin_to;
	
	undo = function(_player) {
		global.flip_flop = !global.flip_flop;
		
		with (obj_grid_pin_flipflop) {
			flip_flop = !flip_flop;	
		}
		
		global.moves--;
		
		_player.x = pin_from.x;
		_player.y = pin_from.y;
		
		pin_from.tied = false;
		instance_destroy(pin_from.thread);
		pin_from.thread = noone;
	}
	
	redo = function(_player) {
		global.flip_flop = !global.flip_flop;
		
		with (obj_grid_pin_flipflop) {
			flip_flop = !flip_flop;	
		}
		
		global.moves++;
		
		_player.x = pin_to.x;
		_player.y = pin_to.y;
		
		pin_from.tie(pin_to);
	}
}

function ActionPickup(_pickup, _pickup_index) constructor {
	pickup = _pickup;
	pickup_index = 0;
	
	undo = function(_player) {
		pickup.picked_up = false;
		pickup.animation_progress = 1;
		pickup.image_xscale = 1;
		pickup.image_yscale = 1;
		array_delete(_player.inventory, pickup_index, 1);
	}
	
	redo = function(_player) {
		pickup.picked_up = true;
		pickup.animation_progress = 1;
		pickup.image_xscale = 0;
		pickup.image_yscale = 0;
		array_insert(_player.inventory, pickup_index, pickup);
	}
}