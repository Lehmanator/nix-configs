{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];

  # VSCode-like window symbol hierarchy/scope/nesting line
  programs.nixvim.plugins.barbecue = {
    enable = true;
    attachNavic = true; # Attach navic to language servers automatically
    contextFollowIconColor = false; # Whether context text should follow its icon's color
    createAutocmd = true; # Create winbar updater autocmd
    showBasename = true;
    showDirname = true;
    showModified = true;
    showNavic = true;
    #theme = "auto";

    # --- Conditional Display ----------
    excludeFiletypes = [ "netrw" "toggleterm" ];
    includeBuftypes = [ "" ]; # Buftypes to enable winbar in

    # --- Icons ------------------------
    kinds = {
      Array = "";
      Boolean = "";
      Class = "";
      Constant = "";
      Constructor = "";
      Enum = "";
      EnumMember = "";
      Event = "";
      Field = "";
      File = "";
      Function = "";
      Interface = "";
      Key = "";
      Method = "";
      Module = "";
      Namespace = "";
      Null = "";
      Number = "";
      Object = "";
      Operator = "";
      Package = "";
      Property = "";
      String = "";
      Struct = "";
      TypeParameter = "";
      Variable = "";
    };
    # --- Overrides --------------------
    customSection = ''
      function() return " " end
    '';
    leadCustomSection = ''
      function() return " " end
    '';
    modified = ''
      function(bufnr) return vim.bo[bufnr].modified end
    '';

    # Attrs will be added to the table parameter for the setup function. (Can override other attrs set by Nixvim)
    extraOptions = { };

  };

}
