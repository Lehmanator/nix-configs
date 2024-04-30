{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [
    #../../../common/profiles/shell/alias.nix
    #../../../common/profiles/_platform/linux/shell/alias.nix
  ];

  environment.shellAliases = {
    # Privilege Escalation
    # TODO: Create lib to use sudo, doas, or please
    #s = if config.security.doas.enable then "doas" else if config.security.please.enable then "please" else "sudo";
    se = lib.mkIf config.security.sudo.enable "sudoedit";

    # systemd
    ctl = lib.mkIf pkgs.stdenv.isLinux "systemctl";
    stl = lib.mkIf pkgs.stdenv.isLinux "${config.environment.shellAliases.s} ${config.environment.shellAliases.ctl}";
    utl = lib.mkIf pkgs.stdenv.isLinux "${config.environment.shellAliases.ctl} --user";

  };
}
