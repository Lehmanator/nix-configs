{ config, lib, pkgs, ... }:
{
  home = {
    # https://github.com/oniony/TMSU
    # https://github.com/oniony/TMSU/wiki
    # https://github.com/talklittle/tmsu-nautilus-rs
    # https://github.com/talklittle/nautilus-extension-rs
    packages = [ pkgs.tmsu ];
    # TODO: Condition on GNOME / Nautilus enabled
    #   ++ cell.packages.tmsu-nautilus-extension
    shellAliases = {
      tag = "tmsu tag";
      tagged = "tmsu files";
    };
  };
}
