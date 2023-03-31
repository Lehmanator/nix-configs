## Example: Importing modules from NUR in Home-Manager
##
## Import home-manager modules from NUR repos without introducing infinite recursion.
## 
## See Also: 
## - `./nur-nixos-use-modules-overlays-libs.nix`
## - [nix-community/NUR](https://github.com/nix-community/NUR)
##
{ config, lib, pkgs, ... }: let

  # Import NUR module without packages
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};

in {

  # Imports all home-manager modules from a user's repo.
  imports = lib.attrValues nur-no-pkgs.repos.moredhel.hmModules.rawModules;

  # Options from imported repo's modules can now be used.
  services.unison = {
    enable = true;
    profiles = {
      org = {
        src = "/home/moredhel/org";
        dest = "/home/moredhel/org.backup";
        extraArgs = "-batch -watch -ui text -repeat 60 -fat";
      };
    };
  };
}
