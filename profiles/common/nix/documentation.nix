{
  config,
  lib,
  pkgs,
  ...
}: {
  documentation = {
    dev.enable = lib.mkDefault false;
    doc.enable = lib.mkDefault false;
    info.enable = lib.mkForce true;
    man = {
      enable = true;
      generateCaches = true;
      man-db.enable = false;
      mandoc.enable =
        true; # Note: man-db & mandoc cannot both be enabled simultaneously
    };
    nixos = {
      enable =
        true; # Include dev docs if documentation.man.enable=true (`devman`,`devinfo`,`devdoc` outputs)
      options.splitBuild =
        lib.mkForce
        true; # Split opt docs into cacheable/not. Faster build. Some user modules may break. Default=true
      #includeAllModules = true;                   # Gen docs for options in NixOS config. Default=false (Ignores options outside baseModules)
      #extraModuleSources = [ pkgs.customModule ]; # Extra NixOS module paths gen'd documentation should strip from options. Default=[]
      #extraModules = [];                          # Modules to show options even when not imported. Default=[]
      #options.warningsAreErrors = true;           # Warning during option docs build (eg: missing option desc) treated as err. Default=true
    };
  };
}
