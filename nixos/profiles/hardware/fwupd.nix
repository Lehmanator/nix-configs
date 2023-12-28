{ inputs
, config
, lib
, pkgs
, ...
}:
{
  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };
}
