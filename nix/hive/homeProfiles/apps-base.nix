{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.self.homeProfiles.app-chromium
    inputs.self.homeProfiles.app-firefox
    inputs.self.homeProfiles.app-torbrowser
    inputs.self.homeProfiles.app-element
    inputs.self.homeProfiles.app-pidgin
    inputs.self.homeProfiles.app-signal
    inputs.self.homeProfiles.app-libreoffice

    #inputs.self.homeProfiles.passwords
    #inputs.self.homeProfiles.app-bitwarden
    #inputs.self.homeProfiles.app-keepassxc
    #inputs.self.homeProfiles.app-nextcloudpasswords
    #inputs.self.homeProfiles.app-pass
  ];

  home.packages =
    [ pkgs.hunspell pkgs.hunspellDicts.en_US pkgs.onlyoffice-bin ];

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
