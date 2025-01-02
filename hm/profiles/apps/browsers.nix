{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    (inputs.self + /hm/profiles/chromium.nix)
    # (inputs.self + /hm/profiles/chromium/ungoogled.nix)
    # (inputs.self + /hm/profiles/chromium/chromite.nix)
    # (inputs.self + /hm/profiles/chromium/brave.nix)

    ./browser-firefox
    #./browser-firefox/arkenfox.nix
    #./browser-firefox/librewolf.nix
    #./browser-firefox/iceraven.nix

    #] ++ lib.optionals (pkgs.system == "x86_64-linux") [./browser-tor]
    #./browser-tor
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
