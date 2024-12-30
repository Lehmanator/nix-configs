{ config, lib, pkgs, ... }:
{
  # Containerd container runtime
  virtualisation.containerd = {
    enable = true;

    # Extra args to append to the containerd cmdline
    args = { };

    # Path to containerd config file. Setting option will override any configuratino applied by the option: containerd.settings
    #configFile = null;    # null | <path>

    # Verbatim lines to add to containerd.toml
    settings = {
    };

  };
}
