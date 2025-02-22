{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./keymaps
    ./themes.nix
    ./statusline.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.nixos-unstable.legacyPackages.${pkgs.system}.helix;
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

      gutters.layout = [
        "diagnostics"
        "spacer"
        "line-numbers"
        "spacer"
        "diff"
      ];
      indent-guides = {
        render = true;
        skip-levels = 2;
      };

      end-of-line-diagnostics = "hint";
      inline-diagnostics = {
        cursor-line = "error";
        other-lines = "error";
        prefix-len = 3;
        max-wrap = lib.mkDefault 40;
      };
      line-number = "relative";
      # line-numbers.min-width = 2;

      middle-click-paste = true;
      mouse = true;
      popup-border = "all";
      preview-completion-insert = true;
      smart-tab = {
        enable = true;
        supercede-menu = false;
      };
      soft-wrap = {
        enable = true;
      };

      lsp = {
        enable = true;
        auto-signature-help = true;
        display-inlay-hints = true;
        display-progress-messages = true;
        display-signature-help-docs = true;
        display-messages = true;
        goto-reference-include-declaration = true;
        snippets = true;
      };
      scrolloff = 2;
    };
    extraPackages = builtins.attrValues (
      builtins.removeAttrs pkgs.tree-sitter-grammars [ "recurseForDerivations" ]
    );
  };
  programs.nushell.environmentVariables = {
    inherit (config.home.sessionVariables) EDITOR GIT_EDITOR;
  };
}
