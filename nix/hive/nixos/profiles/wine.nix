{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.bottles
    pkgs.lutris
    pkgs.onedrive
    #pkgs.playonlinux
    pkgs.proton-caller
    pkgs.protonup-qt
    pkgs.protontricks
    #pkgs.wineWowPackages.waylandFull # Broken: 2023-01-23  # TODO: Conditional based on wayland support
    #pkgs.winetricks # Broken: 2023-01-23
  ];
}
