{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];


  # --- GSConnect ---
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];


  environment.systemPackages = [
    #pkgs.gnomeExtensions.gsconnect
    #pkgs.gnomeExtensions.valent
    #pkgs.valent
  ];
}
