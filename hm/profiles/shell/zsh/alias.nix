{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.zsh = {

    # --- Global Aliases ---
    # These aliases can be expanded anywhere in line
    shellGlobalAliases = {
      CAT = "| cat";
      RG = "| rg";
      LO = "| lessopen";
      PAGER = "| $PAGER";
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
    };

    # --- Regualar Aliases ---
    # Only for zsh-specific shell aliases
    # Generic aliases should go in `../common/alias.nix`
    shellAliases = {
      pfpath = "echo \"$fpath\" | tr ' ' '\n'";
    };

  };
}
