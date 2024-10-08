{ config, lib, pkgs, ... }:
{
  services.vdirsyncer = {
    enable = !config.services.unison.enable;
    package = pkgs.vdirsyncer;
    configFile = "${config.xdg.configHome}/virdirsyncer/config";
    frequency = "*:0/5";
    verbosity = null;
  };

  # TODO: Move to ./unison.nix
  services.unison = {
    enable = true;
    pairs = {
      "documents" = {
        roots = [
          # Pair of roots to synchronize
          "${config.xdg.userDirs.XDG_DOCUMENTS_DIR}"
          "ssh:/<remote>/Documents"
        ];
        commandOptions = {
          # Extra CLI options (as dict) to pass to `unison` program. See: unison(1)
          auto = "true";
          batch = "true";
          log = "false";
          repeat = "watch";
          sshcmd = "\${pkgs.openssh}/bin/ssh";
          ui = "text";
        };
      };
    };
  };

}
