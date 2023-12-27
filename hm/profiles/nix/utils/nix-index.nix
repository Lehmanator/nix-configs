{ inputs
, ...
}:
{
  # --- nix-index-database -----------------------
  #
  # Indexes the nix store like `nix-index`,
  # but uses a pre-built database cached from the web
  #
  # Flake:
  # ```nix
  #   inputs = { home-manager.url = "github:nix-community/home-manager";
  #        nix-index-database.url = "github:Mic92/nix-index-database";
  #              home-manager.inputs.nixpkgs.follows = "nixpkgs";
  #        nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  #   };
  #   outputs = { nixpkgs, home-manager, nix-index-database, ... }:
  #     nixosConfigurations.<hostname> = nixpkgs.lib.nixosSystem {
  #       modules = [nix-index-database.nixosModules.nix-index {programs.nix-index-database.comma.enable=true;}];};
  #     homeConfigurations.<username> = home-manager.lib.homeManagerConfiguration { inherit pkgs; modules=[nix-index-database.hmModules.nix-index {programs.nix-index-database.comma.enable=true;}];};
  #   };
  # ```
  #
  # Links:
  # - [Repo](https://github.com/nix-community/nix-index-database)
  #
  # Notes:
  #
  # - Provides: `nixosModules.nix-index` & `hmModules.nix-index`
  # - Replaces: `pkgs.comma`

  #
  # Integrations: (replaces package w/ DB cache wrapped version)
  # - pkgs.nix-index:         Find nixpkg providing file from binary cacche drvs
  # - pkgs.comma:             Run packages without installing
  # - pkgs.command-not-found: Show nix info upon missing shell command
  # - pkgs.lorri:
  #
  # To-Dos:
  #
  # - [ ] TODO: Insert repo & documentation links
  # - [ ] TODO: Insert usage information
  # - [ ] TODO: Describe module behavior
  # - [ ] TODO: Determine if works in standalone Nix & NixOS?
  # - [ ] TODO: Remove incompatible option calls elsewhere in config
  # - [ ] TODO: Disable `comma`?
  # - [ ] TODO: Disable `services.lorri.enable = false`?
  # - [ ] TODO: Enable in devShells?
  # - [ ] TODO: Pass config directly to module import?
  # - [ ] TODO: Move import to `flake.nix` module defaults attrset?
  #
  imports = [ inputs.nix-index-database.hmModules.nix-index ];
  programs.nix-index-database.comma.enable = true;
}
