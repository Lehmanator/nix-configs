{ inputs, self
, config, lib, pkgs
, ...
}:
{
  networking.rxe = {
    enable = true;
    interfaces = [ "eth0" ];
  };

}
