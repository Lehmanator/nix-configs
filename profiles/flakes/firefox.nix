{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    system,
    inputs',
    ...
  }:
  {
    # TODO: Create wrapped firefox versions
    packages = rec {
      # TODO: Also "${pkgs.firefox-css-sidebar}/sidebery-data.json"
      firefox-css-adwaita-sidebar = pkgs.writeText "adwaita-userChrome.css" ''
        @import "${firefox-gnome-theme}/userChrome.css";
        @import "${firefox-css-sidebar}/userChrome.css";
        @import "${firefox-css-sidebar}/extensions/sidebar.css";
        @import "${firefox-css-sidebar}/themes/gtk_adwaita.css";
      '';
      firefox-css-hacks = pkgs.callPackage ../../pkgs/nixos/firefox-css/firefox-csshacks.nix {};
      firefox-css-sidebar = pkgs.callPackage ../../pkgs/nixos/firefox-css/firefox-sidebar.nix {};
      firefox-gnome-theme = pkgs.callPackage ../../pkgs/nixos/firefox-css/firefox-gnome-theme.nix {};
      #firefox-gnome-theme = pkgs.callPackage ../../pkgs/nixos/themes/firefox-gnome-theme.nix {};
      thunderbird-gnome-theme = pkgs.callPackage ../../pkgs/nixos/themes/thunderbird-gnome-theme.nix {};
    };
  };
  flake = {
    #nixvimModules = {default = ../nixvim;};
  };
}
