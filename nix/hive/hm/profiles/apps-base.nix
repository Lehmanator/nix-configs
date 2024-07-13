{
  cell,
  pkgs,
  ...
}: {
  imports = [
    cell.homeProfiles.app-chromium
    #cell.homeProfiles.app-firefox
    cell.homeProfiles.app-torbrowser
    cell.homeProfiles.app-matrix
    cell.homeProfiles.app-pidgin
    cell.homeProfiles.app-signal
    cell.homeProfiles.app-libreoffice

    #cell.homeProfiles.passwords
    #cell.homeProfiles.app-bitwarden
    #cell.homeProfiles.app-keepassxc
    #cell.homeProfiles.app-nextcloudpasswords
    #cell.homeProfiles.app-pass
  ];

  home.packages = [pkgs.hunspell pkgs.hunspellDicts.en_US pkgs.onlyoffice-bin];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};

  #dconf.settings = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {
  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
  #    binding = "<Shift><Super>b";
  #    command = "browser-chooser";
  #    name = "launch browserchooser";
  #  };
  #};
}
