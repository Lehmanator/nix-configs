{ inputs, self, lib, config, pkgs, ... }: {
  imports = [
    # TODO: Split ../fonts.nix into ../desktop/fonts.nix & ../shell/fonts.nix
    #inputs.home-extra-xhmm.homeManagerModules.desktop.fonts
  ];

  #fonts.fonts = [ #types.package
  #];
}
