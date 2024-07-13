{config, lib, pkgs, ...}: {
  system.etc.overlay = {
    enable = true;
    mutable = true;
  };
}
