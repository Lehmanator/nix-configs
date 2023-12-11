# TODO: Conditionally load based on GNOME shell
#''
#  ${if config.services.xserver.desktopManager.gnome.enable then (import ./gnome.nix) else "" }
#''
(
  import ./gnome.nix
) +
(
  import ./sidebery.nix
) +
''
''

#''
#  #@import "autohide_sidebar.css"
#''
