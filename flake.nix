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
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations."fw" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/fw/configuration.nix
          inputs.snowflake.nixosModules.snowflake
          inputs.nix-data.nixosModules.${system}.nix-data
	  inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
	  inputs.nur.nixosModules.nur
	  inputs.home.nixosModules.home-manager {
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
