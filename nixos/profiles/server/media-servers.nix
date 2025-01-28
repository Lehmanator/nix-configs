{inputs, ...}: {
  # https://sickchill.github.io/
  imports = [(inputs.self + /nixos/profiles/jellyfin.nix)];
  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/audiobookshelf/.config/.Audiobookshelf";
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
  services.lidarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/lidarr/.config/Lidarr";
  };
  services.radarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/radarr/.config/Radarr";
  };
  services.readarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/radarr/.config/Readarr";
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/radarr/.config/Sonarr";
  };
}
