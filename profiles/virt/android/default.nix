{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    # TODO: Move to ./android/default.nix
    # TODO: Create  ./android/anbox.nix
    # TODO: Create  ./android/waydroid.nix
    #./anbox.nix
    #./waydroid.nix
  ];

  environment.systemPackages = [
    pkgs.genymotion       # Fast and easy Android emulation
  ];

}
