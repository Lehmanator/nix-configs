{ inputs
, config, lib, pkgs
, osConfig
, ...
}:
let
  cfg = config.adwaita; # adw-colors;
  gnome-extension-setting = ext: "gsettings set org.gnome.shell.extensions.${ext}";
  gext-cmd = "${pkgs.dconf}/bin/dconf write /org/gnome/shell/extensions";
  setGsetting = path: option: value: {};
in {
  imports = [inputs.nix-flatpak.nixosModules.homeManagerModules.nix-flatpak];
  options = {
    enable = lib.mkEnableOption "Custom adwaita theming";
    auto-switcher.enable =
      lib.mkEnableOption "GNOME Shell Extension: Night Theme Switcher";
    adw-gtk3 = {
      enable = lib.mkEnableOption "adw-gtk3";
      enableFlatpak = lib.mkEnableOption "adw-gtk3 flatpak";
    };
    adw-colors = {
      enable = lib.mkEnableOption "adw-colors";
      colorscheme = {
        # Colorschemes:
        # - Dark: Peninsula-dark, Plano-dark, SurGubbe, adw-hc-dark
        # - Light: adw-hc-light,
        # - Both: adw-traffic
        dark = lib.mkOption {
          description = "Colorscheme for adw-colors for dark mode";
          type = lib.types.nullOr lib.types.str;
          default = null;
          example = "solarized-dark";
        };
        light = lib.mkOption {
          description = "Colorscheme for adw-colors for dark mode";
          type = lib.types.nullOr lib.types.str;
          default = null;
          example = "solarized";
        };
        # TODO: customDark  = {}; # GTK named colors
        # TODO: customLight = {}; # GTK named colors
      };
    };
    programs = {
      discord.enable = lib.mkEnableOption "Discord Adwaita theme";
      firefox.enable = lib.mkEnableOption "Firefox";
      kvantum.enable = lib.mkEnableOption "Kvantum";
      obsidian.enable = lib.mkEnableOption "Obsidian Notes";
      steam.enable = lib.mkEnableOption "Steam";
      thunderbird.enable = lib.mkEnableOption "Thunderbird";
      vscodium.enable = lib.mkEnableOption "VSCodium";
      xfwm4.enable = lib.mkEnableOption "XFWM4";
    };
  };
  config = lib.mkIf cfg.enable {
    home = {
      packages =
        [pkgs.papirus-folders pkgs.gnomeExtensions.custom-accent-colors]
        ++ lib.optionals cfg.auto-switcher
        [pkgs.gnomeExtensions.night-theme-switcher]
        ++ lib.optionals cfg.adw-gtk3.enable [pkgs.adw-gtk3]
        ++ lib.optionals (cfg.adw-gtk3.enable && cfg.adw-colors.enable) [
          (pkgs.callPackage ../pkgs/adw-colors.nix {})
          pkgs.sass # pkgs.dart-sass #pkgs.sassc #pkgs.nodePackages_latest.sass #pkgs.rsass #pkgs.grass-sass
        ];
      activation = {
        switcher = lib.mkIf cfg.auto-switcher ''
          ${gext-cmd}/nightthemeswitcher/shell-variants enabled true
          ${gext-cmd}/nightthemeswitcher/shell-variants night "'Default'"
          ${gext-cmd}/nightthemeswitcher/shell-variants day "'Custom-Accent-Colors'"

          ${gext-cmd}/nightthemeswitcher/gtk-variants enabled "true"
          ${gext-cmd}/nightthemeswitcher/gtk-variants day "'adw-gtk3'"
          ${gext-cmd}/nightthemeswitcher/gtk-variants night "'adw-gtk3-dark'"

          ${gext-cmd}/nightthemeswitcher/cursor-variants enabled "true"
          ${gext-cmd}/nightthemeswitcher/cursor-variants day "'Simp1e-Adw-Dark'"
          ${gext-cmd}/nightthemeswitcher/cursor-variants night "'Simp1e-Adw'"
        '';
        flatpak-install-gtk-themes =
          lib.mkIf
          #cfg.adw-gtk3.enableFlatpak
          osConfig.services.flatpak.enable ''
            flatpak --user install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
            flatpak --user override --filesystem=xdg-config/gtk4.0:ro
            flatpak --user override --filesystem=xdg-config/gtk3.0:ro
            flatpak --system install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
            flatpak --system override --filesystem=xdg-config/gtk4.0:ro
            flatpak --system override --filesystem=xdg-config/gtk3.0:ro
          '';
      };
    };
    #gtk.gtk3.extraCss = ''
    #  @import url("${pkgs.adw-colors}/themes/${cfg.colorscheme.light}/gtk.css")
    #'';

    xdg.configFile = {
      #"qt5ct/qt5ct.conf".text = ""; #qt6ct/{colors,qss}/??
      #"qt6ct/qt6ct.conf".text = "";
      "gtk-4.0/gtk-light.css".text = lib.mkIf cfg.adw-colors.enable ''
        @import url("${pkgs.adw-colors}/themes/${cfg.adw-colors.colorscheme.light}/gtk.css");
      '';
      "gtk-4.0/gtk-dark.css".text = lib.mkIf cfg.adw-colors.enable ''
        @import url("${pkgs.adw-colors}/themes/${cfg.adw-colors.colorscheme.dark}/gtk.css");
      '';

      "gtk-3.0/gtk-light.css".text = lib.mkIf cfg.adw-colors.enable ''
        @import url("${pkgs.adw-colors}/themes/${cfg.adw-colors.colorscheme.light}/gtk.css");
      '';
      "gtk-3.0/gtk-dark.css".text = lib.mkIf cfg.adw-colors.enable ''
        @import url("${pkgs.adw-colors}/themes/${cfg.adw-colors.colorscheme.dark}/gtk.css");
      '';
    };
  };
}
