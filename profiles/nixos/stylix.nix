{ self, inputs, config, lib, pkgs,
  host, repo, network, user,
  ...
}:
{
  imports = [
  ];

  stylix = {
    autoEnable = lib.mkDefault true;
    #base16Scheme = {};

    homeManagerIntegration.autoImport   = true;
    homeManagerIntegration.followSystem = true;

    #image    = lib.mkDefault "";
    override = lib.mkDefault {};
    polarity = lib.mkDefault "either";

    fonts = {
      emoji     = { name = "Noto Color Emoji"; package = pkgs.noto-fonts-emoji; };
      monospace = { name = "Maple Mono";       package = pkgs.maple-mono-NF;   };
      serif     = { name = "DejaVu Serif";     package = pkgs.dejavu-fonts;    };
      sansSerif = { name = "Cantarell";        package = pkgs.cantarell-fonts; };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };

    };

    targets = {
      chromium.enable = lib.mkDefault true;
      console.enable  = lib.mkDefault true;
      feh.enable      = lib.mkDefault true;
      fish.enable     = lib.mkDefault true;
      gnome.enable    = lib.mkDefault true;
      gtk.enable      = lib.mkDefault true;
      lightdm.enable  = lib.mkDefault true;
      grub.useImage   = lib.mkDefault true;
      grub.enable              = config.boot.loader.grub.enable;
      plymouth.enable          = config.boot.plymouth.enable;
      plymouth.blackBackground = config.boot.loader.systemd-boot.enable;
      #plymouth.logo = <path|package>;
    };
  };
}
