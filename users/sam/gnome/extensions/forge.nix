{ self, inputs, config, lib, pkgs,
  host, user, repo, machine, network,
  ...
}:

# https://github.com/jmmaranan/forge
#
# Override Paths:
# - Windows: ~/.config/forge/config/windows.json
# - Stylesheet: ~/.config/forge/stylesheet/forge/stylesheet.css
{
  imports = [
  ];

  # TODO: Set accent & background colors with nix-colors / stylix ?
  # TODO: Use media query to test & adapt to light/dark mode?
  # TODO: Load GTK config CSS directly?
  # TODO: Place backdrop behind all tabs?
  # TODO: Mimic Adwaita header-bar & tab-bar styles
  #  .window-tabbed-tab-close: {
  #    hidden: true;
  #    :hover {
  #      background-color: #FFFFFF66;
  #    }
  #  }

  # Active Tab
  #background-color: rgb(17,199,224);
  xdg.configFile."forge-styles" = {
    target = "forge/stylesheet/forge/stylesheet.css";
    # Original close button:
    # background-color: #e06666;
    source = ./forge.css;
  };
}
