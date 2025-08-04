flip_flop = !flip_flop;

if !(audio_is_playing(snd_flip)) and !(audio_is_playing(snd_flop)) and !(tied) {
	if (flip_flop) {
		audio_play_sound(snd_flip, 0, false, 0.5);	
	} else {
		audio_play_sound(snd_flop, 0, false, 0.5);	
	}
}