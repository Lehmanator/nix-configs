{ config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    #blur-my-shell             # Blur GNOME UI elements
    burn-my-windows # Change window open/close animations
    #compact-top-bar           # Slimmer top bar
    compiz-windows-effect # Jiggle windows
    #gnome-bedtime              # Smooth transition to grayscale as bedtime approaches
    gradient-top-bar # Gradient top bar background
    #material-you-color-theming # Material You palettes from wallpaper applied to libadwaita (breaks light/dark theming)
    #rounded-window-corners     # Rounding for window corners (fix inconsistency w/ non-libadwaita apps) (11/23 - no GNOME 45 compat)
    #snowy                     # Snow effect on your desktop
    #transparent-shell         # Transparent top bar, dash, workspace view
  ];
}
