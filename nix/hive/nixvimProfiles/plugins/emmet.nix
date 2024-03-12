{
  config,
  lib,
  pkgs,
  ...
}: {
  plugins.emmet = {
    enable = false;
    settings = {
      #leader_key = null;
      #mode = null; # i | n | v | a
    };
  };
}
