{ inputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.self.homeProfiles.role-admin-redis
    inputs.self.homeProfiles.role-admin-samba
  ];
  home.packages = [ pkgs.nmap pkgs.dig ];

  # Causes infinite recursion
  #xdg.userDirs.extraConfig = lib.mkIf config.xdg.userDirs.enable {
  #  XDG_WORK_DIR = "${config.xdg.userDirs.extraConfig.XDG_CODE_DIR}/work}";
  #};
}
