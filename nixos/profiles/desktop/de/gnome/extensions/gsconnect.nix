{ config, lib, pkgs, ... }:
let
  implementation = "valent";
  prefer-flatpak = false;
in
{
  # Allow GSConnect thru firewall
  # TODO: Only allow thru wireguard tunnels
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };

  # Enable Firefox integration
  #programs.firefox.nativeMessagingHosts.gsconnect = true;
  #programs.firefox.nativeMessagingHosts.packages = [
  #  pkgs.gnomeExtensions.gsconnect
  #  pkgs.gnomeExtensions.valent
  #  pkgs.valent
  #];

  # Install implementation of GSConnect & shell-extension
  environment.systemPackages = if (implementation == "valent")
     then [ pkgs.valent ]  # pkgs.gnomeExtensions.valent
     else [ pkgs.gnomeExtensions.gsconnect ];

  services.flatpak = lib.mkIf prefer-flatpak {
    remotes  = [{ name="valent"; location = "https://valent.andyholmes.ca/repo"; }];
    packages = []
      ++ lib.optional (implementation=="valent")     [{ origin="valent";  appId="ca.andyholmes.Valent"; }]
      ++ lib.optional (implementation=="kdeconnect") [{ origin="flathub"; appId=""; }]
    ;
  };

  # TODO: DConf settings for GSConnect / Valent GNOME extensions
}
