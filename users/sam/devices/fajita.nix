{ inputs
, config
, lib
, pkgs
, ...
}:
{
  # TODO: Reorganize this file
  # - OnePlus 6T (fajita)
  # - OnePlus 6  (enchilada)
  # - OnePlus (all)
  # - Android (all)
  imports = [
    ./oem/oneplus.nix
    ./os/android
  ];

  # --- Downloads ------------------------------------------
  # TODO: Download Windows binaries & create fetchers
  # - OnePlus MSM flasher tool
  # - OnePlus ADB/Fastboot drivers
  # - Qualcomm EDL drivers
  # - Android platform-tools (ADB/fastboot)

  # TODO: Download stock OxygenOS firmware images & OTA images
  # - Convert T-Mobile variant OxygenOS 9.x.y to International Unlocked variant 9.x.y (9.0.11)
  # - Update International Unlocked 9.x.y to Android 10
  # - Update International Unlocked Android 10 to Android 11
  # - Update International Unlocked Android 11 to Android 11 latest

  # TODO: Download custom Android images
  # - LineageOS latest
  # - TWRP recovery latest
  # - Magisk latest

  # --- Packaging ------------------------------------------
  # TODO: Create Bottle for Windows flashing utilities & drivers
  # - Qualcomm EDL drivers
  # - Google generic ADB/Fastboot drivers
  # - OnePlus ADB/Fastboot drivers
  # - OnePlus MSM flasher (for EDL mode)
  # - Android platform-tools (ADB & fastboot)

  # --- Building Images ------------------------------------
  # TODO: Build new dual-boot images combining Android & Linux
  # - PostmarketOS &  OxygenOS 11.1.2.2
  # -        NixOS &  OxygenOS 11.1.2.2
  # - PostmarketOS & LineageOS
  # -        NixOS & LineageOS

  # --- Scripts: User Instruction --------------------------
  # TODO: Instruct user how to enter EDL mode
  # TODO: Instruct user how to enable ADB debugging
  # TODO: Instruct user what to do on their device

  # --- Scripts: Setup -------------------------------------
  # TODO: Reboot into recovery mode
  # TODO: Reboot into fastboot mode
  # TODO: Reboot into EDL mode
  # TODO: Reboot into system

  # TODO: Unlock bootloader
  # TODO: Unlock locked partitions

  # TODO: Detect T-Mobile or International Unlocked variant
  # TODO: Detect OxygenOS version & select upgrade path

  # --- Scripts: Flashing Android --------------------------
  # TODO: Convert T-Mobile version to international unlocked version
  # TODO: Update international unlocked OxygenOS  9.x.y to Android 10
  # TODO: Update international unlocked OxygenOS 10.x.y to Android 11
  # TODO: Update international unlocked OxygenOS 11.x.y to Android 11 latest (11.1.2.2)
  # TODO: Update international unlocked OxygenOS (any) to 11.1.2.2
  # TODO: Update T-Mobile variant OxygenOS (any) to 11.1.2.2

  # TODO: Flash LineageOS over OxygenOS 11.1.2.2
  # TODO: Flash TWRP recovery
  # TODO: Flash Magisk on Android partition

  # --- Scripts: Flashing Linux ----------------------------
  # TODO: Configure pmbootstrap w/ `pmbootstrap init`
  # TODO: Flash pmbootstrap image with full disk encryption (regular partitioning)
  # TODO: Flash pmbootstrap image with full disk encryption (dual-boot partitioning)
  # TODO: Flash pmbootstrap image with full disk encryption (userdata partitioning)
  # - Regular partitioning
  # - Dual-boot partitioning
  # - Userdata partitioning (possible to combine with dual-boot?)

  # --- Miscellaneous --------------------------------------
  # TODO: Integrate with Robotnix (https://github.com/nix-community/robotnix)
  # TODO: Build custom `LOGO.img` from user-supplied image file?
  # TODO: Make flashing scripts able to handle passing slot number via arguments & multi-slot
  # TODO: Patch Android system images? (e.g. install Magisk, install system apps, etc.)
  # - Install Magisk + MagiskHide
  # - Install GApps or MicroG
  # - Install additional system apps
  #   - Camera: Pixel Camera
  #   - Launcher: Lawnchair | NeoLauncher | Kaevsito  | Simple Mobile Launcher | Pixel Launcher
  #   - Store:      F-Droid | NeoStore    | Droid-ify | Aurora Store (with privileged extension)
  #   - Store privileged extension
  # TODO: Script to configure settings according to preferences after ADB debugging is enabled
  # - Android (generic)
  # - LineageOS specific
  # - OxygenOS specific
  # TODO: Script to install userspace applications
  # - NixOnDroid
  # - Termux & Termux plugins

  home.packages = [
    pkgs.payload-flasher-go

    # TODO: Create package for version `34.x.y`
    pkgs.android-tools

    # TODO: Create package for version `2.0.0` instead of `1.53.0` or `1.51.0`
    pkgs.pmbootstrap
  ];

}
