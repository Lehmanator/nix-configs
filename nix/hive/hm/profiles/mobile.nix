{ cell, config, lib, pkgs, ... }: {
  imports = [ cell.homeProfiles.app-sms ];

  home.packages = [ pkgs.mobile-broadband-provider-info ];
  services.flatpak.packages =
    [ "flathub:app/page.codeberg.tpikonen.satellite//stable" ];
}
