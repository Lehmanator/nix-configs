{
  config,
  lib,
  pkgs,
  ...
}:
# Use Nix package manager package with builtin flakes support
{
  nix = {
    package = lib.mkDefault pkgs.nixVersions.latest;
    settings = {
      accept-flake-config = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      #use-flake-registry = true; #config.nix.settings.use-registries;
    };
  };

  environment = {
    sessionVariables = let
      flakeDir = "$HOME/.config/nixos";
    in {
      NIX_BIN_DIR = "${config.nix.package}/bin";
      FLAKE_SYSTEM = lib.mkDefault flakeDir;
      FLAKE_HOME = lib.mkDefault flakeDir;
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
      cfgd = "cd $FLAKE_SYSTEM";
      flakeDir = "echo $FLAKE_SYSTEM";
      flake-dir-system = "echo $FLAKE_SYSTEM";
      flake-dir-home = "echo $FLAKE_HOME";
      flake-cd-system = "cd $FLAKE_SYSTEM";
      flake-cd-home = "cd $FLAKE_HOME";
      nf-dir-system = "echo $FLAKE_SYSTEM";
      nf-dir-home = "echo $FLAKE_HOME";
      nf-cd-system = "cd $FLAKE_SYSTEM";
      nf-cd-home = "cd $FLAKE_HOME";
    };
  };
}
