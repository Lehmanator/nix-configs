{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./samba.nix
  ];

  home.packages = [
    # --- Generic Networking ---
    pkgs.nmap
    pkgs.dig
  ];

  xdg.userDirs.extraConfig = {
    XDG_WORK_DIR = lib.mkIf config.xdg.userDirs.enable "${config.xdg.userDirs.XDG_CODE_DIR}/work}";
  };

}
