{ inputs, config, lib, pkgs, ... }: {
  imports = [ inputs.nur.nixosModules.nur ];
  home-manager.sharedModules = [
    inputs.nur.hmModules.nur
    #inputs.self.homeProfiles.nur
  ];
}
