{
  description = "Flake inputs that were once used, no longer actively used, but may be used in the future";

  # --- flakeModules -------------------------------------------------
  inputs = {
    ez-configs = {url = "github:ehllie/ez-configs"; inputs={nixpkgs.follows="nixpkgs"; flake-parts.follows="flake-parts";};};
    flake-parts-website.url = "github:hercules-ci/flake.parts-website";  # Contains all flake-parts modules in docs.
  };

  # --- nixosModules -------------------------------------------------
  inputs = {
    # Fork of: "https://github.com/djanatyn/ssbm-nix";
    # Discontinued in favor of: https://github.com/lytedev/slippi-nix
    ssbm-nix.url = "github:lytedev/ssbm-nix"; 
  };

  outputs = { self, ... }@inputs: {
  };
}
