/** 
 * scratch_everywhere_step() returns bool:bool
 * first bool is whether to continue main loop
 * second bool is whether it exited with error
 */
var _result = string_split(scratch_everywhere_step(), ":", true, 1);
if (_result[0] != undefined && !bool(int64((_result[0])))) {
	instance_destroy();
	game_end();
}