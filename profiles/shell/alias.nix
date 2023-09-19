{ inputs, self
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
  ];

  environment.shellAliases = {
    # Clear terminal output
    cl = "clear";

    # TODO: Create lib to use sudo, doas, or please
    s = if config.security.doas.enable then "doas" else if config.security.please.enable then "please" else "sudo";

    # Reload the shell
    #she = "$SHELL";
  };
}
