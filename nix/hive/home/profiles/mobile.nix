{ inputs, config, lib, pkgs, ... }: {
  imports = [ inputs.self.homeProfiles.app-sms ];

  home.packages = [ pkgs.mobile-broadband-provider-info ];
  services.flatpak.packages =
    [ "flathub:app/page.codeberg.tpikonen.satellite//stable" ];
}
