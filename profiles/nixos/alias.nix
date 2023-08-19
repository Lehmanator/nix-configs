{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  environment.shellAliases = let
    flakeDir    = "~/.config/nixos";
    sudoProgram = with config.security;
           if   doas.enable then "doas"
      else if please.enable then "please"
      else                       "sudo";
  in rec {
    # --- systemd ----------------
    ctl = "systemctl";
    sctl = "${sudoProgram} ${ctl}";

    # --- Privileged Execution ---
    s = sudoProgram;
    pk = lib.mkIf config.security.polkit.enable "pkexec";

    # --- NixOS ------------------
    # TODO: Generate `nixos-rebuild` subcommands automatically
    nrb = "${sudoProgram} nixos-rebuild";
    nboot = "${nrb} boot";
    nbuild = "${nrb} build";                        nos-build     = nbuild;
    nbuilddry = "${nrb} dry-build";                 dry-build     = nbuilddry;
    nbuildvm = "${nrb} build-vm";                   build-vm      = nbuildvm;
    nbuildvmb = "${nrb} build-vm-with-bootloader";  build-vm-boot = nbuildvmb;
    ndry = "${nrb} dry-activate";                   dry-activate  = ndry;
    nswitch = "${nrb} switch";                          switch    = nswitch;
    nswitchdry = "${nrb} switch";                   dry-switch    = nswitchdry;
    ntest = "${nrb} test";
    nupdate = "${nrb} switch --upgrade";                     nup  = nupdate;      upd   = nupdate;
    nupdateall = "${nrb} switch --upgrade-all";              nupa = nupdateall;   upda  = nupdateall;
    update = "${cfgd} && l && git status && ${flake-update-cwd} && ${nrb} switch --upgrade-all";
    flake-update-cwd = "nix flake update --commit-lock-file";                     flupc = flake-update-cwd;
    flake-update = "${cfgd} && ${flake-update-cwd}"; update-flake = flake-update; flup  = flake-update;
    flake-dir    = "cd ${flakeDir}";                    dir-flake = flake-dir;    flcd  = flake-dir; cfgd = flake-dir;
    flake-show   = "nix flake show";                   show-flake = flake-show;   flls  = flake-show;
  };

}
