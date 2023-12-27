{ inputs, config, lib, pkgs, user, ... }:
{
  # https://github.com/polygon/scalpel
  imports = [ inputs.scalpel.nixosModules.scalpel ];
  #home-manager.sharedModules = [ inputs.scalpel.homemManagerModules.scalpel ]; # No hmModule yet

  # TODO: Learn about `lib.extendModules`
}
