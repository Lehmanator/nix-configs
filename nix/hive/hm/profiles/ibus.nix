{ config, lib, pkgs, ... }:
let
  fav = {
    shrug = ''¯\_(ツ)_/¯'';
    "markdown-shrug" = ''¯\\\_(ツ)\_/¯'';
    flip = ''(╯°□°）╯︵ ┻━┻'';
  };
in
{

  i18n.inputMethod = { 
    enabled = "fcitx5";          # Default=null
    fcitx5.addons = with pkgs; [ # See equiv nixosProfile.ibus
      fcitx5-rime fcitx5-chewing fcitx5-chinese-addons
      fcitx5-pinyin-minecraft fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki
      fcitx5-table-extra fcitx5-table-other
      fcitx5-gtk fcitx5-material-color
      fcitx5-lua fcitx5-m17n fcitx5-skk
      fcitx5-rose-pine fcitx5-tokyonight catppuccin-fcitx5
    ];
    uim.toolbar = "gtk";
  };
  
  home.packages = [pkgs.fcitx5-configtool];

  programs.gnome-shell.extensions = [
    #{ package = pkgs.gnomeExtensions.ibus-font-setting; } # Use ibus font setting of ibus setup dialog to enhance user experience.
    { package = pkgs.gnomeExtensions.ibus-switcher;     } # D-Bus ibus source switcher
    { package = pkgs.gnomeExtensions.ibus-tweaker;      } # Tweak ibus orientation, theme, font, input mode, & clipboard history
    { package = pkgs.gnomeExtensions.customize-ibus;    } # Tweak ibus appearance, behavior, tray, & input source indicator
    { package = pkgs.gnomeExtensions.hassleless-overview-search; } # Revert ibus input src to default on overview, restore on exit. Solves conflict b/w ibus popup & "Type to search"
  ];

  dconf.settings."desktop/ibus/panel/emoji" = with lib.hm.gvariant; {
    favorite-annotations = mkArray type.string (lib.attrNames fav);
    favorites = mkArray type.string (lib.attrValues fav);
  };

  # xdg.configFile."fcitx5/conf/classicui.conf".text = ''
  #   Theme=Nord-Dark
  #   Font="Meslo 20"
  # '';

}
