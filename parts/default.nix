{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.hercules-ci-effects.flakeModule
    inputs.nix-cargo-integration.flakeModule
    # inputs.process-compose-flake.flakeModule
    # inputs.proc-flake.flakeModule
    # inputs.std.flakeModule

    ./agenix-shell.nix
    ./devshell.nix
    # ./emanote.nix
    # ./ez-configs.nix
    ./pre-commit-hooks.nix
    ./treefmt.nix
    ./wrapper-manager

    # --- Unimplemented ---
    # ./devenv.nix
    # ./easyOverlay.nix
    # ./flake-parts-website.nix
    # ./hercules-ci.nix
    # ./nix-cargo-integration.nix
    # ./nixid.nix
    # ./process-compose-flake.nix
    # ./proc-flake.nix
    # ./std.nix
  ];
}
