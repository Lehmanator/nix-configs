{ inputs, config, lib, pkgs, user, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/${user}/.ssh/id_rsa";
      };
    };
  };
}
