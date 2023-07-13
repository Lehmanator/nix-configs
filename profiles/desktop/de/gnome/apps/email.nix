{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- Geary ---
  programs.geary.enable = true;

  # --- Evolution ---
  programs.evolution.enable = true;
  #programs.evolution.plugins = [
  #  pkgs.evolution-ews
  #];
  #services.gnome.evolution-data-server = {
  #  enable = true;
  #  plugins = [
  #    pkgs.evolution-ews
  #  ];
  #};

  # --- Thunderbird ---
  environment.systemPackages = [
    pkgs.thunderbird
  ];
}
