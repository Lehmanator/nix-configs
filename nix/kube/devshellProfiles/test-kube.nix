{ inputs, config, lib, pkgs, ... }: {
  name = "Test DevShell Profile";
  motd = ''
    TESTING DEVSHELL PROFILE: MOTD
  '';
  packages = [ pkgs.stdenv pkgs.figlet ];
}
