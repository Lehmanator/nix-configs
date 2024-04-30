# {
#  inputs,
#  cell,
#}:
{ config, lib, pkgs, ... }:
let
  cfg = cfg.git;
  cmds = {
    #${inputs.nixpkgs.lib.getExe inputs.nixpkgs.pkgs.onefetch} \
    onefetch = ''
      ${lib.getExe pkgs.onefetch} \
        --no-color-palette \
        --email \
        --include-hidden \
        --number-of-file-churns 8 \
        --number-separator comma \
        --type programming markup prose data
    '';
  };
in
{
  config = {
    startup.onefetch = { text = cmds.onefetch; };
    commands = [{
      category = "info";
      name = "onefetch";
      help = "display repository info";
      command = cmds.onefetch;
    }];
    packages = [ pkgs.gitFull ];
  };
}
