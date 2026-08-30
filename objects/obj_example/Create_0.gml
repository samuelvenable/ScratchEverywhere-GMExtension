// Ooen Scratch Game:
var _scratch_game = "";
if (parameter_count() == 2) {
  _scratch_game = parameter_string(1);
} else {
  if (os_type == os_windows) {
    _scratch_game = get_open_filename_ext("Scratch Game Files (*.sb3)|*.sb3", "Appel.sb3", working_directory, "Select a Scratch *.sb3 Game File to play...");
  } else if (os_type == os_macosx || os_type == os_linux) {
    _scratch_game = get_open_filename_ext("Scratch Game Files (*.sb3)|*.sb3", string_lower("Appel.sb3"), working_directory, "Select a Scratch *.sb3 Game File to play...");
  }
}

// Run Scratch Everywhere!
if (_scratch_game != "") {
  scratch_everywhere_set_size(640, 480);
  scratch_everywhere_set_resizable(false);
  scratch_everywhere_set_caption(filename_name(_scratch_game));
  var _scratch_everywhere_owner_window = string(int64(window_handle()));
  scratch_everywhere_set_owner(_scratch_everywhere_owner_window);
  var _scratch_everywhere_window = scratch_everywhere_create(_scratch_game);
  /** 
   * scratch_everywhere_step() returns bool:bool
   * first bool is whether to continue main loop
   * second bool is whether it exited with error
   */
  while (true) {
    var _code = string_split(scratch_everywhere_step(), ":", true, 1);
    if (_code[0] != undefined && !bool(int64((_code[0])))) {
      // Wrap Things Up:
      scratch_everywhere_destroy();
    }
  }
}

// Open File Dialog Canceled:
game_end();
