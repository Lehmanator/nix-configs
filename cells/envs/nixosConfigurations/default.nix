{
  fw = {
    imports = [
      inputs.hive.bootstrap.profiles.bootstrap
    ];
    bee = {
      system = "x86_64-linux";
      pkgs = import inputs.nixos-unstable {
        inherit (inputs.nixpkgs) system;
        config.allowUnfree = true;
        overlays = [];
      };
    };
    nix.registry.hive.flake = {inherit (inputs.self) outPath;};
  };
}
