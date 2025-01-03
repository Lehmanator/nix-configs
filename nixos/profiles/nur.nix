{ inputs, config, lib, pkgs, ... }:
{
  imports = [inputs.nur.modules.nixos.default];
  home-manager.sharedModules = [inputs.nur.modules.homeManager.default];

  # TODO: Need to configure?
  # nixpkgs.overlays = [inputs.nur.overlays.default];
}
