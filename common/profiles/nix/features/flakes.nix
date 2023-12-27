{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ];
  nix = {
    # Use Nix package manager package with builtin flakes support
    package = lib.mkDefault pkgs.nixFlakes; #pkgs.nixFlakes; #(nixUnstable for use-xdg-base-directories, nixFlakes for flakes support)
    settings = {
      accept-flake-config = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      #use-flake-registry = true; #config.nix.settings.use-registries;
    };
  };

  environment = {
    sessionVariables = let flakeDir = "~/.config/nixos"; in {
      NIX_FLAKE_SYSTEM = lib.mkDefault flakeDir;
      NIX_FLAKE_HOME = lib.mkDefault flakeDir;
    };

    shellAliases = {
      n-flake = "nix flake";
      flake = "nix flake";
      nf = "nix flake";
      nf-help = "nix flake --help";
      nf-archive = "nix flake archive";
      nf-check = "nix flake check";
      nf-clone = "nix flake clone";
      nf-info = "nix flake info";
      nf-init = "nix flake init";
      nf-lock = "nix flake lock";
      nf-metadata = "nix flake metadata";
      nf-new = "nix flake new";
      nf-prefetch = "nix flake prefetch";
      nf-show = "nix flake show";
      nf-update = "nix flake update";

      # --- Flake Dirs ---
      cfgd = "cd $NIX_FLAKE_SYSTEM";
      flakeDir = "echo $NIX_FLAKE_SYSTEM";
      flake-dir-system = "echo $NIX_FLAKE_SYSTEM";
      flake-dir-home = "echo $NIX_FLAKE_HOME";
      flake-cd-system = "cd $NIX_FLAKE_SYSTEM";
      flake-cd-home = "cd $NIX_FLAKE_HOME";
      nf-dir-system = "echo $NIX_FLAKE_SYSTEM";
      nf-dir-home = "echo $NIX_FLAKE_HOME";
      nf-cd-system = "cd $NIX_FLAKE_SYSTEM";
      nf-cd-home = "cd $NIX_FLAKE_HOME";
    };
  };

}
