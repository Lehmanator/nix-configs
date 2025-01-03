{ config, lib, pkgs, ... }: 
{
  environment.systemPackages = [
    pkgs.bottles
    pkgs.lutris
    pkgs.onedrive
    #pkgs.playonlinux
    pkgs.proton-caller
    pkgs.protonup-qt
    pkgs.protontricks
    pkgs.winetricks                  # Broken: 2023-01-23
    pkgs.wineWowPackages.waylandFull # Broken: 2023-01-23  # TODO: Conditional based on wayland support
    pkgs.wineasio                    # ASIO to JACK driver for WINE
    # pkgs.wine-discord-ipc-bridge     # Enable games running under wine to use Discord Rich Presence
  ] ++ lib.optional config.services.xserver.desktopManager.gnome.enable pkgs.wineWowPackages.unstableFull;
}
