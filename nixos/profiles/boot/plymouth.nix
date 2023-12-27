{ config, lib, pkgs, ... }:
# Set quiet boot so splash isnt interrupted by scrolling boot logging text.
# TODO: Determine if using disk encryption. If so, display unlock util (requires systemd-based initrd?)
{
  #imports = [ ./quiet.nix ];
  boot = {
    plymouth = {
      enable = lib.mkDefault true;
      #extraConfig = '' ''; #                                                    # Extra lines to append to Plymouth config.
      font = "${pkgs.dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf"; # Console font. # TODO: Fonts work w/ boot console / Plymouth?
      #logo="${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png"; # OS logo img (can use files in Nix store)
      #logo=pkgs.fetchurl {url="https://nixos.org/logo/nixos-hires.png"; sha256="1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";};
      theme = "bgrt"; #"spinner-monochrome"; #                                   # Plymouth theme to use
      themePackages = [
        pkgs.nixos-bgrt-plymouth #      # pkgs.catppuccin-plymouth
        pkgs.libsForQt5.breeze-plymouth # pkgs.adi1090x-plymouth-themes
        #(pkgs.plymouth-spinner-monochrome.override { inherit (config.boot.plymouth) logo; })
      ]; #                                                                       # Packages providing Plymouth themes
    };

    # --- quiet / silent boot ---
    consoleLogLevel = lib.mkIf config.boot.plymouth.enable 0; # Lowest boot console log level
    initrd.verbose = !config.boot.plymouth.enable; #          # Minimal info to console in initrd.
    kernelParams = lib.mkIf config.boot.plymouth.enable [ "quiet" "loglevel=3" "systemd.show_status=auto" "udev.log_level=3" "rd.udev.log_level=3" "vt.global_cursor_default=0" ];
  };

  console = {
    useXkbConfig = lib.mkDefault true;
    earlySetup = lib.mkDefault false;
  };

}
