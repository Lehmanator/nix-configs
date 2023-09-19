{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    lib.lists.optional config.gtk.enable ../../desktop/gnome/apps/phone.nix
  ];

  home.packages = [
    pkgs.nur.repos.aleksana.payload-dumper-go   # Android OTA payload dumper
    pkgs.nur.repos.wolfangaukang.device-flasher # Flash CalyxOS to Android device
  ];

}
