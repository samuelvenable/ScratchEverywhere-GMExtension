// Scratch Official Website:
// https://scratch.mit.edu/

// Scratch Everywhere! Official Website:
// https://scratcheverywhere.github.io/

// Ubuntu export needs packages installed to work
// Run the following terminal command to install:
// sudo apt update && sudo apt install libgtk-3-dev libglib2.0-dev libsdl2-dev libsdl2-ttf-dev

// Set Open File Dialog Window Size:
DialogSetWindowSize(640, 480);

// Select a Custom Theme for All Dialogs: 
// Classic=-1, Dark=0, Light=1, Custom=2
// Example themes -1 to 1 are from ImGui
environment_set_variable("IMGUI_DIALOG_THEME", string(2));

// Set the Custom Color Theme:
// Color Scheme (R,G,B=0,1,2) 
environment_set_variable("IMGUI_TEXT_COLOR_0", string(1));
environment_set_variable("IMGUI_TEXT_COLOR_1", string(1));
environment_set_variable("IMGUI_TEXT_COLOR_2", string(1));
environment_set_variable("IMGUI_HEAD_COLOR_0", string(0.55));
environment_set_variable("IMGUI_HEAD_COLOR_1", string(0.35));
environment_set_variable("IMGUI_HEAD_COLOR_2", string(0.55));
environment_set_variable("IMGUI_AREA_COLOR_0", string(0.18));
environment_set_variable("IMGUI_AREA_COLOR_1", string(0.18));
environment_set_variable("IMGUI_AREA_COLOR_2", string(0.18));
environment_set_variable("IMGUI_BODY_COLOR_0", string(1));
environment_set_variable("IMGUI_BODY_COLOR_1", string(1));
environment_set_variable("IMGUI_BODY_COLOR_2", string(1));
environment_set_variable("IMGUI_POPS_COLOR_0", string(0.07));
environment_set_variable("IMGUI_POPS_COLOR_1", string(0.07));
environment_set_variable("IMGUI_POPS_COLOR_2", string(0.07));

// Desired Font Size:
DialogSetFontSize(20);

// Set Folder to Load All Fonts (Not Recursive):
if (os_type == os_windows) {
  DialogSetFontFolder(working_directory + "Fonts");
} else if (os_type == os_macosx || os_type == os_linux) {
  DialogSetFontFolder(working_directory + string_lower("Fonts"));
}

// Ooen Scratch Game:
var _scratch_game = "";
if (parameter_count() == 2) {
  _scratch_game = parameter_string(1);
} else {
  if (os_type == os_windows) {
    _scratch_game = GetOpenFileName("Scratch Game Files (*.sb3)|*.sb3", "Appel.sb3", working_directory + "Games", "Select a Scratch *.sb3 Game File to play...");
  } else if (os_type == os_macosx || os_type == os_linux) {
    _scratch_game = GetOpenFileName("Scratch Game Files (*.sb3)|*.sb3", string_lower("Appel.sb3"), working_directory + string_lower("Games"), "Select a Scratch *.sb3 Game File to play...");
  }
}

// Run Scratch Everywhere!
if (_scratch_game != "") {
  window_set_caption(filename_name(_scratch_game));
  environment_unset_variable("WAYLAND_DISPLAY"); // Scratch Everywhere! Needs X11/XWayland; Disable the Wayland Display!
  // The Window Handle Argument must be a String-Wrapped Int64 - Use string(int64(window_handle())) for the Game Window:
  var _scratch_everywhere_window = scratch_everywhere_create(_scratch_game, window_get_caption(), string(int64(window_handle())));
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
