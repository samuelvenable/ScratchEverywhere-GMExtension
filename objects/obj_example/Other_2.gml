// Scratch Official Website:
// https://scratch.mit.edu/

// Ubuntu export needs packages installed to work
// Run the following terminal command to install:
// sudo apt update && sudo apt install libgtk-3-dev libglib2.0-dev

// Hide Main Window:
window_hide(window_handle());
window_set_showborder_ext(window_handle(), false);

// Set Open File Dialog Window Size:
DialogSetWindowSize(720, 394);

// Force No Parent Window On Open File Dialog Window:
environment_unset_variable("IMGUI_DIALOG_PARENT");

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
  _scratch_game = GetOpenFileName("Scratch Game Files (*.sb3)|*.sb3", string_lower("Appel.sb3"), working_directory + string_lower("Games"), "Select a Scratch *.sb3 Game File to play...");
}

// Run Scratch Everywhere!
if (_scratch_game != "") {
  scratch_everywhere_create(_scratch_game);
} else {
  game_end();
}
