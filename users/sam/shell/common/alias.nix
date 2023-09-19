{ self
, inputs
, system
, hosts
, userPrimary
, config
, lib
, pkgs
, ...
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
    edit = "$EDITOR";
    o = mkIf config.xdg.enable "xdg-open";
    open = mkIf config.xdg.enable "xdg-open";
    v = "$VISUAL";
    vedit = "$VISUAL";

    mkd = "mkdir -p";

    # --- Programs ---------------
    w = "which -a";
    ppath = "echo \"$PATH\" | tr  ':' '\n'";
    pnixpath = "echo \"$NIX_PATH\" | tr : '\n'";

    # --- Privileges -------------
    #s  = lib.mkIf config.security.sudo.enable "sudo";        # TODO: Make generic
    #pk = lib.mkIf config.security.policyKit.enable "pkexec"; # TODO: Reference NixOS config

    # --- Terminal ---------------
    "cl" = "clear"; # Clear teminal output
    "she" = "$SHELL"; # Reload shell

    # --- Home-Manager -----------
    hm = mkIf config.programs.home-manager.enable "home-manager";

    # --- Network ----------------
    ip-address = "curl ipconfig.me";

    # --- Development ------------
  };

}
