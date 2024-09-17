{ inputs, config, lib, pkgs, ... }: {
  # TODO: Package latest Decibels from source
  #home.packages = [pkgs.decibels];
  services.flatpak.packages = [{ origin="flathub"; appId="org.gnome.Decibels";}];
}
