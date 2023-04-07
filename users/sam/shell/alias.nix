{
  self,
  inputs,
  system,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
in
{
  imports = [
  ];


  home.shellAliases = {
    # --- Directory Navigation ---
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    # --- Files ------------------
    c = "cat";
    e = "$EDITOR";
    o = mkIf config.xdg.enable "xdg-open";
    v = "$VISUAL";

    # --- Programs ---------------
    w = "which -a";
    ppath = "echo \"$PATH\" | tr -d ':' '\n'";

    # --- Privileges -------------
    #s = lib.mkIf config.security.sudo.enable "sudo";         # TODO: Make generic
    #pk = lib.mkIf config.security.policyKit.enable "pkexec"; # TODO: Reference NixOS config

    # --- Terminal ---------------
    "cl" = "clear";    # Clear teminal output
    "she" = "$SHELL";  # Reload shell


    # --- Home-Manager -----------
    hm = mkIf config.programs.home-manager.enable "home-manager";

    # --- Development ------------
    g = mkIf config.programs.git.enable "git";
  };

  # --- ZSH Global Aliases ---
  # These aliases can be expanded anywhere in line
  programs.zsh.shellGlobalAliases = {
    CAT = "| cat";
    RG = "| rg";
    LO = "| lessopen";
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
  };
}
