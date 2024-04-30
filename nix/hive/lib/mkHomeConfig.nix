{ inputs, cell, }:
let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs;
in
host: user: {
  imports = l.flatten cell.pops.exports.${host}.homeSuites;
  bee =
    if nixpkgs.stdenv.isDarwin then
      cell.darwinConfigurations.${host}.bee
    else
      cell.nixosConfigurations.${host}.bee;
  home = rec {
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
    username = user;
  };
}
