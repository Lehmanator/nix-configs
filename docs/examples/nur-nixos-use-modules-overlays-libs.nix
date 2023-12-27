## Example: Using modules, overlays, library functions in NixOS configuration.nix
##
## Import structure prevents introducing infinite recursion
##
## See Also: `./nur-homemanager-use-modules.nix
##

{
  config, lib, pkgs,
  ...
}:
let

  # Alternate NUR module that doesn't import packages.
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};

in {

  # Import a NixOS module
  imports = [
    nur-no-pkgs.repos.paul.modules.foo
  ];

  # Import a nixpkg overlay
  nixpkgs.overlays = [
    nur-no-pkgs.repos.ben.overlays.bar
  ];

}
