{ config, lib, pkgs, user, ... }:
let
  inherit (lib) optionalString;
  desktop = lib.toLower config.xserver.displayManager.defaultSession;
  usesTheme = builtins.elem desktop;
  prefers-dark = false;
  highcontrast = false;
in
{
  # styles = OneOf: "adwaita", "adwaita-dark", "adwaita-highcontrast", "adwaita-highcontrastinverse", "bb10bright", "bb10dark", "breeze", "cde", "cleanlooks", "gtk2", "kvantum", "motif", "plastique"
  qt = {
    enable = lib.mkDefault true;
  } // (
    if usesTheme ["gnome" "gnome-mobile" "phosh" "mate" "budgie"] then
      { platformTheme="gnome"; style="adwaita"
        + optionalString ( prefers-dark && !highcontrast) "-dark"
        + optionalString ( prefers-dark &&  highcontrast) "-highcontrastinverse"
        + optionalString (!prefers-dark &&  highcontrast) "-highcontrast"; }
    else if usesTheme ["gnome-fallback" "gnome-classic"] then
      { platformTheme="gtk2"; style="gtk2"; }
    else if usesTheme ["plasma" "kde"]                   then
      { platformTheme="kde";  style="breeze"; }
    else if usesTheme ["lxqt"]                           then
      { platformTheme="lxqt";  style="bb10" + (if prefers-dark then "bright" else "dark"); }
    else
      { platformTheme="qt5ct"; style="gtk2"; }
  );

  home-manager = {
    sharedModules = [{ qt = config.qt; }];
    users.${user}.config.qt = config.qt;
  };
}
