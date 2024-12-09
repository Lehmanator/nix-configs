{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell #              # Blur GNOME UI elements
    burn-my-windows #            # Change window open/close animations
    compact-top-bar #            # Slimmer top bar
    compiz-windows-effect #      # Jiggle windows
    gnome-bedtime #              # Smooth transition to grayscale as bedtime approaches
    gradient-top-bar #           # Gradient top bar background
    # material-you-color-theming # # Material You palette from wallpaper applied to adwaita (breaks light/dark theme) # WARN: Not available 24.11
    # rounded-window-corners #     # Round window corners (fix non-adwaita app inconsistency) # WARN: 11/23: GNOME45 incompat, unavailable 24.11
    snowy #                      # Snow effect on your desktop
  ];
}
