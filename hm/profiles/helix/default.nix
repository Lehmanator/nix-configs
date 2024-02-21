{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./keys.nix
    ./languages.nix
    ./themes.nix
    ./statusline.nix
  ];

  programs.helix = {
    enable = true;

    settings.theme = "a-shell";  # "adwaita-dark";

    settings.editor = {
      auto-completion = true;
      auto-format = true;
      auto-info = true;
      bufferline = "multiple";
      color-modes = true;
      cursorline = true;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      file-picker.hidden = false;
      indent-guides.render = true;
      line-number = "relative";

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
