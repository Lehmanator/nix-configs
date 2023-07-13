{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./activedirectory.nix
    ./samba.nix
  ];

  home.packages = [
    # --- Generic Networking ---
    pkgs.nmap
    pkgs.dig
  ];

  # Causes infinite recursion
  #xdg.userDirs.extraConfig = lib.mkIf config.xdg.userDirs.enable {
  #  XDG_WORK_DIR = "${config.xdg.userDirs.extraConfig.XDG_CODE_DIR}/work}";
  #};

}
