{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.trouble = {
    enable = true;
    settings = {
      autoClose = true; # Auto close list when no diagnostics.     D=f
      autoFold = false; # Auto fold file trouble list at creation. D=f
      autoOpen = false; # Auto open list when diagnostics avail.   D=f

      # Auto preview diag loc
      #<ESC>=close+back-to-last=window. D=t
      autoPreview = true;

      # Auto jump when single result for given modes
      autoJump = ["lsp_definitions"];

      group = true; # Group results by file.                   D=t
      mode = "workspace_diagnostics"; # workspace_diagnostics | document_diagnostics | quickfix | lsp_references | loclist

      # --- Styles ---
      foldOpen = lib.mkDefault ""; # Icon for closed folds. D=
      foldClosed = lib.mkDefault ""; # Icon for closed folds. D=
      height = lib.mkDefault 10; # List lines if position=top|bottom. D=10
      width = lib.mkDefault 50; # List cols  if position=left|right. D=50
      icons = lib.mkDefault true; # Use devicons for filenames.        D=t
      indentLines = lib.mkDefault true; # Add indent guide below fold icons. D=t
      padding = lib.mkDefault true; # Add extra new line to top of list. D=t
      position = lib.mkDefault "bottom"; # Position of trouble list. D=bottom
      useDiagnosticSigns = true; # Use LSP-defined diagnostic signs.  D=f

      #extraOptions = {};
      signs = {
        error = "";
        hint = "";
        information = "";
        other = "﫠";
        warning = ""; # warning = "";
      };
    };
  };
}
