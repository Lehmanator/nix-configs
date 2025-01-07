{ inputs, config, lib, pkgs, ... }:
{
  #security = lib.mkIf (pkgs.system == "x86_64-linux") {
  #  protectKernelImage = true;
  #};

  # TODO: Equivalents: sudo-rs, doas, please
  environment.shellAliases = {
    s = lib.mkDefault "sudo";
    se = lib.mkIf config.security.sudo.enable "sudoedit"; 
  };
}
