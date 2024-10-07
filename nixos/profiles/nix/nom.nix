{ config, lib, pkgs
, user
, ...
}:
# nix-output-montor - Build Nix outputs & display a pretty output tree.
# nix-fast-build    - Combine nix-output-monitor & nix-eval-jobs for faster eval & builds
#
# This config wraps `nixos-rebuild` with `nix-output-montor` for prettier system rebuilds.
#
# ShellAliases default `nixos-rebuild` args:
#
# --flake /home/sam/.config/nixos#<HOST>
# --fast  (to not rebuild pkgs.nixVersions.latest during every build)
#
# TODO: Symlink /etc/nixos/flake.nix to contents of flake.
let
  system-config = "${config.users.users.${user}.home}/.config/nixos";
  flake-arg = "--flake ${system-config}#${config.networking.hostName}";
  rebuild   = lib.getExe pkgs.nixos-rebuild;
  nom       = lib.getExe pkgs.nix-output-monitor;
  nfb       = lib.getExe pkgs.nix-fast-build;
  unbuffer  = "${pkgs.expect}/bin/unbuffer";
in {
  environment = {
    systemPackages = with pkgs; [expect nix-output-monitor nix-fast-build];
    shellAliases = rec {
      # Minimal wrapper
      nos-rebuild = "${unbuffer} ${rebuild} $@ |& ${nom}";

      # Wrapper using my default flake location & --fast
      nos = "${unbuffer} ${rebuild} ${flake-arg} --fast $@ |& ${nom}";

      # Wrapper to switch without --fast
      nos-update = "${unbuffer} ${rebuild} switch ${flake-arg} $@ |& ${nom}";

      # Aliases to other main rebuild commands using --fast
      nos-build = "${nos} build";
      nos-build-dry = "${nos} dry-build";
      nos-build-vm = "${nos} build-vm";
      nos-build-vm-bootloader = "${nos} build-vm-with-bootloader";
      nos-switch = "${nos} switch";
      nos-test = "${nos} test";
      nos-activate = "${nos} switch";
      nos-activate-dry = "${nos} dry-activate";
    };
  };
}
