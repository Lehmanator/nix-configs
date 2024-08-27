{ cell
, pkgs, lib
, ... 
}:
let
  inherit (lib) mkIf;
  prefer-flatpak = false;
in
{
  # --- GNOME App ---
  # Smile - GTK4 emoji picker
  home.packages             = mkIf (! prefer-flatpak) [ pkgs.smile ];
  services.flatpak.packages = mkIf    prefer-flatpak "it.mijorus.smile";

  # --- GNOME Shell Extension ---
  # Auto-paste emojis from Smile emoji picker app
  programs.gnome-shell.extensions = [{package=pkgs.gnomeExtensions.smile-complementary-extension;}];

  # dconf / gsettings Settings/configuration storage database
  #  Type: attrset of GVariant values. (e.g. if option type is uint32, wrap number w/ lib.hm.gvariant.mkUInt32)
  # - Util: https://github.com/gvolpe/dconf2nix
  dconf.settings = {
    # --- Application settings ---------------------------------------
    # https://github.com/mijorus/smile/blob/master/data/it.mijorus.smile.gschema.xml
    "it/mijorus/smile" = {
      # --- Startup ---
      emoji-size-class = "emoji-button-xxl";
      iconify-on-esc = true;

      # is-first-run = false;
      # last-run-version = "";
      load-hidden-on-startup = true;
      open-on-mouse-position = true; # TODO: How does this interact with Forge tiling extension

      # --- Pasting ---
      auto-paste = true;
      auto-paste-xdotool = true;
      mouse-multi-select = false;

      # --- User-specific ------------------------
      # --- Locale ---
      merge-english-tags = true;
      tags-locale = "es";
      use-localized-tags = false;

      # --- User personalization ---
      skintone-modifier = "1F3FB";
      # haircut-modifier = "";

    };

    # --- GNOME Shell Extension Settings ---
    # "org/gnome/shell/extensions/smile-complementary-extension" = {};

    # --- Keybinding settings ----------------------------------------
    # TODO: How to handle custom keybinding ordering?
    # TODO: Handle mobile
    "org/gnome/settings-daemon.plugins.media-keys.custom-keybinding/custom0" = {
      name = "Emoji Picker";
      command = if prefer-flatpak then "flatpak run it.mijorus.smile" else "smile";
      # GNOME has default emoji picker on `<Ctrl>.`, so we will add `<Shift>`
      binding = "<Shift><Control>period"; #"<Super>space"; 
    };

    # --- Windowing settings --------------------------------------
    # TODO: Set constant size, position

    # --- Notification settings --------------------------------------
    # Note: These exist for all apps
    # "org/gnome/desktop/notifications/application/it-mijorus-smile" = {
    #   details-in-lock-screen = false;
    #   enable = true;
    #   enable-sound-alerts = true;
    #   force-expanded = false;
    #   show-banners = true;
    #   show-in-lock-screen = true;
    # };

  };

  # Forge GNOME Extension: Exempt Smile app from window tiling
  # TODO: Conditional upon Forge extension added + enabled?
  # TODO: Figure out how to merge these gracefully. Create options?
  xdg.configFile."forge/config/windows.json".text = builtins.toJSON {
    wmClass = "it.mijorus.smile";
    mode = "float";
  };
  
}
