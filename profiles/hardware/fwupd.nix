{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

}

