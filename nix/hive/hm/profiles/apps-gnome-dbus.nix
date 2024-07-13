{  pkgs , ... }: {
  home.packages = [
    pkgs.bustle #    #
    pkgs.d-spy #     # Inspect D-Bus, replaces D-Feet
    pkgs.dbus-map #  # TODO: Move to CLI utils
    pkgs.sysprof #   # GNOME system profiler
  ];
}
