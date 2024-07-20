{ config, pkgs, lib, ... }:

#
# https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
# https://nixos.wiki/wiki/IBus
#

{
  i18n.inputMethod = {
    # enable = true;

    # Renamed to `type` in 24.11
    enabled = "ibus"; # "ibus", "fcitx5", "nabi", "uim", "hime", "kime"

    fcitx5 = {
      addons = with pkgs; [
        # kdePackages.fcitx5-chinese-addons
        # kdePackages.fcitx5-configtool
        # kdePackages.fcitx5-qt
        # kdePackages.fcitx5-unikey
        # kdePackages.fcitx5-with-addons
        # libsForQt5.fcitx5-chinese-addons
        catppuccin-fcitx5 fcitx5-rose-pine fcitx5-tokyonight
        fcitx5-rime fcitx5-chewing
        fcitx5-gtk fcitx5-material-color
        fcitx5-lua fcitx5-m17n
        fcitx5-pinyin-minecraft fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki
        fcitx5-skk
        fcitx5-table-extra fcitx5-table-other
        vimPlugins.fcitx-vim
      ];

      ignoreUserConfig = false;

      # TODO: Add more custom emotes / ASCII drawings.
      quickPhrase = {
        smile = "（・∀・）";
        angry = "(￣ー￣)";
        shrug = ''¯\_(ツ)_/¯'';
        markdown-shrug = ''¯\\\_(ツ)\_/¯'';
        flip = ''(╯°□°）╯︵ ┻━┻'';
      };
      # TODO: Find more .mb files online.
      # quickPhraseFiles = {
      #   words = ./words.mb;
      #   numbers = ./numbers.mb;
      # };

      settings = {
        # The addon configures in conf folder in ini format with global sections.
        # Each item is written to the corresponding file.
        addons = {
          pinyin.globalSection.EmojiEnabled = "True";
        };

        # The global options in config file in ini format.
        globalOptions = { };
        # The input method configure in profile file in ini format.
        inputMethod = {};
      };

      # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
      waylandFrontend = config.services.displayManager.gdm.wayland || config.programs.xwayland.enable;
    };
    ibus = {
      panel = null;
      engines = with pkgs.ibus-engines; [
        bamboo cangjie kkc
        libpinyin
        m17n
        rime
        table table-chinese table-others 
        typing-booster #-unwrapped
        uniemoji
      ];
    };

    # kime = {
    #   daemonModules = [ "Xim" "Wayland" "Indicator" ];
    #   extraConfig = ""; # https://github.com/Riey/kime/blob/v3.0.2/docs/CONFIGURATION.md
    #   iconColor = "Black"; # "Black" | "White"
    # };

    uim.toolbar = "gtk"; # "gtk", "gtk3", "gtk-systray", "gtk3-systray", "qt5"
  };


  environment.sessionVariables = {
    GTK_IM_MODULE = "wayland"; #"fcitx"|"ibus"
    # chromium: GTK_IM_MODULE=fcitx (run in XWayland)
    QT_IM_MODULE = lib.mkIf config.services.xserver.desktopManager.gnome.enable "fcitx"; #null;  # "wayland" | "fcitx"
    # XMODIFIERS=@im=fcitx;  # Set for XWayland applications
  };

  # TODO: Add flag to chromium / electron apps: --enable-wayland-ime
  # # If your compositor supports text-input-v1 protocol. Check the compositor section below.
  # chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime 
  # # You will get wrong position for the input method popup window, unless you use GNOME shell + kimpanel extension.
  # chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4 
  # # If your compositor supports text-input-v1 protocol. Check the compositor section below.
  # code --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
}
