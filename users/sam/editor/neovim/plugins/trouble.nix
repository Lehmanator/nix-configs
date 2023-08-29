{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.plugins.trouble = {
    enable = true;

    autoClose   = true;    # Auto close list when no diagnostics.     D=f
    autoFold    = false;   # Auto fold file trouble list at creation. D=f
    autoOpen    = false;   # Auto open list when diagnostics avail.   D=f
    autoPreview = true;    # Auto preview diagnostic location. <ESC>=close+back-to-last=window. D=t
    autoJump = [           # Auto jump when single result for given modes
      "lsp_definitions"
    ];

    group = true;          # Group results by file.                   D=t
    mode = "workspace_diagnostics"; # workspace_diagnostics | document_diagnostics | quickfix | lsp_references | loclist

    # --- Styles ---
    foldOpen    = lib.mkDefault "";       # Icon for closed folds. D=
    foldClosed  = lib.mkDefault "";       # Icon for closed folds. D=
    height      = lib.mkDefault 10;        # List lines if position=top|bottom. D=10
    width       = lib.mkDefault 50;        # List cols  if position=left|right. D=50
    icons       = lib.mkDefault true;      # Use devicons for filenames.        D=t
    indentLines = lib.mkDefault true;      # Add indent guide below fold icons. D=t
    padding     = lib.mkDefault true;      # Add extra new line to top of list. D=t
    position    = lib.mkDefault "bottom";  # Position of trouble list.          D=bottom
    useDiagnosticSigns = true;             # Use LSP-defined diagnostic signs.  D=f

    #extraOptions = {};
    #package = pkgs.vimPlugins.trouble-nvim;
  };
}
