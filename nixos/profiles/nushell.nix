{ inputs, config, lib, pkgs, ... }: {
  imports = [
    (inputs.self + /nixos/profiles/shell.nix)
  ];

  # TODO: Remove bash, nushell config
  environment = {
    # Link bash completions. Used by bash & ZSH compat.
    pathsToLink = ["/share/bash-completion"]
     ++ lib.optional config.programs.zsh.enable "/share/zsh"
    ;
    systemPackages = [pkgs.nushell];
    shells = [pkgs.nushell];
  };
}
