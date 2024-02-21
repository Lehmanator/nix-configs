{
  config,
  lib,
  pkgs,
  ...
}: {
  plugins = {
    emmet = {
      enable = false;
      leader = null;
      mode = null; # i | n | v | a
      settings = null;
    };
  };
}
