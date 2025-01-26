{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.shellAliases = rec {
    # Privilege Escalation
    # TODO: Create lib to use sudo, doas, or please
    # TODO: run0
    s =
      if config.security.doas.enable
      then "doas"
      else if config.security.please.enable
      then "please"
      else "sudo";
    se = lib.mkIf config.security.sudo.enable "sudoedit";

    # systemd
    ctl = "systemctl";
    stl = "${s} ${ctl}";
    utl = "${ctl} --user";
  };
}
