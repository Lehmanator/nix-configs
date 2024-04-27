{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  # --- Huawei Watch 2 (sawfish) ---
  # https://asteroidos.org/watches/sawfish
  #
  # echo "1. Navigate to: Settings -> System -> About -> Build number"
  # echo "2. Tap 'Build number' 7 times"
  # echo "3. Navigate to: Settings -> Developer options -> ADB debugging"
  # echo "4. Enable ADB debugging"
  #
  # read -p "Press any [ENTER] to continue" varname
  #
  # adb reboot bootloader
  # fastboot oem unlock
  #
  # echo "5. Hold button to select 'yes'"
  #
  # read -p "Press any [ENTER] to continue" varname
  #
  # fastboot flash userdata ~/Downloads/asteroid-image-sawfish.ext4
  # fastboot flash boot ~/Downloads/zImage-dtb-sawfish.fastboot
  # fastboot continue
  #

  imports = [
    #./os/android-wear.nix
    #./os/asteriodos.nix
  ];

  home.packages = [
    pkgs.android-tools # Android SDK platform tools (ADB / fastboot)
    #pkgs.python311Packages.mpd2 # Python MPD lib
    #pkgs.python311Packages.pydbus  # Python D-Bus lib | dbus-python dbus-fast
    #pkgs.python311Packages.pyowm # Python wrapper around OpenWeatherMap web API
    #pkgs.python310Packages.mpd2    # Python MPD lib
    #pkgs.python310Packages.pydbus  # Python D-Bus lib | dbus-python dbus-fast
    #pkgs.python310Packages.pyowm   # Python wrapper around OpenWeatherMap web API
    pkgs.yarn
    #pkgs.dhcp  # Provides dhclient?  # Removed: end-of-life (2023-08-08)
    pkgs.dialog
    pkgs.connmanFull
    pkgs.connman-gtk
  ];

  # TODO: Build fastboot image: [asteriod-image-sawfish.ext4](https://release.asteroidos.org/nightlies/sawfish/asteroid-image-sawfish.ext4)
  # TODO: Build fastboot image: [zImage-dtb-sawfish.fastboot](https://release.asteroidos.org/nightlies/sawfish/zImage-dtb-sawfish.fastboot)
  # TODO: Create package/app:   [AsteriodOS WebInstaller](https://github.com/AsteroidOS/asteroid-webinstall)
  # - Deps: yarn,
  # TODO: Create package/app:   [atx/AsteroidOSLinux](https://github.com/atx/AsteroidOSLinux)
  #  - Deps: pydbus, python-mpd2, pyown
  # TODO: Create package: [AsteriodOS/asteroid-ctrl](https://github.com/AsteroidOS/asteroid-ctrl)
  # TODO: Install unofficial-watchfaces
  # - Deps: dialog or whiptail
}
