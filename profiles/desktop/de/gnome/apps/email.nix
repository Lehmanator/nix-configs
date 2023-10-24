{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # --- Geary ---
  programs.geary.enable = true;

  # --- Evolution ---
  # TODO: Fix EWS support for Microsoft Exchange & Microsoft Graph API
  #programs.evolution = {
  #  enable = true;
  #  plugins = [pkgs.evolution-ews];
  #};
  #services.gnome.evolution-data-server = {
  #  enable = true;
  #  plugins = [pkgs.evolution-ews];
  #};

  environment.systemPackages = [
    # TODO: Package erooster-mail/email-client
    # https://github.com/erooster-mail/email-client

    # --- Thunderbird ---
    # TODO: Package thunderbird-gnome-theme (a la firefox-gnome-theme)
    pkgs.thunderbird # TODO: Move to desktop-agnostic config file for adding apps

  ];

}
