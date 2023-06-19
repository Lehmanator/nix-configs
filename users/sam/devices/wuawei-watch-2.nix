{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.android-tools  # Android SDK platform tools (ADB / fastboot)
  ];

}
