{ pkgs, ... }:

{
  systemd.packages = [
    (pkgs.writeTextFile {
      name = "flatpak-dbus-overrides";
      destination = "/etc/systemd/user/dbus-.service.d/flatpak.conf";
      text = ''
        [Service]
        ExecSearchPath=${cfg.package}/bin
      '';  # Package: dbus-broker
    })
  ];
}
