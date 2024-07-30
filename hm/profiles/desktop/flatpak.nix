{ config, lib, pkgs, ... }: {
  home.shellAliases = let
    args = lib.cli.toGNUCommandLineShell {} {
      assumeyes = true;
      noninteractive = false;
    };
  in rec {
    fp   = "flatpak";
    fpb  = fp + " build";
    fpo  = fp + " override";
    fps  = fp + " search";
    fpun = fp + " uninstall";
    fpi  = fp + " install --or-update" + args;
    fpup = fp + " update " + args;
    fpu  = fpup;
  };
}
#(lib.optionalAttrs (lib.hasAttrByPath ["services" "flatpak" "packages"] options) {
#  services.flatpak = {
#    remotes = flatpak-repos;
#    preInitCommand = "";
#    postInitCommand = "";
#    flatpak.packages = [ ]; # TODO: Add all default packages (runtimes, SDKs, themes, libs, plugins, codecs, etc.)
#  };
#})
