{
  self, inputs,
  system,
  host, userPrimary,
  config, lib, pkgs,
}:
{
  imports = [
  ];

  environment.shellAliases = {
    # Clear terminal output
    cl = "clear";

    # TODO: Create lib to use sudo, doas, or please
    s = lib.mkIf config.security.sudo.enable "sudo";

    # Reload the shell
    she = "$SHELL";
  };
}
