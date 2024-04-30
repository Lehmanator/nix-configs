{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Better NixOS option to load these modules?
  # TODO: Load in initrd for disk unlock?
  boot.kernelModules = ["hid_apple" "hid_magicmouse" "mac_hid"];

  # TODO: Configure modules to fix keyboard & mouse gestures?
  boot.kernelParams = [
    # https://help.ubuntu.com/community/AppleKeyboard
    # https://wiki.archlinux.org/index.php/Apple_Keyboard
    #"hid_apple.iso_layout=0" #     # 0=not-ISO,    1=ISO,                  -1=auto
    "hid_apple.fnmode=1" # # 0=disabled,   1=media-keys+fn->F-keys, 2=F-keys+fn->media-keys, 3=auto
    "hid_apple.swap_opt_cmd=1" # # 0=Mac-layout, 1=PC-layout
    "hid_apple.swap_fn_leftctrl=1" # 0=Mac-layout, 1=PC-layout
  ];

  #boot.extraModprobeConfig = ''
  #  options hid_apple fnmode=1
  #  options hid_apple iso_layout=0
  #'';
}
