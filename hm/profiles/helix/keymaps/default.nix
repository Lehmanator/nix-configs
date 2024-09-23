{ config, lib, pkgs
, keybinds ? "custom"
, ...
}:
{
  # imports = [
  #   ./keys-custom.nix
  #   ./normal/default-helix.nix
  #   ./normal/default-vim.nix
  # ];
  programs.helix.settings.keys = {
    # Keys: 
    # - ret: "extend_to_line_bounds" | "command_mode" | 

    # TODO: Fix delay after pressing j
    # insert = {
    #   j.k = "normal_mode"; # jk to exit insert mode
    # };

    normal = {
      #D = "delete_char_backward";

      # Extend Selection:
      # x="extend_line_below"; X="extend_to_line_bounds"; A-x="shrink_to_line_bounds"; A-S-x="extend_line_above";
      X = "extend_line_above"; "A-S-x" = "extend_to_line_bounds";

      esc = "collapse_selection";
      ret = [ "move_line_down" "goto_first_nonwhitespace" ];

      # "C-/" = "toggle_comments";

      # --- Vim Training Wheels --------
      # C = "copy_selection_on_next_line";  # Default: place multi-cursor line below
      "C-c" = "copy_selection_on_next_line";
      C = ["select_mode" "goto_line_end" "change_selection"]; # New: Vim-like change
      D = ["select_mode" "goto_line_end" "delete_selection"];
      Y = ["extend_to_line_bounds" "yank"]; # Y = ["select_mode" "goto_line_end" "yank"];
      "@" = "replay_macro";

      # --- GoTo Menu ------------------
      g = {
        "0"="goto_line_end";
        "1"="goto_line_start";
        "2"="goto_first_nonwhitespace";
        "^"="goto_first_nonwhitespace";
        "$"="goto_line_end";
        G  ="goto_last_line";
      };
      "1" = "goto_line_start";
      "0" = "goto_line_end";

      # --- OS-like Selection ----------
      backspace="delete_char_backward"; C-backspace="delete_word_backward";
      del      ="delete_char_forward";  C-del      ="delete_word_backward";
      # C-backspace = ["select_mode" "move_prev_word_start" "delete_selection"];
      # C-del       = ["select_mode" "move_next_word_start" "delete_selection"];

      # TODO: Collapse selection?
      C-left =["move_prev_word_start" "collapse_selection"]; C-S-left ="move_prev_word_start";
      C-right=["move_next_word_end"   "collapse_selection"]; C-S-right="move_prev_word_end";

      C-S-down = "extend_line_below";
      C-S-up   = "extend_line_above";

      # --- OS-like Clipboard ----------
      # C-a = "select_all";
      # C-c = "yank_main_selection_to_clipboard";
      # C-v = "replace_selections_with_clipboard";
      # C-up   = "increment";
      # C-down = "decrement";
    };
  };
}
