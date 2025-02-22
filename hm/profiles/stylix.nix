{ inputs, config, lib, pkgs, ... }:
{
  # --- Stylix ---
  # Sets colors, fonts, & styles for multiple programs based on wallpaper.
  #
  # https://github.com/danth/stylix
  # https://danth.github.io/stylix/options/hm.html
  #
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = with lib; rec {
    autoEnable = true;
    #base16Scheme = {};
    fonts = with pkgs; {
      emoji     = { name = "Noto Color Emoji"; package = noto-fonts-emoji; };
      monospace = { name = "Maple Mono";       package = maple-mono-NF;    };
      serif     = { name = "DejaVu Serif";     package = dejavu-fonts;     };
      sansSerif = { name = "Cantarell";        package = cantarell-fonts;  };
      #sansSerif = { name = "DejaVu Sans";      package = dejavu-fonts;     };

      sizes = {
        applications = mkDefault 11;
        desktop      = mkDefault 10;
        popups       = mkDefault 10;
        terminal     = mkDefault 10;
      };
    };

    # --- Wallpaper ---
    #image = "${config.xdg.dataHome}/wallpapers/";

    # Override applied to `stylix.base16Scheme` when generating `lib.stylix.colors`
    #  Accepts anything that a scheme generated by base16nix can take as an argument to override
    override = mkDefault {};

    # Force a light or dark theme
    polarity = mkDefault "either";

    # Target programs to style
    #  List: alacritty, avizo, bemenu, bspwm, dunst, emacs, feh, fish, foot,
    #        gedit, gnome, gtk,
    #        helix, i3, k9s, kitty, mako, qutebrowser, rofi,
    #        sway, swaylock,
    #        sxiv, vim, vscode, waybar, xresources, zathura,
    targets = {
      bat.enable = config.bat.enable;
      bemenu = {
        enable    = mkDefault true;
        alternate = mkDefault false;
        fontSize  = mkDefault fonts.sizes.applications;
      };
      gedit.enable = mkDefault true;
      gnome.enable = true;
      gtk = {
        enable = true;
        # Extra code added to both `$XDG_CONFIG_HOME/gtk-{3,4}.0/gtk.css`
        #extraCss = ''
        #'';
      };
      kitty    = { enable = mkDefault true; variant256Colors = mkDefault false; };
      swaylock = { enable = mkDefault true;         useImage = mkDefault true;  };
      waybar = {
        enable = mkDefault true;
        enableCenterBackColors = mkDefault false;
        enableLeftBackColors   = mkDefault false;
        enableRightBackColors  = mkDefault false;
      };
      xresources.enable = true;
    };
  };

  home.packages = with inputs.stylix.${pkgs.system}; [docs palette-generator];

}
