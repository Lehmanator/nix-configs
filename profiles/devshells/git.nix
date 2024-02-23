{...}: {
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    devshells.git = {
      devshell = {
        motd = ''
          {200} Hello! {reset}
        '';
        startup = {
          aaa-begin = {
            deps = [];
            text = "echo 'Welcome!'";
          };
          onefetch = {
            deps = ["aaa-begin"];
            # --no-merges --no-bots
            text = ''
              ${lib.getExe pkgs.onefetch} \
                --no-color-palette \
                --email \
                --include-hidden \
                --number-of-file-churns 8 \
                --number-separator comma \
                --type programming markup prose data
            '';
          };
        };
      };
      commands = [
        {
          category = "info";
          name = "onefetch";
          help = "display repository info";
          command = ''
            ${lib.getExe pkgs.onefetch} \
                --no-color-palette \
                --email \
                --include-hidden \
                --number-of-file-churns 8 \
                --number-separator comma \
                --type programming markup prose data
          '';
        }
      ];
      env = [];
      packages = [
        pkgs.gitFull
        #pkgs.onefetch
      ];
    };
  };
}
