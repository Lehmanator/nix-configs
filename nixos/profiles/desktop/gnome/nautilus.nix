{ config, lib, pkgs, ... }:
{
  # File previewer
  services.gnome.sushi.enable = true;

  # Allow opening any terminal from within Nautilus
  # https://github.com/Stunkymonkey/nautilus-open-any-terminal#supported-terminal-emulators
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kgx";
  };

  # Enable Nautilus Extensions
  environment = {
    sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkDefault "${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-4";
    pathsToLink = ["/share/nautilus-python/extensions"];
    systemPackages = [pkgs.gnome.nautilus pkgs.gnome.nautilus-python];
  };

  # TODO: Set settings
  # gsettings set com.github.stunkymonkey.nautilus-open-any-terminal \
  #   terminal      kgx
  #   new-tab       true
  #   flatpak       system
  #   keybindings  '<Ctrl><Alt>t'
  #
  # home-manager.users.${user}.dconf.settings."com/github/stunkymonkey/nautilus-open-any-terminal" = {
  #   terminal = "kgx";
  #   new-tab = true;
  #   flatpak = "system";
  #   keybindings = "'<Ctrl><Alt>t'";
  # };
  #
  # programs.dconf = {
  #   enable = true;
  #   packages = [];
  #   profiles = {
  #     user.databases = [
  #       { settings = {
  #         };
  #       }
  #     ];
  #   };
  # };
}
