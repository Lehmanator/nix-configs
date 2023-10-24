{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  #
  # TODO: Better code organization for devices. Potential boundaries for code-splitting:
  #   Starting OSes: Android, Android TV, Fuschia, WearOS, Windows, other proprietary OSes
  #   Target OSes
  #     - Android ROMs: AOSP, CalyxOS, DivestOS, GrapheneOS, LineageOS
  #     - Watch OSes: AsteroidOS, InfiniTime
  #     - Linux Distros: Debian, NixOS, PostmarketOS
  #     - Purpose-OSes: OpenWRT
  #   CPU Architectures: x86_64, aarch32, aarch64, riscv
  #   Hardware OEMs: Asus, Google, Fairphone, Huawei, Lenovo, Librem, OnePlus, Oppo, Pine64, Raspberry Pi, Xiaomi
  #   SOC OEMs: Google Tensor, Qualcomm Snapdragon, Rockchip, ESP32
  #   Hardware models: cheetah, enchilada, fajita, flame, pinetime, sawfish, raspi5, raspi4, raspi3, raspi0-w, raspi400
  #
  # TODO: What tools do we want to install to NixOS machines?
  # - Flashable images for target OSes
  # - Flashing utils for starting OSes or device hardware
  # - Interaction/management utils for target OSes
  # - Recovery utils for device hardware
  # - SSH hosts for target OSes
  # - Sync utils for target OSes
  #
  # TODO: Find some way of distinguishing between starting OS and used OS.
  #   i.e. Android phones remaining on Android-based OS, should install tools to interact with Android & apps installed on Android devices (KDE Connect, android-tools, etc.)
  #   i.e. Android phones moving to Linux-based OS, should install tools for flashing new OS to hardware. (android-tools, pmbootstrap, etc.)
  #

  imports = [
    ./oem/samsung.nix
    #./oem/pine64.nix
    ./os/android
    ./os/asteriodos.nix
    ./os/postmarketos.nix
  ];

}
