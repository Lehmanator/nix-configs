{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./browser-chromium
    #./browser-chromium/brave.nix
    #./browser-chromium/chromite.nix
    #./browser-chromium/ungoogled.nix

    ./browser-firefox
    #./browser-firefox/arkenfox.nix
    #./browser-firefox/librewolf.nix
    #./browser-firefox/iceraven.nix

    ./browser-tor
  ];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};
  #dconf.settings = {
  #  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
  #    binding = "<Shift><Super>b";
  #    command = "browser-chooser";
  #    name = "launch browserchooser";
  #  };
  #};
}
