{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # --- Pairs ------------------------
  # Insert, remove, highlight syntax pairs
  programs.nixvim.plugins.nvim-autopairs = {
    enable = false;

    settings = {
      enable_abbr = false; # Enable trigger abbreviations. D=f
      enable_afterquote = true;
      enable_bracket_in_quote = true;
      enable_check_bracket_line = true;
      enable_moveright = true; # Enable moveright

      break_undo = true; # Switch for basic rule break undo sequence. D=true

      disable_in_macro = false; # Disable when recording/executing macro
      disable_in_replace_mode = true; # Disable in mode: Replace
      disable_in_visualblock = false; # Disable in mode: Visual Block

      disable_filetype = [
        # Named filetypes to disable autopairs
        "TelescopePrompt"
        "spectre_panel"
      ];

      map_bs = lib.mkDefault true; # Map <BS>  to delete pair. D=true
      map_c_h = lib.mkDefault false; # Map <C-h> to delete pair. D=false
      map_cr = lib.mkDefault true; # Map <CR>  to delete pair. D=true
      map_c_w = lib.mkDefault true; # Map <C-w> to delete pair. D=false

      check_ts =
        config.programs.nixvim.plugins.treesitter.enable; # Use Treesitter to check for a pair. D=false
      #ts_config = { lua=["string" "source"]; javascript=["string" "template_string"]; };  # D=null. Opts: null | attrset<list<str>>

      #extraOptions = {};
      #ignored_next_char = "[=[[%w%%%'%[%"%.%%$]]=]`";
      #pairs = {};      # Chars to pair up. Opts: null | attrset<str>
    };
  };
}
