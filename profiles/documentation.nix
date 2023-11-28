{ inputs
, self
, cell
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  documentation = {
    dev.enable = false;
    doc.enable = false;
    info.enable = true;

    man.enable = true;
    man.generateCaches = true;
    man.man-db.enable = false;
    man.mandoc.enable = true; # Note: man-db & mandoc cannot both be enabled simultaneously

    nixos.enable = true; # Include dev docs if documentation.man.enable=true (`devman`,`devinfo`,`devdoc` outputs)
    nixos.options.splitBuild = true; # Split opt docs into cacheable/not. Faster build. Some user modules may break. Default=true
    #nixos.includeAllModules = true;                   # Gen docs for options in NixOS config. Default=false (Ignores options outside baseModules)
    #nixos.extraModuleSources = [ pkgs.customModule ]; # Extra NixOS module paths gen'd documentation should strip from options. Default=[]
    #nixos.extraModules = [];                          # Modules to show options even when not imported. Default=[]
    #nixos.options.warningsAreErrors = true;           # Warning during option docs build (eg: missing option desc) treated as err. Default=true
  };

  # Manually add extra package outputs when using mandoc
  # TODO: Conditionally add extra outputs
  environment.extraOutputsToInstall = let base = [ "doc" "info" "man" ]; in lib.mkIf
    config.documentation.man.mandoc.enable
    (if config.documentation.dev.enable then (base ++ [ "devdoc" "devinfo" "devman" ]) else base);
  #  ++ (if config.documentation.dev.enable then ["devdoc"] else [])
  #  ++ (if config.documentation.info.enable then ["info"] else [])
  #;

}
