{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  prefer-flatpak = false;
in
{
  # --- GNOME App ---
  # https://github.com/vixalien/sticky
  home.packages             = mkIf (! prefer-flatpak) [ pkgs.sticky-notes ];
  services.flatpak.packages = mkIf    prefer-flatpak  [ "com.vixalien.sticky" ];

  # App Settings - none
  # dconf.settings."com/vixalien/sticky" = { }; 

  # --- GNOME Shell Extension ---
  # https://github.com/joaocandre/sticky-notes-integration
  programs.gnome-shell.extensions = [{package=pkgs.gnomeExtensions.sticky-notes-integration;}];

  # Extension Settings
  dconf.settings."org/gnome/shell/extensions/sticky-notes-integration" = {
    auto-start = true;
    keep-alive = true;
    panel-indicator-position-order = 5;
    show-open-note-count = true;
    use-builtin-icon = false;

    # Indicator Mouse Settings
    left-button-press-action   = 0;  # none
    middle-button-press-action = 1;  # hide-all
    right-button-press-actino  = 6;  # new-note
    scroll-down-action         = 4;  # cycle
    scroll-up-action           = 4;  # cycle
  };
}
