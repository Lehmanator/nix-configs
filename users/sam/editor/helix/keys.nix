{ self, inputs
, config, lib, pkgs
, keybinds ? "custom"
, ...
}:
let
  helix.normal = {
    "D" = null;
    "x" = "extend_line_below";
    "X" = null;
    "esc" = null;
    "1" = null;
    "@" = null;
    "0" = null;
    "A-." = "repeat_last_motion";
    ";" = "collapse_selection";
  };

  vim.normal = {
    "0" = "goto_line_start";
    "$" = "goto_line_end";
    "@" = "replay_macro";
    "q" = "record_macro";
    "x" = "delete_char_forward";
    "X" = "delete_char_backward";
    ";" = "repeat_last_motion";
    "C-r" = "redo";
  };
in
{
  imports = [
    #./custom.nix
    #./helix.nix
    #./vim.nix
  ];

  programs.helix.settings.keys = {

    insert = {
      j.k = "normal_mode"; # jk to exit insert mode
    };

    normal = {
      g.a = "code_action";
      "D" = "delete_char_backward";
      "X" = "extend_line_above";
      "esc" = "collapse_selection";

      "1" = "goto_line_start";
      "0" = "goto_line_end";

      # Vim training wheels
      "@" = "replay_macro";
    };

  };


}

# --- Key Names ---
# CTRL:  C-
# SHIFT: S-
# ALT:   A-
# Enter: ret
# backspace
# space
# minus
# left
# right
# up
# down
# home
# end
# pageup
# pagedown
# tab
# del
# ins
# null
# esc
