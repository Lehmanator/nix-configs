{ inputs, config, lib, pkgs, ... }: {
  # TODO: Signal protocol string handler?
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #services.flatpak.packages = [{origin="flathub"; appId="de.schmidhuberj.Flare"; }];
  home.packages = [ pkgs.flare-signal ];
}
