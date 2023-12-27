{ inputs
, lib
, ...
}:
{
  programs.nixvim.plugins.barbar = {
    enable = lib.mkDefault false;
    animation = true;
    autoHide = false;
    clickable = true;
    excludeFileNames = [ ];
    excludeFileTypes = [ ];
    extraOptions = { };
    hide.alternate = true;
    hide.current = false;
    hide.extensions = false;
    highlightAlternate = false;
    highlightInactiveFileIcons = false;
    highlightVisible = true;
    icons.current = {
      pinned.separator = { left = "▎"; right = ""; }; # TODO: Conditionally use rounded
      separator = { left = ""; right = ""; }; # TODO: Conditionally use rounded
    };
    icons.diagnostics = {
      error.enable = true;
      warn.enable = false;
    };
  };
}
