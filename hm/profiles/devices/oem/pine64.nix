{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.rkdeveloptool-pine64  # Rockchip tool to communicate with Rockusb devices (pine64 fork)
  ];

}
