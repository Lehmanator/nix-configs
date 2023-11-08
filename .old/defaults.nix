{
  # --- More Flakes: https://github.com/NixOS/nixos-search/blob/main/flakes/manual.toml ---
  inputs =
    #let
    #  fnp = flakeInput: flakeInput // { inputs.nixpkgs.follows = "nixpkgs"; };
    #  ffu = flakeInput: flakeInput // { inputs.flake-utils.follows = "flake-utils"; };
    #  fu = flakeInput: flakeInput // { inputs.utils.follows = "flake-utils"; };
    #  no-flake = flakeInput: flakeInput // { flake = false; };
    #in
  {
  };
  outputs = { self, nixpkgs, nur, flake-utils, flake-utils-plus, std, hive, ... }@inputs:
  let
      this = import ./pkgs;
      #flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
      #  nurpkgs = import nixpkgs { inherit system; };
      #};)
      #supportedSystems = ["x86_64-linux" "aarch64-linux"];
      #forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (s: f s);
      system = "x86_64-linux";
      #networks = import ./networks.nix;
      #machines = import ./machines.nix;
      #users = import ./users.nix;
      testingvar = false;

      defaults = with inputs; {
        userPrimary = "sam";
        modules = rec {
          #installer = with nixos-images.nixosModules; [ noninteractive kexec-installer netboot-installer ];
          nixos = [
            agenix.nixosModules.default
            arion.nixosModules.arion
            disko.nixosModules.disko
            nixos-flatpak.nixosModules.default
            harmonia.nixosModules.harmonia
            home.nixosModules.home-manager
            { home-manager.sharedModules = hm-nixos ++ hm-always; }
            impermanence.nixosModules.impermanence
            kubenix.nixosModules.kubenix
            lanzaboote.nixosModules.lanzaboote
            musnix.nixosModules.musnix
            #nix-data.nixosModules.default
            nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            nix-minecraft.nixosModules.minecraft-servers
            nix-netboot-serve.nixosModules.nix-netboot-serve
            nix-serve-ng.nixosModules.default
            nixvim.nixosModules.nixvim # nix-community/nixvim
            nur.nixosModules.nur
            robotnix.nixosModule
            robotnix.nixosModules.attestation-server
            snowflake.nixosModules.snowflake
            scalpel.nixosModule
            sops-nix.nixosModules.sops
            #stylix.nixosModules.stylix
            systemd-vaultd.nixosModules.vaultAgent
            systemd-vaultd.nixosModules.systemdVaultd
            vaultModule.nixosModule
            vscode-server.nixosModule
            wirenix.nixosModules.default
          ];
          darwin = [
            agenix.nixDarwinModules.default
            home.darwinModule
            nix-index-database.darwinModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            nixvim.nixDarwinModules.nixvim
            #stylix.darwinModules.stylix
          ];
          hm-only = [ ];
          hm-nixos = [ ];
          hm-always = [
            agenix.homeManagerModules.default
            arkenfox.hmModules.default
            home-extra-xhmm.homeManagerModules.all
            nix-index-database.hmModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            nixos-flatpak.homeManagerModules.default
            nixpkgs-android.hmModule
            nixvim.homeManagerModules.nixvim
            sops-nix.homeManagerModules.sops
            #stylix.homeManagerModules.stylix
          ];
          hm = hm-always;
          system = [ ];
          nix-on-droid = [ ];
          wsl = [ ];
          nix = [ ];
          flake-parts = [
            devshell.flakeModule
            flake-root.flakeModule
            mission-control.flakeModule
            treefmt-nix.flakeModule
          ];
        };
        overlays = {
          nixos = [
            nix-minecraft.overlay
            lanzaboote.overlays.default
          ];
          darwin = [
          ];
          hm = [
          ];
          nix = [
            self.overlays.default
            agenix.overlays.default
            fenix.overlays.default
            harmonia.overlays
            kubenix.overlays.default
            mineflake.overlays.default
            neovim-nightly-overlay.overlay
            #nix-vscode-extensions.overlays.default
            nixgl.overlay
            nixpkgs-mozilla.overlay
            nixpkgs-terraform-providers.overlay
            nixpkgs-wayland.overlay
            nmd.overlays.default
            nuenv.overlays.default
            nur.overlay
            nurl.overlay
            patchelf.overlays.default
            rnix-parser.overlay
            #terrasops.overlay
            { devour-flake = self.callPackage inputs.flake-devour { }; }
          ];
        };
      };

    };

  in
  #flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ]A (system:
  #let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ];};)
  flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system} // {
      overlays = [
        self.overlays.default
        inputs.nixpkgs-mozilla.overlay
        inputs.nuenv.overlays.default # https://determinate.systems/posts/nuenv
        inputs.nur.overlay
        inputs.nurl.overlay
        inputs.nix-alien.overlays.default
        #inputs.terrasops.overlay
      ];
    };
  in rec {
    packages = this.packages pkgs; # // { inherit (pkgs) terrasops; };
    legacyPackages = pkgs;
    devShells.default = with pkgs; mkShell {
      nativeBuildInputs = [
        colmena
        mdbook
        #terrasops
        nvfetcher
      ];
    };
    #formatter = pkgs.nixpkgs-fmt;
    formatter = inputs.treefmt-nix.lib.mkWrapper pkgs {
      projectRootFile = "flake.nix";
      programs.nixpkgs-fmt.enable = true;
      #programs.alejandra.enable = true;
    };
  }) // (std.growOn
  {
    # --- Declare projects & component types here ---
    inherit inputs;
    # blockTypes:
    # - std:  anything, arion, containers, data, devshells, files, functions, installables, microvms, nixago, nomadJobManifests, pkgs, runnables
    # - hive: colmenaConfigurations, darwinConfigurations, diskoConfigurations, homeConfigurations, nixosConfigurations
    cellsFrom = ./cells;
    cellBlocks = [
      (std.blockTypes.installables "packages" { ci.build = true; })
      (std.blockTypes.devshells "devshells" { ci.build = true; })
    ];
  }
  {
    # --- Declare collected output structure here ---
    # TODO: Create `nixosModules`, `homeManagerModules`, & `flakeModules`
    devShells = std.harvest self [ "flatpakify" "devshells" ];
    packages = std.harvest self [ "flatpakify" "packages" ];
  }) //
  {
    overlays.default = final: prev: (nixpkgs.lib.composeExtensions this.overlay final prev);
    nixosConfigurations = {
      fw = inputs.nixos.lib; {
        system="x86_64-linux";
        modules = [
          #{nixpkgs.overlays=[(self: super: {gnome=nixpkgs-gnome.legacyPackages.x86_64-linux.gnome;})];}
          disko.nixosModules.disko {disko.enableConfig=false;}
          home-manager.nixosModules.home-manager { home-manager = {
            sharedModules = [
              #(import ./users/default/nixos {};)
              arkenfox.hmModules.default
              nix-index.hmModules.nix-index {programs.nix-index-database.comma.enable=true;}
              #nixvim.homeManagerModules.nixim
              #nixpkgs-android.hmModule { inherit config lib pkgs; android-sdk = {
              #  enable = true;
              #  packages = sdk: with sdk; [ emulator cmdline-tools-latest
              #    platform-tools platform-android-34 sources-android-34 build-tools-34-0-0
              #  ];
              #};}
          };}
        ];
      };
        fajita = nixosSystem {
          system = "aarch64-linux";
          modules = with inputs; [
            snowflake.nixosModules.snowflake
            nixpkgs-gnome-mobile.nixosModules.gnome-mobile
            nix-data.nixosModules."aarch64-linux".nix-data
            nix-index.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            { _module.args = { inherit inputs; }; }
            (import "${nixos-mobile}/lib/configuration.nix" { device = "oneplus-fajita"; })
            ./hosts/fajita/configuration.nix
          ];
          specialArgs = { inherit self inputs system; user = defaults.userPrimary; };
        };

        srl-dc01 = nixosSystem {
          system = "aarch64-linux";
          modules = with inputs; [
            #{ _module.args = { inherit inputs; }; }
            agenix.nixosModules.default
            ./hosts/srl-dc01
          ];
          specialArgs = { inherit self inputs system; user = defaults.userPrimary; };
        };
      };

      #darwinConfigurations.m2 = nixpkgs.lib.darwinSystem {
      #  system = "aarch64-darwin";
      #  modules = defaults.modules.darwin ++ [
      #    ./hosts/m2
      #    home.darwinModule { home-manager = {
      #      extraSpecialArgs = { inherit self inputs system; };
      #      sharedModules = defaults.modules.hm-always ++ self.homeManagerModules ++ ./users/common;
      #      useGlobalPkgs = true;
      #      useUserPackages = true;
      #      users = { guest = import ./users/guest/home.nix;
      #                 main = import ./users/main/home.nix;   };
      #    }; }
      #  ];
      #};

      #homeConfigurations = with inputs.home.lib; {
      #  sam = homeManagerConfiguration {
      #    inherit pkgs;
      #    modules = [ ./users/sam     #./users/sam/home.nix
      #      nix-index.hmModules.nix-index {programs.nix-index-database.comma.enable=true;}
      #    ];
      #  };
      #};

      # --- OS Images ---
      #fajita-fastboot-images = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-fastboot-images;
      #fajita-flashable-zip = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-flashable-zip;
      packages.nixos-images.fajita = with inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android; {
        fastboot      = android-fastboot-images;
        flashable-zip = android-flashable-zip;
      };

      #modules = flake-utils.lib.eachDefaultSystem (system: let
      #  inherit inputs;
      #  nurpkgs = import nixpkgs {inherit system;};
      #in [
      # NUR repos via package overrides
      #{ nixpkgs.config.packageOverrides = pkgs: {
      #  inherit inputs system;
      #  nur = import inputs.nur {
      #    inherit pkgs nurpkgs;
      #    repoOverrides = {
      #      #local     = import inputs.nur-local { inherit pkgs; };
      #      #publicSam = import inputs.nur-repo { inherit pkgs; };
      #    };
      #  }; };
      #}
      # NUR repos via overlays
      #{ nixpkgs.overlays = let pkgs = nixpkgs.legacyPackages.${system}; in [ (final: prev: {
      #  inherit inputs system pkgs;
      #  #pkgs = import nixpkgs {inherit system;};
      #  nur = import inputs.nur {
      #    inherit pkgs nurpkgs;
      #    repoOverrides = {
      #      #local    = import inputs.nur-local { inherit pkgs; };
      #      #publicSam = import inputs.nur-repo { inherit pkgs; };
      #    };
      #  };
      #})];
      #}
      #]); # --- End: outputs.modules ---

      apps = {
        nextcloud-next26 = let helmish = inputs.nix-helm.deployments; in
          helmish: {
            nextcloud = import ./helm/nextcloud.nix { inherit helmish; };
          };
      };
  }
}
