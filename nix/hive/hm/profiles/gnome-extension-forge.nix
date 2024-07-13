{ inputs, config, lib, pkgs, ... }:
# https://github.com/jmmaranan/forge
#
# Override Paths:
# - Windows: ~/.config/forge/config/windows.json
# - Stylesheet: ~/.config/forge/stylesheet/forge/stylesheet.css
{
  #imports = [ ./settings.nix ];
  programs.gnome-shell.extensions = [{ package = pkgs.gnomeExtensions.forge; }];

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

  # Original close button:
  #background-color: #e06666;

  # Active Tab:
  #background-color: rgb(17,199,224);

  xdg.configFile = {
    #forge-style-base = {
    #  target = "forge/stylesheet/forge/stylesheet.css";
    #  source = ./gnome-extension-forge-stylesheet.css;
    #  #text = ''
    #  #  @import url("gnome.css");
    #  #'';
    #};
    forge-style = {
      target = "forge/stylesheet/forge/stylesheet.css";
      source = ./gnome-extension-forge-testing2.css;
    };
    #forge-style-gnome = {
    #  target = "forge/stylesheet/forge/gnome.css";
    #  source = ./gnome-extension-forge-gnome.css;
    #};
    #forge-style-dark = {
    #  target = "forge/stylesheet/forge/gnome-dark.css";
    #  source = ./gnome-extension-forge-gnome-dark.css;
    #};
    #forge-style-light = {
    #  target = "forge/stylesheet/forge/gnome-light.css";
    #  source = ./gnome-extension-forge-gnome-light.css;
    #};
    forge-style-default =
      let
        dark-style = ''
          :root {
            --fg: white;
            --tab-active: #444444;
            --tab-active-hover: #4B4B4B;
            --tab-inactive: #303030;
            --tab-inactive-hover: #3F3F3F;
            --close-active: transparent;
            --close-active-hover: #585858;
            --close-inactive: transparent;
            --close-inactive-hover: #4C4C4C;
            --icon: transparent;
            transition: background-color 0.2s !important;
          }
        '';
        gnome-style = ''
          /*----- Tab ----------------------------------------------*/
          /* TODO: Hovered tab removes border of adjacent tabs */
          /* TODO: Active  tab removes border of adjacent tabs */
          .window-tabbed-tab {
            background-color: var(--tab-inactive) !important;
            /*border-color: transparent !important;*/

            border-radius:       6px !important;
            border-left-width:   1px !important;
            border-right-width:  0px !important;
            border-top-width:    0px !important;
            border-bottom-width: 0px !important;
            border-style:      solid !important;

            position: relative !important;
            margin-block: 0 !important;
            padding: 5px 2px 6px !important;

            box-shadow: none !important;
          }
          .window-tabbed-tab:hover {
            background-color: var(--tab-inactive-hover) !important;
            border-left-width: 0px !important;
          }
          .window-tabbed-tab-active {
            background-color: var(--tab-active) !important;
            border-left-width: 0px !important;
          }
          .window-tabbed-tab-active:hover {
            background-color: var(--tab-active-hover) !important;
          }

          /*----- App Icon -----------------------------------------*/
          .window-tabbed-tab-icon {
            background-color: transparent !important;                 /* App Icon: bg=transparent always             */
            border-radius: 50% !important;
          }

          /*----- Close Icon ---------------------------------------*/
          .window-tabbed-tab-close                                 { /* bg=transparent by default                   */
            color: transparent !important;                           /* fg=transparent unless icon hovered          */
            background-color: transparent !important;                /* bg=transparent unless tab  hovered/active   */

            margin-left: auto !important;
            margin-right: 4px !important;
            margin-top: 4px !important;
            margin-bottom: 4px !important;
            min-width: 16px !important;
            border-radius: 50% !important;
          }

          /* Conditions where icon is visible */
          .window-tabbed-tab-close:hover { color: var(--fg) !important; } /* Whenever close icon is hovered           */
          .window-tabbed-tab-active .window-tabbed-tab-close            {
            color: var(--fg) !important;                                } /* Whenever tab is active                   */
          .window-tabbed-tab:hover  .window-tabbed-tab-close            {
            color: var(--fg) !important;                                } /* Whenever tab is hovered                  */

          /* Conditions where icon has background */
          .window-tabbed-tab        .window-tabbed-tab-close:hover      {
            background-color: var(--close-inactive-hover) !important;
          } /* Tab = inactive, Icon = hover => bg=lighter  */
          .window-tabbed-tab-active .window-tabbed-tab-close:hover      {
            background-color: var(--close-active-hover)   !important;
          } /* Tab =   active, Icon = hover => bg=lightest */
        '';
      in
      {
        target = "forge/stylesheet/forge/stylesheet2.css";
        text = dark-style + gnome-style + ''

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
          border-color: rgba(236, 94, 94, 1);
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
          border-width: 3px;
          border-color: rgba(247, 162, 43, 1);
          border-style: solid;
          border-radius: 14px;
        }

        .window-tabbed-border {
          border-width: 3px;
          border-color: rgba(17, 199, 224, 1);
          border-style: solid;
          border-radius: 14px;
        }

        .window-tabbed-bg {
          border-radius: 8px;
        }

        .window-tabbed-tab {
          background-color: rgba(54, 47, 45, 1);
          border-color: rgba(17, 199, 224, 0.6);
          border-width: 1px;
          border-radius: 8px;
          color: white;
          margin: 1px;
          box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.2);
        }

        .window-tabbed-tab-active {
          background-color: rgba(17, 199, 224, 1);
          color: black;
          box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.2);
        }

        .window-tabbed-tab-close {
          padding: 3px;
          margin: 4px;
          border-radius: 16px;
          width: 16px;
          background-color: #e06666;
        }

        .window-tabbed-tab-icon {
          margin: 3px;
        }

        .window-floated-border {
          border-width: 3px;
          border-color: rgba(180, 167, 214, 1);
          border-style: solid;
          border-radius: 14px;
        }

        .window-tilepreview-tiled {
          border-width: 1px;
          border-color: rgba(236, 94, 94, 0.4);
          border-style: solid;
          border-radius: 14px;
          background-color: rgba(236, 94, 94, 0.3);
        }

        .window-tilepreview-stacked {
          border-width: 1px;
          border-color: rgba(247, 162, 43, 0.4);
          border-style: solid;
          border-radius: 14px;
          background-color: rgba(247, 162, 43, 0.3);
        }

        .window-tilepreview-tabbed {
          border-width: 1px;
          border-color: rgba(18, 199, 224, 0.4);
          border-style: solid;
          border-radius: 14px;
          background-color: rgba(17, 199, 224, 0.3);
        }


      '';
      };
  };
}
