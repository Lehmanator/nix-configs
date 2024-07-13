{ inputs
, config, lib, pkgs
, user
, ...
}: with lib;
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  environment.systemPackages = with inputs.stylix.packages.${pkgs.system}; [docs palette-generator];

  stylix = {
    autoEnable = lib.mkDefault true;
    #base16Scheme = {};
    homeManagerIntegration = {
      autoImport   = true; # TODO: Conditionally import stylix hmModule when not using NixOS.
      followSystem = true; # TODO: Figure out if home-manager options disappear when set.
    };
    #image   = mkDefault "";
    override = lib.mkDefault {};
    polarity = lib.mkDefault "either";
    fonts = with pkgs; {
      emoji     = { name = "Noto Color Emoji"; package = noto-fonts-emoji; };
      monospace = { name = "Maple Mono";       package = maple-mono-NF;    };
      serif     = { name = "DejaVu Serif";     package = dejavu-fonts;     };
      sansSerif = { name = "Cantarell";        package = cantarell-fonts;  };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };

    targets = {
      chromium.enable = config.programs.chromium.enable;
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
  home-manager.sharedModules = [inputs.stylix.homeManagerModules.stylix];
}
