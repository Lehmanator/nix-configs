{ inputs, config, lib, pkgs, ... }@moduleArgs: 
let
  inherit (lib) getExe;

  nix    = getExe config.nix.package;
  rg     = getExe pkgs.ripgrep;
  awk    = getExe pkgs.gawk;
  sed    = getExe pkgs.gnused;
  nvd    = getExe pkgs.nvd;
  choose = getExe pkgs.choose;

  # TODO: Wrap all diff commands in pretty tables with `column` command.
  # TODO: Enforce all columns same width.
  
  # Wrap commands in pretty box using unicode box chars.
  mkWrapper = import "${inputs.self}/lib/shell/wrap-command-box.nix" moduleArgs;
in {
  system.activationScripts = {
    diff-closures = {
      supportsDryActivation = true;
      text = mkWrapper "nix store diff-closures" ''
        ${nix} store diff-closures /run/current-system "$systemConfig" | \
        ${rg} --color=always -w "→" | \
        ${rg} --color=always -w "KiB" | \
        column --table --separator " ,:" | \
        ${choose} 0:1 -4:-1 | \
        ${awk} '{s=$0; gsub(/\0 33\[[ -?]*[@-~]/,"",s); print s "\t" $0}' | \
        sort -k5,5gr | \
        ${choose} 6:-1 | \
        column --table | \
        ${sed} 's/^/│ /'
      '';
    };

    # https://github.com/nix-community/srvos/blob/main/nixos/common/upgrade-diff.nix
    diff-versions = {
      supportsDryActivation = true;
      text = mkWrapper "nvd diff" ''
        ${nvd} --color always --nix-bin-dir ${config.nix.package}/bin diff /run/current-system "$systemConfig" | \
        ${sed} 's/^/│ /'
      '';
    };

    #diff-derivations = {
    #  supportsDryActivation = true;
    #  text = mkWrapper "nix-diff" ''
    #    ${lib.getExe pkgs.nix-diff} /run/current-system "$systemConfig" --skip-already-compared --word-oriented --squash-text-diff --color always
    #  '';
    #};
  };

  # TODO: Split activationScripts b/w system & user?
  # TODO: Diff system environment & home-manager environment separately?
  #system.userActivationScripts.nix-diff = {};

  # TODO: Save state of flake config dir from last build/activation, then diff the file tree.
  # TODO: pkgs.writeShellApplication ?
  #nix.settings = {
  #  run-diff-hook = true;
  #  diff-hook = diffHook;
  #  # mkWrapper "nix-diff"
  #  #''
  #  #  ${lib.getExe pkgs.nix-diff} --color always --skip-already-compared --word-oriented --environment --squash-text-diff
  #  #'';
  #};

  #environment.systemPackages = [
  # --- Diff Hook --------------------------------
  # Runs on every activation/build?
  # TODO: Fix build failure to encode character \9472
  #(pkgs.writeShellApplication {
  #  name = "pretty-nix-diff-hook";
  #  runtimeInputs = [];
  #  text = mkWrapper "nix-diff" "${
  #    lib.getExe pkgs.nix-diff
  #  } --color always --skip-already-compared --word-oriented --environment --squash-text-diff";
  #})
  #];
}
