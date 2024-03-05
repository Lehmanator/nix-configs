{ config, lib, pkgs, ... }:
{
  nix = {
    #substituters = [ "https://lehmanator.cachix.org/" ];
    #trusted-substituters = [ "https://lehmanator.cachix.org/" ];
    # TODO: Public key here

    #extraOptions = ''
    #  !include /run/user/1000/secrets/github-token
    #'';
  };

  sops.secrets.github-token = { };

}
