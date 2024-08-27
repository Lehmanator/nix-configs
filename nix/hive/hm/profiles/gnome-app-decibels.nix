{ inputs , config , lib , pkgs , ... }: {
  #imports = [inputs.declarative-flatpak.homeManagerModules.default];

  # TODO: Package latest Decibels from source
  #home.packages = [pkgs.decibels];

  services.flatpak = {
    packages = [ "flathub:app/com.vixalien.decibels//stable" ];
    #overrides."com.vixalien.decibels".filesystems = [ ];
  };

}
