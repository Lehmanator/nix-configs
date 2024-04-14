{ inputs, config, lib, pkgs, ... }: {
  imports = [ inputs.self.nixosProfiles.vm-host ];
  environment.systemPackages = [ pkgs.win-spice ];
}
