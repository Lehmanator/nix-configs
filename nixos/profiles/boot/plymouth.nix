{ config, lib, pkgs, ... }:
#
# Set quiet boot so splash isnt interrupted by scrolling boot logging text.
# TODO: Determine if using disk encryption. If so, display unlock util (requires systemd-based initrd?)
#
{
  imports = [ ./quiet.nix ];
  boot = {
    plymouth = with pkgs; {
      enable = lib.mkDefault true;

      # Console font.
      # TODO: Font work w/ boot-console/Plymouth?
      # TODO: Share font with desktop?
      #font = "${dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf";
      font = "${cantarell-fonts}/share/fonts/cantarell/Cantarell-VF.otf";

      # OS logo img (can use files in Nix store)
      #logo="${nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      #logo = fetchurl {url="https://nixos.org/logo/nixos-hires.png"; sha256="1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";};

      # Tutorials to create Plymouth themes:
      # - https://brej.org/blog/?p=197
      # - https://brej.org/blog/?p=238
      # Options: bgrt | spinner-monochrome | details | fade-in | glow |
      #        script | solar | spinfinity | spinner | breeze  | text | tribar
      theme = "spinner";

      # Packages providing Plymouth themes
      #  (plymouth-spinner-monochrome.override { inherit (config.boot.plymouth) logo; })
      themePackages = with pkgs; [adi1090x-plymouth-themes catppuccin-plymouth libsForQt5.breeze-plymouth nixos-bgrt-plymouth];

      # Extra lines to append to Plymouth config.
      extraConfig = ''
        DeviceScale=2
      '';
    };
  };

  console = {
    useXkbConfig = lib.mkDefault true;
    earlySetup = lib.mkDefault false;
  };
}
