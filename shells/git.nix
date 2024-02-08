{
  inputs,
  self,
  ...
}: {
  #imports = [inputs.devshells.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    devshells.git = {
      commands = [];
      devshell = {
        motd = ''
          ${lib.getExe pkgs.onefetch}
        '';
      };
      env = [];
      packages = [pkgs.gitFull pkgs.onefetch];
    };
  };
}
