{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.mic92.yubikey-touch-detector   # Detect when YubiKey is waiting for a touch
  ];

}
