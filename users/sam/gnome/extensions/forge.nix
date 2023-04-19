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
    text = ''
      .tiled {
        color: rgba(236, 94, 94, 1);
        opacity: 1;
        border-width: 3px;
      }
      .split {
        color: rgba(255, 246, 108, 1);
        opacity: 1;
        border-width: 3px;
      }
      .stacked {
        color: rgba(247, 162, 43, 1);
        opacity: 1;
        border-width: 3px;
      }
      .tabbed {
        color: rgba(17, 199, 224, 1);
        opacity: 1;
        border-width: 3px;
      }
      .floated {
        color: rgba(180, 167, 214, 1);
        border-width: 3px;
        opacity: 1;
      }
      .window-tiled-border {
        border-width: 3px;
        border-color: rgba(191,64,64,0);
        border-style: solid;
        border-radius: 14px;
      }
      .window-split-border {
        border-width: 3px;
        border-color: rgba(255, 246, 108, 1);
        border-style: solid;
        border-radius: 14px;
      }
      .window-split-horizontal {
        border-left-width: 0;
        border-top-width: 0;
        border-bottom-width: 0;
      }
      .window-split-vertical {
        border-left-width: 0;
        border-top-width: 0;
        border-right-width: 0;
      }
      .window-stacked-border {
        border-width: 2px;
        border-color: rgb(247,162,43);
        border-style: solid;
        border-radius: 14px;
      }
      .window-tabbed-border {
        border-width: 8px;
        border-color: rgb(17,199,224);
        border-style: solid;
        border-radius: 14px;
        padding: 0 !important;
        margin: 0 !important;
      }
      .window-tabbed-bg {
        border-radius: 8px;
        background-color: #FF0000AA;
        padding: 0 !important;
        margin: 0 !important;
      }
      .window-tabbed-tab:first-of-type {
        margin-left: 0 !important;
      }
      .window-tabbed-tab:last-of-type {
        margin-right: 0 !important;
      }
      .window-tabbed-tab {
        background-color: rgba(54, 47, 45, 0.3);
        border-color: #242424;
        #border-color: rgba(17,199,224,0.4);
        border-width: 1px;
        border-radius: 8px;
        color: white;
        margin-top: 1px;
        margin-right: 2px;
        margin-bottom: 0px;
        margin-left: 2px;
        box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.2);
        padding: 0 !important;
        #margin: 0 !important;
      }
      .window-tabbed-tab:hover {
        background-color: #3F3F3F;
      }
      .window-tabbed-tab-active {
        color: black;
        backgroundColor = #444444;
        box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.2);
        margin-bottom: 0 !important;
        border-radius: 8px 8px 0 0;
        border-bottom-width: 0 !important;
        padding: 0 !important;
      }
      .window-tabbed-tab-close {
        padding: 3px;
        margin: 4px;
        border-radius: 16px;
        width: 16px;
        background-color: #FFFFFF77;
        opacity: 0;
        color: transparent;
      }

      .window-tabbed-tab-close:hover {
        opacity: 1 !important;
        color: white !important;
      }
      .window-tabbed-tab-icon {
        margin: 5px;
      }
      .window-floated-border {
        border-width: 1px;
        border-color: rgba(180, 167, 214, 1);
        border-style: solid;
        border-radius: 14px;
      }
      .window-tilepreview-tiled {
        border-width: 1px;
        border-color: rgba(191,64,64,0.3);
        border-style: solid;
        border-radius: 14px;
        background-color: rgba(191,64,64,0.2);
      }
      .window-tilepreview-stacked {
        border-width: 1px;
        border-color: rgba(247,162,43,0.3);
        border-style: solid;
        border-radius: 14px;
        background-color: rgba(247,162,43,0.2);
      }
      .window-tilepreview-tabbed {
        border-width: 1px;
        border-color: rgba(17,199,224,0.3);
        border-style: solid;
        border-radius: 14px;
        background-color: rgba(17,199,224,0.2);
      }
    '';
  };
}
