{ inputs
, config
, lib
, pkgs
, osConfig
, ...
}:
{
  imports = [
  ];

  #xdg.desktopEntries.secureboot-test = {
  #  name = "Secure Boot Test";
  #  type = "Application";
  #};

  systemd.user.services.notify-secureboot-uki = {
    Unit = {
      Description = "Notify user if Secure Boot is enabled with Unified Kernel Image (UKI) support.";
    };
    Service = {
      ConditionSecurity = "measured-uki";
      ExecStart = "${pkgs.notify-desktop}/bin/notify-desktop --app-name=\"Secure Boot\" \"Enabled (UKI)\"";
      # --expire-time=3000
      # --urgency=low
      # --icon=\"\"
      # --replaces-id=\"\"
      # --category=\"\"
    };
  };
}
