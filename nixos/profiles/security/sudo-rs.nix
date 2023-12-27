{ config, lib, pkgs, user, ... }:
let
  mkAliasWord = lst: lib.genAttrs lst (name: "nix " + name);
  mkAliasPrefix = pre: lst: lib.genAttrs lst (name: pre + name);
  mkAliasAbbr = lst: lib.genAttrs lst (name: "n" + name);
  sudoConfig = lib.filterAttrs (a: v: config.security.sudo-rs ? a) config.security.sudo;
in
{
  environment.shellAliases.s = "sudo";

  # Inherit sudo config, if any.
  # TODO: Filter out attr: `keepTerminfo`, `defaultOptions`
  #security.sudo-rs = lib.recursiveUpdate sudoConfig {
  security.sudo-rs = {
    enable = lib.mkDefault true;
    execWheelOnly = true; #  # Only allow users in group `wheel` to access sudo.
  };
  #extraRules =
  #  #let
  #  #  exemptIfEnabled = lib.filter (prog: config.programs.${prog}.enable);
  #  #  #lsCmds = exemptIfEnabled [
  #  #  #  #"lsd"
  #  #  #  "eza"
  #  #  #  "pls"
  #  #  #  "fd"
  #  #  #] ++ [ "ls" "l" "ll" "lt" "la" ];
  #  #  cacheCmds = exemptIfEnabled [ "ccache" ];
  #  #  systemdCmds = [ "systemctl" "sctl" "stl" "ctl" "nixos-rebuild build" "nixos-rebuild dry-activate" ];
  #  #  userCmds = [ ];
  #  #  viewerCmds = [ "cat" "bat" "b" ];
  #  #in
  #  [
  #    {
  #      # Run commands without password if user is in `wheel` group.
  #      groups = [ "wheel" ];
  #      #options = [ "SETENV" "NOPASSWD" ];
  #      commands = [
  #        # systemd control
  #        { command = "systemctl"; options = [ "SETENV" "NOPASSWD" ]; }
  #        { command = "sctl"; options = [ "SETENV" "NOPASSWD" ]; }
  #        { command = "stl"; options = [ "SETENV" "NOPASSWD" ]; }
  #        ## Directory Viewers
  #        #"l"
  #        #"lt"
  #        #"ls"
  #        #"lsd"
  #        #"eza"
  #        #"pls"
  #        #"cat"
  #        # caches
  #        { command = "ccache"; options = [ "SETENV" "NOPASSWD" ]; }
  #      ]
  #        #++ cacheCmds
  #        #++ lsCmds
  #        #++ systemdCmds ++ userCmds ++ viewerCmds
  #      ;
  #    }
  #    # Allow rebuilding NixOS when user in group `wheel`, but only when using NixOS.
  #    #] ++ lib.optionals pkgs.stdenv.isLinux [
  #    #  {
  #    #    groups = [ "wheel" ];
  #    #    #options = [ "SETENV" "NOPASSWD" ];
  #    #    commands = [
  #    #      { command = "nixos-rebuild"; options = [ "SETENV" "NOPASSWD" ]; }
  #    #      { command = "nup"; options = [ "SETENV" "NOPASSWD" ]; }
  #    #      { command = "switch"; options = [ "SETENV" "NOPASSWD" ]; }
  #    #      { command = "nswitch"; options = [ "SETENV" "NOPASSWD" ]; }
  #    #    ];
  #    #  }
  #];
}
