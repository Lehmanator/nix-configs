{ inputs, config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.bustle #    #
    pkgs.d-spy #     #
    pkgs.dbus-map #  # TODO: Move to CLI utils
    pkgs.sysprof #   #
  ];
}
