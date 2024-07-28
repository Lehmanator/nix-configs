{ pkgs, ... }:
{
  environment.systemPackages = [pkgs.cachix];
  nix.settings = {
    substituters = [ "https://lehmanator.cachix.org" ];
    trusted-public-keys = [ "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU=" ];
  };
}
