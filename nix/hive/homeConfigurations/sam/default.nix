{ inputs, cell, }@commonArgs:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  user = builtins.toString ./.;
in
homeManagerConfiguration {
  pkgs = inputs.nixpkgs;
  modules = [
    inputs.cells.hive.homeSuites.developer-default
    (inputs.self + /users/${user})
  ];
  extraSpecialArgs = { inherit inputs cell user; };
}
