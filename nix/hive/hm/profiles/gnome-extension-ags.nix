{ inputs, cell, pkgs, lib, config, ... }:
# See docs: https://aylur.github.io/ags-docs
#
# TODO: Create widgets
# - [ ] TODO: Bar widget
# - [ ] TODO: Notification tray
# - [ ] TODO: Notification icon
# - [ ] TODO: Media player
# - [ ] TODO: Background apps
# - [ ] TODO: System tray
{
  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    #configDir = ./gnome-extension-ags/widgets;

    # additional packages to add to gjs's runtime
    extraPackages = [ pkgs.gtksourceview pkgs.webkitgtk pkgs.accountsservice ];
  };
}
