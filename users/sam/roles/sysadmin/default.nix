{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ./activedirectory.nix ./redis.nix ./samba.nix ];
  home.packages = [ pkgs.nmap pkgs.dig ];
  # Causes infinite recursion
  #xdg.userDirs.extraConfig = lib.mkIf config.xdg.userDirs.enable {
  #  XDG_WORK_DIR = "${config.xdg.userDirs.extraConfig.XDG_CODE_DIR}/work}";
  #};
}
