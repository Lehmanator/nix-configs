{ config, lib, pkgs, ... }:
let
  fd = lib.getExe pkgs.fd;
in
{
  # TODO: Create Nushell integration
  programs.skim = {
    enable = true;

    defaultCommand       = "${fd} --type f";
    defaultOptions       = ["--height 50%" "--prompt ⟫"];

    # TODO: Use lsd/eza in preview
    # TODO: Replace `head -200` with command to limit depth of tree
    changeDirWidgetCommand = "${fd} --type d";       # Key: ALT-C
    changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"]; 

    # TODO: Pretty-print, syntax highlight, file size limit for preview
    fileWidgetCommand    = "${fd} --type f";         # Key: CTRL-T 
    fileWidgetOptions    = ["--preview 'head {}'"]; 

    # TODO: Integrate w/ atuin
    historyWidgetOptions = ["--tac" "--exact"];      # Key: CTRL-R
  };

  # Library functions for consuming/reusing fuzzy finders in config.
  lib = rec {
    hasFzf   = config.programs.fzf.enable;   # homeProfiles.fzf should override this.
    hasSkim  = config.programs.skim.enable;
    hasFuzzy = hasFzf || lib.hasSkim;

    # TODO: Also handle previewer commands
    getFuzzyProgram = (lib.getExe (
      if hasSkim then config.programs.skim.package else
      if hasFzf  then config.programs.fzf.package  else null
    ));
  };
}
