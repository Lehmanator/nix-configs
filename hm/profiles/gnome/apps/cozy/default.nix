{ inputs, config, lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #home.packages = [pkgs.cozy]; # Audiobook player (outdated. GTK4 avail via flathub-beta)
  services.flatpak.packages = [
    {origin="flathub-beta"; appId="com.github.geigi.cozy";}
    {origin="flathub";      appId="com.github.geigi.cozy";}
  ];
}
