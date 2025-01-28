{
  config,
  lib,
  pkgs,
  ...
}: {
  services.home-assistant = {
    enable = true;
    configDir = "/var/lib/hass";
    configWritable = false; # true;

    lovelaceConfigWritable = true;
    openFirewall = true;
    package = pkgs.home-assistant.overrideAttrs (oldAttrs: {doInstallCheck = false;});

    # List of packages to add to propagatedBuildInputs
    extraPackages = python3Packages:
      with python3Packages; [
        psycopg2 # postgresql support
      ];

    config = {
      homeassistant = {
        name = "Home";
        latitude = "!secret latitude";
        longitude = "!secret longitude";
        elevation = "!secret elevation";
        unit_system = "imperial";
        temperature_unit = "F";
        time_zone = "America/New_York";
      };
      frontend = {
        themes = "!include_dir_merge_named themes";
      };
      http = {
        server_host = ["0.0.0.0" "::"]; # TODO: Only listen on Wireguard/Tailscale interface
        server_port = 8123;
      };
      feadreader.urls = [
        "https://nixos.org/blogs.xml"
      ];
      lovelace.mode = "yaml";
    };
    # https://www.home-assistant.io/integrations/
    extraComponents = [
      "default_config"
      "met"
      "esphome"
      "shopping_list"
      "uptime"
      "webhook"
      "whois"
      "workday"
      "worldclock"
      "zone"
    ];

    lovelaceConfig = {
      title = "Home";
      views = [
        {
          title = "Main";
          cards = [
            {
              type = "markdown";
              title = "Lovelace";
              content = "Welcome to your **Lovelace UI**.";
            }
          ];
        }
      ];
    };
  };
}
