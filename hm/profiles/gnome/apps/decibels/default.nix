{ inputs, config, lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  # TODO: Package latest Decibels from source
  #home.packages = [pkgs.decibels];
  services.flatpak = {
    packages = [{origin="flathub"; appId="com.vixalien.decibels";}];
    #overrides."com.vixalien.decibels".filesystems = [ ];
  };
}
