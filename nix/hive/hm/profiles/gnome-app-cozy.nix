{ config , lib , pkgs , ... }: {
  #home.packages = [pkgs.cozy]; # Audiobook player (outdated. GTK4 avail via flathub-beta)

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  services.flatpak.packages = [
    "flathub-beta:app/com.github.geigi.cozy//beta"
    #"flathub:app/com.github.geigi.cozy//stable"
  ];
}
