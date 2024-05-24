{
  inputs,
  lib,
  ...
}: {
  plugins.barbar = {
    enable = lib.mkDefault false;
    animation = true;
    autoHide = false;
    clickable = true;
    excludeFileNames = [];
    excludeFileTypes = [];
    extraOptions = {};
    hide = {
      alternate = true;
      current = false;
      extensions = false;
    };
    highlightAlternate = false;
    highlightInactiveFileIcons = false;
    highlightVisible = true;
    # TODO: Conditionally use rounded / angled / square icons based on global conf
    icons = {
      current = {
        pinned.separator = {
          left = "▎";
          right = "";
        };
        separator = {
          left = "";
          right = "";
        };
      };
      diagnostics = {
        error.enable = true;
        warn.enable = true;
      };
    };
  };
}
