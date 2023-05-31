{ self, inputs
, config, lib, pkgs
, keybinds ? "custom"
, ...
}:
let
  helix.normal = {
    # --- Movement ---
    j = "move_visual_line_down";
    k = "move_visual_line_up";
    l = "move_char_right";

    left = "move_char_left";
    down = "move_visual_line_down";
    up = "move_visual_line_up";
    right = "move_char_right";

    b = "move_prev_word_start";
    B = "move_prev_long_word_start";

    e = "move_next_word_end";
    E = "move_next_long_word_end";

    f = "find_next_char";
    F = "find_prev_char";

    t = "find_till_char";
    T = "till_prev_char";
    
    G = "goto_line";
    
    w = "move_next_word_start";
    W = "move_next_long_word_start";

    home = "goto_line_start";
    end = "goto_line_end";
    pageup = "page_up";
    pagedown = "page_down";

    C-b = "page_up";
    C-f = "page_down";

    C-d = "half_page_down";
    C-i = "jump_forward";
    C-o = "jump_backward";
    C-s = "save_selection";
    C-u = "half_page_up";
    
    # --- Actions ---
    a = "append_mode";
    A = "insert_at_line_end";

    c = "change_selection";
    d = "delete_selection";

    D = null;

    i = "insert_mode";
    I = "insert_at_line_start";
    
    o = "open_below";
    O = "open_above";

    p = "paste_after";
    P = "paste_before";

    q = "replay_macro";
    Q = "record_macro";

    r = "replace";
    R = "replace_with_yanked";
    
    u = "undo";
    U = "redo";
    
    y = "yank";

    esc = null;

    "1" = null;
    "@" = null;
    "0" = null;

    A-c = "change_selection_noyank";
    A-d = "delete_selection_noyank";
    A-u = "earlier";
    A-U = "later";

    "A-." = "repeat_last_motion";
    "A-`" = "switch_to_uppercase";

    "~" = "switch_case";
    "`" = "switch_to_lowercase";

    ">" = "indent";
    "<" = "unindent";
    "=" = "format_selections";

    C-a = "increment";
    C-x = "decrement";

    #\"<reg> = "select_register";
    #. = null; # repeat_last_insert

    # --- Selection Manipulation ---
    C = "copy_selection_on_next_line";
    A-C = "copy_selection_on_prev_line";
    C-c = "toggle_comments";

    A-i = "shrink_selection";
    A-down = "shrink_selection";
    
    J = "join_selections";
    A-J = "join_selections_space";

    K = "keep_selections";
    A-K = "remove_selections";

    A-n = "select_next_sibling";
    A-right = "select_next_sibling";

    A-o = "expand_selection";
    A-up = "expand_selection";
    
    A-p = "select_next_sibling";
    A-left = "select_next_sibling";

    s = "select_regex";
    S = "split_selections";
    A-s = "split_selection_on_newline";
    
    x = "extend_line_below";
    X = "extend_to_line_bounds";
    A-X = "shrink_to_line_bounds";
    
    "&" = "align_selections";
    "%" = "select_all";

    "(" = "rotate_selections_backward";
    ")" = "rotate_selections_forward";
    "A-(" = "rotate_selection_contents_backward";
    "A-)" = "rotate_selection_contents_forward";

    "_" = "trim_selections";
    "A-_" = "merge_consecutive_selections";

    "A-:" = "ensure_selections_forward";
    
    ";" = "collapse_selection";
    "A-;" = "flip_selections";

    "," = "keep_primary_selection";
    "A-," = "remove_primary_selection";

    # --- Search ---
    "/" = "search";
    "?" = "rsearch";
    "n" = "search_next";
    "N" = "search_prev";
    "*" = "search_selection";

    # --- Minor Modes ---
    v = "select_mode";

    #g = goto mode
    g = {
      a = "goto_last_accessed_file";
      b = "goto_window_bottom";
      c = "goto_window_center";
      d = "goto_definition";
      e = "goto_last_line";
      f = "goto_file";
      g = "goto_file_start";
      h = "goto_line_start";
      i = "goto_implementation";
      j = "move_line_down";
      k = "move_line_up";
      l = "goto_line_end";
      m = "goto_last_modified_file";
      n = "goto_next_buffer";
      o = null;
      p = "goto_previous_buffer";
      q = null;
      r = "goto_reference";
      s = "goto_first_nonwhitespace";
      t = "goto_window_top";
      u = null;
      v = null;
      w = null;
      x = null;
      y = "goto_type_definition";
      z = null;
      "." = "goto_last_modification";
    };

    #m = match mode
    m = {
      m = "match_brackets";
      #s<char> = "surround_add";
      #r<from><to> = "surround_replace";
      #d<char> = "surround_delete";
      #a.<object> = "select_textobject_around";
      #i.<object> = "select_textobject_inner";
    };

    ":" = "command_mode";

    #z = view mode
    z = {
      b = "align_view_bottom";
      c = "align_view_center";
      j = "scroll_down"; down = "scroll_down";
      k = "scroll_up";   up = "scroll_up";
      C-f = "page_down"; pagedown = "page_down";
      C-b = "page_up";   pageup = "page_up";
      m = "align_view_middle";
      t = "align_view_top";
      z = "align_view_center";
    };
    
    #Z = sticky view mode
    Z = {
      b = "align_view_bottom";
      c = "align_view_center";
      j = "scroll_down"; down = "scroll_down";
      k = "scroll_up";   up = "scroll_up";
      C-f = "page_down"; pagedown = "page_down";
      C-b = "page_up";   pageup = "page_up";
      m = "align_view_middle";
      t = "align_view_top";
      z = "align_view_center";
    };
    #C-w = window mode
    C-w = {
      f = "goto_file";
      F = "goto_file";
      H = "swap_view_left";
      J = "swap_view_down";
      K = "swap_view_up";
      L = "swap_view_right";
      h = "jump_view_left";  C-h = "jump_view_left";   left = "jump_view_left";
      j = "jump_view_down";  C-j = "jump_view_down";   down = "jump_view_down";
      k = "jump_view_up";    C-k = "jump_view_up";       up = "jump_view_up";
      l = "jump_view_right"; C-l = "jump_view_right"; right = "jump_view_right";
      o = "wonly";           C-o = "wonly";
      q = "wclose";          C-q = "wclose";
      s = "hsplit";          C-s = "hsplit";
      v = "vsplit";          C-v = "vsplit";
      w = "rotate_view";     C-w = "rotate_view";
    };

    #space = space mode
    space = {
      a = "code_action";
      b = "buffer_picker";
      d = "diagnostics_picker";
      D = "workspace_diagnostics_picker";
      f = "file_picker";     
      F = "file_picker_in_current_directory";
      g = null;  # Debug (experimental)
      h = "select_references_to_symbol_under_cursor";
      j = "jumplist_picker";
      k = "hover";
      p = "paste_clipboard_after";
      P = "paste_clipboard_before";
      r = "rename_symbol";
      R = "replace_selections_with_clipboard";
      s = "symbol_picker";
      S = "workspace_symbol_picker";
      w = null; # Enter window mode
      y = "yank_joined_to_clipboard";
      Y = "yank_main_selection_to_clipboard";
      "'" = "last_picker";
      "/" = "global_search";
      "?" = "command_palette";
    };

    # Unimpaired
    "]" = {
      a = "goto_next_parameter";
      c = "goto_next_comment";
      d = "goto_next_diag";     
      D = "goto_last_diag";
      f = "goto_next_function";
      g = "goto_next_change";
      G = "goto_last_change";
      p = "goto_next_paragraph";
      t = "goto_next_class";
      T = "goto_next_test";
      space = "add_newline_below";
    };
    "[" = {
      a = "goto_prev_parameter";
      c = "goto_prev_comment";
      d = "goto_prev_diag";     
      D = "goto_first_diag";
      f = "goto_prev_function";
      g = "goto_prev_change";
      G = "goto_first_change";
      p = "goto_prev_paragraph";
      t = "goto_prev_class";
      T = "goto_prev_test";
      space = "add_newline_above";
    };

  };

  vim.normal = {
    h = "move_char_left";
    j = "move_visual_line_down";
    k = "move_visual_line_up";
    l = "move_char_right";
    left = "move_char_left";
    down = "move_visual_line_down";
    up = "move_visual_line_up";
    right = "move_char_right";

    "0" = "goto_line_start";
    "$" = "goto_line_end";
    "@" = "replay_macro";
    q = "record_macro";
    x = "delete_char_forward";
    X = "delete_char_backward";
    ";" = "repeat_last_motion";
    C-r = "redo";
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
      #D = "delete_char_backward";
      X = "extend_line_above";
      esc = "collapse_selection";
      ret = [ "move_line_down" "goto_first_nonwhitespace" ];

      "1" = "goto_line_start";
      "0" = "goto_line_end";

      "C-/" = "toggle_comments";

      # Vim training wheels
      C = ["select_mode" "goto_line_end" "change_selection"];
      D = ["select_mode" "goto_line_end" "delete_selection"];
      Y = ["select_mode" "goto_line_end" "yank"];
      "@" = "replay_macro";
      g = {
        "0" = "goto_line_end";
        "1" = "goto_line_start";
        "2" = "goto_first_nonwhitespace";
        "^" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
        G = "goto_last_line";
      };

      # OS-like selection
      backspace = "delete_char_backward";
      del = "delete_char_forward";
      C-backspace = ["select_mode" "move_prev_word_start" "delete_selection"];
      C-del = ["select_mode" "move_next_word_start" "delete_selection"];
      C-left = "move_prev_word_start";
      C-right = "move_next_word_end";

      C-S-down = "extend_line_below";
      C-S-up = "extend_line_above";

      C-a = "select_all";
      C-c = "yank_main_selection_to_clipboard";
      C-v = "replace_selections_with_clipboard";
      C-up = "increment";
      C-down = "decrement";


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

# --- Minor Modes ---
# v = select_mode
# g = goto mode
# m = match mode
# : = command_mode
# z = view mode
# Z = sticky view mode
# C-w = window mode
# space = space mode
