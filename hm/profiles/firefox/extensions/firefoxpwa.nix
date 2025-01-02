{ inputs, config, lib, pkgs, ... }: {
  home.packages = [ pkgs.firefoxpwa ];
  programs.firefox.nativeMessagingHosts = [ pkgs.firefoxpwa ];
  # inputs.nur.repos.rycee.firefox-addons.
}
