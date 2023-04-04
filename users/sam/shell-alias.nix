{
  self,
  inputs,
  system,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
let
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
    b = "bat";
    c = "cat";
    e = "$EDITOR";
    o = "xdg-open";
    v = "$VISUAL";

    # --- Programs ---------------
    w = "which";
    ppath = "echo \"$PATH\" | tr -d ':' '\n'";

    # --- Privileges -------------
    #s = lib.mkIf config.security.sudo.enable "sudo";         # TODO: Make generic
    #pk = lib.mkIf config.security.policyKit.enable "pkexec"; # TODO: Reference NixOS config

    # --- Terminal ---------------
    "cl" = "clear";    # Clear teminal output
    "she" = "$SHELL";  # Reload shell


    # --- Home-Manager -----------
    hm = "home-manager";

    # --- Development ------------
    g = "git";

  };
}
