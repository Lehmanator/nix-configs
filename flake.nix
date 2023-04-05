{
  nixConfig = {
    connect-timeout = 10;
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    snowflake.url = "github:snowflakelinux/snowflake-modules";
    snowflake.inputs.nixpkgs.follows = "nixpkgs";
    nix-data.url = "github:snowflakelinux/nix-data";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    snow.url = "github:snowflakelinux/snow";
    icicle.url = "github:snowflakelinux/icicle";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
    nixvim.url = github:pta2002/nixvim;

    agenix           = { url = "github:ryantm/agenix";         inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix         = { url = "github:Mic92/sops-nix";        inputs.nixpkgs.follows = "nixpkgs"; };

    flake-utils      = { url = "github:numtide/flake-utils";                                       };
    flake-utils-plus = { url = "github:gytis-ivaskevicius/flake-utils-plus";                       };
    flake-compat     = { url = "github:edolstra/flake-compat"; flake = false;                      };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (s: f s);
      system = "x86_64-linux";
      #networks = import ./networks.nix;
      #machines = import ./machines.nix;
      #users = import ./users.nix;
    in
    {
      #overlays.default = final: prev: {
      #  <pname> = final.callPackages ./pkgs/<pname> { };
      #};
      #packages = forAllSystems (system: let
      #  pkgs = import nixpkgs { inherit system; overlays = [self.overlays.default]; };
      #in { 
      #  inherit (pkgs) <pname>;
      #});

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
            home-manager.sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
	    home-manager.useGlobalPkgs = false;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {
	      inherit self;
	      inherit inputs;
	      inherit system;
	    };
	    home-manager.users.sam = import ./users/sam;
	  }
        ];
        specialArgs = {
	  inherit self;
	  inherit inputs;
	  inherit system;
	};
    };
  };
}
