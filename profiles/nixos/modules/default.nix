{ inputs
, pkgs
, system ? "x86_64-linux"
, user ? "sam"
, ...
}: with inputs;
[
  agenix.nixosModules.default
  nix-index.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
  nur.nixosModules.nur
  sops-nix.nixosModules.sops
  # https://github.com/TLATER/dotfiles
  home.nixosModules.home-manager { home-manager = {
    backupFileExtension = "backup";
    verbose = true; # default=false

    # Whether to enable using the system configuration’s `pkgs` argument in Home Manager. This disables the Home Manager options `nixpkgs.*`.
    # - Saves an extra nixpkgs evaluation
    # - Adds consistency b/w NixOS & home-manager
    # - Removes dependency on `$NIX_PATH`
    #    true => pkgs = nixos-nixpkgs
    #   false => pkgs = hm-nixpkgs
    # default = false;
    useGlobalPkgs = true;

    # Whether to install user packages to the system per-user profiles. When enabled
    # - Enables using `nixos-rebuild build-vm`
    # Package install dir: (default = false)
    #     true = /etc/profiles
    #    false = $HOME/.nix-profile
    useUserPackages = true;

    # Extra special attrs to pass to home-manager modules.
    #  Normally, option values can depend on other option values bc laziness, but not with `imports`, which must be computed statically before anything else.
    #  For this reason, callers of the module system can provide `specialArgs` which are available during import resolution.
    # See:
    # - https://nix-community.github.io/home-manager/options.html#opt-_module.args
    # Defaults:
    # - lib = nixpkgs library
    # - config = results of all options after merging the values from all modules together
    # - options = the options declared in all modules
    # - specialArgs = the specialArgs attr passed to lib.nixosSystem
    # - All attributes of `specialArgs`
    # NixOS-only:
    # - modulesPath = allows importing extra modules from the nixpkgs package tree without having to make the module aware of the location of the nixpkgs or NixOS directories
    extraSpecialArgs = {
      # For nixos, defaults to: `pkgs` according to the `nixpkgs.pkgs` option.
      inherit pkgs;
    };

    # Extra modules added to all users
    sharedModules = [
      arkenfox.hmModules.default
      nix-index.hmModules.nix-index {programs.nix-index-database.comma.enable=true;}
      sops-nix.homeManagerModules.sops
    ];

    users = {
      sam = import ./users/sam;
    };

  };
}
]
