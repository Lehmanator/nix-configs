{ config, lib, pkgs , ... }:
{
  imports = [
    ./keymaps
    ./languages
    ./themes.nix
    ./statusline.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.theme = "adwaita-dark";
    settings.editor = {
      auto-completion = true;
      auto-format = true;
      auto-info = true;
      auto-save = false;
      bufferline = "multiple";
      color-modes = true;

      completion-replace = true;
      completion-timeout = 250;
      completion-trigger-len = 2;
      
      cursorline = true;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      file-picker.hidden = false;
      idle-timeout = 250;

      gutters.layout = ["diagnostics" "spacer" "line-numbers" "spacer" "diff"];
      indent-guides = {
        render = true;
        skip-levels = 2;
      };
      line-number = "relative";
      # line-numbers.min-width = 2;

      middle-click-paste = true;
      mouse = true;
      popup-border = "all";
      preview-completion-insert = true;
      smart-tab = { enable = true; supercede-menu = false; };
      soft-wrap = { enable = true; };

      lsp = {
        enable = true;
        auto-signature-help = true;
        display-inlay-hints = true;
        display-signature-help-docs = true;
        display-messages = true;
        goto-reference-include-declaration = true;
        snippets = true;
      };
      scrolloff = 2;
    };
  };
}
