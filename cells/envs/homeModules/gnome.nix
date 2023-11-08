{ self, inputs,
  config, lib, pkgs,
  ...
}:
with lib;
let
  firefoxProfile = {
    bookmarks = [
    ];
    extensions = [
    ];
    search.engines = [
    ];
    settings = {
    };
    userChrome = ''
      @import ${pkgs.firefox-gnome-theme}/userChrome.css;
    '';
    userContent = ''
      @import ${pkgs.firefox-gnome-theme}/userContent.css;
    '';
  };
  cfg = config.gnome;
in
  # https://determinate.systems/posts/declarative-gnome-configuration-with-nixos
{
  imports = [
    # TODO: Modules: NixOS + HomeManager + common
    # TODO: Module: mobile
    # TODO: Module: gnome-mobile
    # TODO: Module: adwaita  -{force,colors}
    # TODO: Module: extensions

  ];

  options.gnome = with lib; {
    enable  = mkEnableOption "Enable GNOME desktop environment";
    default = mkEnableOption "Whether GNOME is the default desktop environment";
    only    = mkEnableOption "Whether GNOME is the only desktop environment";

    extensions = mkOption {
      # TODO: Add submodule type for extension from git source
      # TODO: Enable extensions using dconf in home-manager options
      type = with types; nullOr (listOf (oneOf [ str package ])); # types.path;
      description = "List of GNOME shell extensions to install";
      default = [
        { enable = true;
          id = "user-theme@gnome-shell-extensions.gcampax.github.com";
          package = pkgs.gnomeExtensions.user-themes;
        }
      ];
    };


    favorite-apps = mkOption {
      description = "List of XDG Desktop launcher filenames to pin to dock";
      default = [
        "org.gnome.Console.desktop"  # TODO: Find actual name
        "org.gnome.Nautilus.desktop"
        "org.gnome.Epiphany.desktop"
        "firefox.desktop"
        "librewolf.desktop"
        "signal-desktop.desktop"
        "element.desktop"
        "ca.andyholmes.Valent.desktop"
        "io.gitlab.zehkira.Monophony.desktop"
      ];
    };

    workspaces = mkOption {
      names = mkOption {
        type = nullOr listOf str;
        description = "List of names to apply to desktop workspaces";
        default = [];  # [ "Main" "Chat" "Code" "Config" ];
      };
    };

  };

  config = mkIf cfg.enable {
    gtk.enable = mkIf cfg.enable true;

    # TODO: Catalog list of options that can be optimized for GNOME
    home.packages = [
      pkgs.dconf2nix
    ];

    # TODO: Enable extensions using dconf in home-manager options
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = ((cfg.extensions != null) && (cfg.extensions != []));
        enabled-extensions = [];  # [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
        favorite-apps = cfg.favorite-apps;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-";
        enable-hot-corners = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        workspace-names = cfg.workspaces.names;
      };
    };

    environment.gnome.excludePackages = [
      pkgs.cheese
    ];


    programs.firefox.profiles = {
      gnome   = lib.mkIf cfg.enable  firefoxProfile;
      default = lib.mkIf cfg.default firefoxProfile;
    };

  };
}
