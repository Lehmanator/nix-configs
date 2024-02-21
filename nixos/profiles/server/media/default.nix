{config, lib, pkgs, ...}:
{
  # https://sickchill.github.io/
  imports = [
    ./jellyfin.nix
  ];

  services = {
    lidarr = {};
    radarr = {};
    overseerr = {};
  };

  # Subtitle manager for Sonarr/Radarr
  services.bazarr = {
    enable = true;
    openFirewall = true;
    listenPort = 6767;
  };

  services.jackett = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/jackett/.config/Jackett";
  };
  environment.persistence."/nix/persist".directories = [config.services.jackett.dataDir];

  services.lidarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/lidarr/.config/Lidarr";
  };
  environment.persistence."/nix/persist".directories = [config.services.lidarr.dataDir];

  services.radarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/radarr/.config/Radarr";
  };
  environment.persistence."/nix/persist".directories = [config.services.radarr.dataDir];

  services.readarr = {enable = true; openFirewall=true;};
}
