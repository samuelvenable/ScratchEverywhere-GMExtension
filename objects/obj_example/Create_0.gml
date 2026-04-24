// Scratch Official Website:
// https://scratch.mit.edu/

// Ubuntu export needs packages installed to work
// Run the following terminal command to install:
// sudo apt update && sudo apt install libfuse-dev libgtk-3-dev libglib2.0-dev

// Hide Main Window:
window_hide(window_handle());

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
  DialogSetFontFolder(working_directory + "OpenDialogFonts");
} else if (os_type == os_linux) {
  DialogSetFontFolder(working_directory + string_lower("OpenDialogFonts"));
}

// Open Scratch Game:
var _scratch_game = "";
if (parameter_count() == 2) {
  _scratch_game = parameter_string(1);
} else {
  _scratch_game = GetOpenFileName("Scratch Game Files (*.sb3)|*.sb3", "", "", "Select a Scratch *.sb3 Game File to play...");
}

// Run Scratch Game, if One was Selected:
if (_scratch_game != "") {
  if (os_type == os_windows) {
    var _proc_id = ProcessExecute("\"" + working_directory + "ScratchEverywhere/ScratchEverywhere.exe\" \"" + _scratch_game + "\"");
    FreeExecutedProcessStandardOutput(_proc_id);
    FreeExecutedProcessStandardInput(_proc_id);
  } else if (os_type == os_linux) {
    directory_create(game_save_id);
    directory_create(game_save_id + string_lower("ScratchEverywhere"));
    file_copy(working_directory + string_lower("ScratchEverywhere/ScratchEverywhere.AppImage"), game_save_id + string_lower("ScratchEverywhere/ScratchEverywhere.AppImage"));
    file_copy(working_directory + string_lower("ScratchEverywhere/ScratchEverywhere-License.txt"), game_save_id + string_lower("ScratchEverywhere/ScratchEverywhere-License.txt"));
    var _proc_id = ProcessExecute("chmod u+x \"" + game_save_id + string_lower("ScratchEverywhere/ScratchEverywhere.AppImage") + "\"");
    FreeExecutedProcessStandardOutput(_proc_id);
    FreeExecutedProcessStandardInput(_proc_id);
    _proc_id = ProcessExecute("\"" + game_save_id + string_lower("ScratchEverywhere/ScratchEverywhere.AppImage") + "\" \"" + _scratch_game + "\"");
    FreeExecutedProcessStandardOutput(_proc_id);
    FreeExecutedProcessStandardInput(_proc_id);
  }
}

// End Game:
game_end();
