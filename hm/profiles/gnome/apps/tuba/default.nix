{ inputs, config, lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #services.flatpak.packages = [{appId="dev.geopjr.Tuba"; origin="flathub";}];
  home.packages = [ pkgs.tuba ];

  # TODO: Protocol string handler for Mastodon?
}
