{ inputs, config, lib, pkgs, ... }:
let implementation = "valent";
in {
  # Allow GSConnect thru firewall
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
  };

  # Enable Firefox integration
  #programs.firefox.nativeMessagingHosts.gsconnect = true;
  #programs.firefox.nativeMessagingHosts.packages = [
  #  pkgs.gnomeExtensions.gsconnect
  #  pkgs.gnomeExtensions.valent
  #  pkgs.valent
  #];

  # Install implementation of GSConnect & shell-extension
  environment.systemPackages =
    if (implementation == "valent") then
      [
        pkgs.valent
        #pkgs.gnomeExtensions.valent
      ]
    else
      [ pkgs.gnomeExtensions.gsconnect ];
}
