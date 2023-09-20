{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  networking.rxe = {
    enable = true;
    interfaces = [
      "wlp166s0"
      #"eth0"
    ];
  };

}
