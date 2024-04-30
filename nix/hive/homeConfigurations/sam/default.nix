{ inputs, cell, }@commonArgs:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  user = builtins.baseNameOf (builtins.toString ./.);
in
homeManagerConfiguration {
  #pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  pkgs = inputs.nixpkgs;
  modules = [
    inputs.cells.hive.homeSuites.developer-default
    #(inputs.self + /users/${user} { inherit inputs cell user; })
    cell.userProfiles.${user}
    #(inputs.self + /users/${user})
  ];
  extraSpecialArgs = {
    inherit inputs cell user;
    #inherit (inputs.nixpkgs) lib;
  };
}
