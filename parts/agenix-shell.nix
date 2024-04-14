{inputs, ...}: {
  imports = [inputs.agenix-shell.flakeModules.default];
  agenix-shell = {
    identityPaths = ["$HOME/.ssh/id_rsa" "$HOME/.ssh/id_ed25519"];
    #secretsPath = "/run/user/$(id -u)/agenix-shell/$(git rev-parse --show-toplevel | xargs basename)";
    #secrets = {
    #  <name> = {
    #    file = "secrets/<name>.age";
    #    path = "${config.agenix-shell.secretsPath}/<name>";
    #    mode = "0400";
    #  };
    #};
  };
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    agenix-shell = {
      #package = pkgs.rage;
      #installationScript = null;
    };
  };
}
