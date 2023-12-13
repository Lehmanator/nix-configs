{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./quiet.nix # Set quiet boot so splash isnt interrupted by scrolling boot logging text.
  ];

  boot.plymouth = {
    enable = true;

    # Extra lines to append to Plymouth configuration.
    #extraConfig = ''
    #'';

    # Set the console font.
    # TODO: Figure out what fonts work with boot console / Plymouth.
    font = "${pkgs.dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf";

    # Set the OS logo image. (can use files in Nix store)
    #logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
    #logo = pkgs.fetchurl {
    #  url = "https://nixos.org/logo/nixos-hires.png";
    #  sha256 = "1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";
    #};

    # Plymouth theme to use
    theme = "bgrt"; #"spinner-monochrome";

    # Packages providing Plymouth themes
    themePackages = [
      #(pkgs.plymouth-spinner-monochrome.override {
      #  inherit (config.boot.plymouth) logo;
      #})
      #pkgs.catppuccin-plymouth
      #pkgs.adi1090x-plymouth-themes
      pkgs.nixos-bgrt-plymouth
      pkgs.libsForQt5.breeze-plymouth
    ];
  };
}
