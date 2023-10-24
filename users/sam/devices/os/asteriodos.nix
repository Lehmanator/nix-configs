{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  # https://asteroidos.org
  # https://wiki.asteroidos.org
  imports = [
  ];

  home.packages = [
    pkgs.android-tools # Android SDK platform tools (ADB / fastboot)
    pkgs.python311Packages.mpd2 # Python MPD lib
    #pkgs.python311Packages.pydbus  # Python D-Bus lib | dbus-python dbus-fast
    pkgs.python311Packages.pyowm # Python wrapper around OpenWeatherMap web API
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
