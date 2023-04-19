{
  nixConfig = {
    connect-timeout = 10;
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    snowflake           = { url = "github:snowflakelinux/snowflake-modules";                               };
    nix-data            = { url = "github:snowflakelinux/nix-data";                                        };
    nix-software-center = { url = "github:vlinkz/nix-software-center";                                     };
    nixos-conf-editor   = { url = "github:vlinkz/nixos-conf-editor";                                       };
    snow                = { url = "github:snowflakelinux/snow";                                            };
    icicle              = { url = "github:snowflakelinux/icicle";                                          };
    nixos-hardware      = { url = "github:NixOS/nixos-hardware";                                           };
    disko               = { url = "github:nix-community/disko";        inputs.nixpkgs.follows = "nixpkgs"; };

    home                = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur                 = { url = "github:nix-community/NUR";                                              };
    nixvim              = { url = "github:pta2002/nixvim";             inputs.nixpkgs.follows = "nixpkgs"; };

    agenix              = { url = "github:ryantm/agenix";              inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix            = { url = "github:Mic92/sops-nix";             inputs.nixpkgs.follows = "nixpkgs"; };

    flake-utils         = { url = "github:numtide/flake-utils";                                            };
    flake-utils-plus    = { url = "github:gytis-ivaskevicius/flake-utils-plus";                            };
    flake-compat        = { url = "github:edolstra/flake-compat";                           flake = false; };

    android-nixpkgs     = { url = "github:tadfisher/android-nixpkgs";  inputs.nixpkgs.follows = "nixpkgs"; };
    nixGL               = { url = "github:guibou/nixGL";                                                   };
    nvfetcher           = { url = "github:berberman/nvfetcher";        inputs.nixpkgs.follows = "nixpkgs"; };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.rust-overlay.follows = "rust-overlay";
    };

  };
  outputs = { self, nixpkgs, nur, flake-utils, flake-utils-plus, ... }@inputs: let

    #flake-utils.lib.eachDefaultSystem (system:
    #  let pkgs = nixpkgs.legacyPackages.${system}; in {
    #    nurpkgs = import nixpkgs { inherit system; };
    #  }
    #)

    #supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    #forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (s: f s);
    system = "x86_64-linux";
    #networks = import ./networks.nix;
    #machines = import ./machines.nix;
    #users = import ./users.nix;
  in {
    nixosConfigurations."fw" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/fw/configuration.nix
        inputs.snowflake.nixosModules.snowflake
        inputs.nix-data.nixosModules.${system}.nix-data
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        inputs.nur.nixosModules.nur
        inputs.agenix.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.home.nixosModules.home-manager {
          home-manager = {
            sharedModules = with inputs; [
              sops-nix.homeManagerModules.sops
              android-nixpkgs.hmModule
            ];
            useGlobalPkgs = false;
            useUserPackages = true;
            extraSpecialArgs = { inherit self inputs system; };
            users.sam = import ./users/sam;   # ./users/sam/home.nix
          };
        }
      ];
      specialArgs = { inherit self inputs system; };
    };

    #homeConfigurations.sam = inputs.home.lib.homeManagerConfiguration {
    #  inherit pkgs;
    #  modules = [
    #    ./users/sam   #./users/sam/home.nix
    #  ];
    #};


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
  };  # --- End: outputs ---
}
