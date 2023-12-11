{ inputs
, config
, lib
, pkgs
, ...
}:
let
  #mkAliasPrefix = pre: builtins.map (name: pre + name);
  #mkAliasPrefixNix = mkAliasPrefix "nix ";
  #mkAliasPrefixN   = mkAliasPrefix "n-";
  #mkAliasesPrefix = pre: lst: genAttrs lst (name: pre + name);
  #mkAliasesWord = mkAliasesPrefix "nix ";
  #filterRisky = lvl: mkAliasesWord (lib.lists.subtractLists subcmds.${lvl} subcmds.all);
  #mkAliasAbbrs = lst: genAttrs lst (name: "n" + name);
  #mkAliasAbbr = lst: genAttrs lst (name: builtins.substring 0 1 name);
  #mkAbbrs1 = builtins.map (cmd: builtins.substring 1 cmd);
  #mkAbbrs2 = builtins.map (cmd: builtins.substring 2 cmd);
  #mkAbbrs3 = builtins.map (cmd: builtins.substring 3 cmd);
  commands = {
    # More programs:
    # - nix-: ccache, channel, collect-garbage, copy-closure, daemon, doc, du, env, fast-build, generate-from-cpan, hash, info, init, instantiate, locate, prefetch-url, query-tree-viewer, shell, shell-info, software-center, store, tree, update, ...
    # - nixos-: build-vms, conf-editor, container, enter, generate-config, install, option, version, ...
    # - nixpkgs-: firefox-addons, ...
    # - other: lorri, manix, std, paisano, ...
    nix = {
      prefix = "n-";
      commands = [
        "build"
        "develop"
        "flake"
        "profile"
        "repl"
        "run"
        "search"
        "shell"
        "bundle"
        "copy"
        "edit"
        "eval"
        "fmt"
        "log"
        "path-info"
        "registry"
        "why-depends"
        "daemon"
        "derivation"
        "hash"
        "nar"
        "print-dev-env"
        "realisation"
        "show-config"
        "store"
        "doctor"
        "upgrade-nix"
      ];
      flags = {
        all = [ ];
        default = [ ];
      };
    };
    nixos-rebuild = {
      prefix = "nos-";
      commands = [
        "switch"
        "boot"
        "test"
        "build"
        "dry-build"
        "dry-activate"
        "edit"
        "build-vm"
        "build-vm-with-bootloader"
        "list-generations"
      ];
      flags = {
        all = [ "upgrade" "upgrade-all" "install-bootloader" "no-build-nix" "fast" "rollback" "builders" "profile-name" "specialisation" "build-host" "target-host" "use-substitutes" "use-remote-sudo" "flake" "no-flake" "override-input" "show-trace" "verbose" "impure" "keep-failed" "keep-going" "max-jobs" ];
        default = [ "fast" "keep-failed" "use-substitutes" ]; #"flake"];
      };
    };
    flake = {
      prefix = "flake-";
      commands = [ "archive" "check" "clone" "info" "init" "lock" "metadata" "new" "prefetch" "show" "update" ];
      flags = { all = [ ]; default = [ ]; };
    };
    nixos-generate = {
      prefix = "generate";
      commands = [ "amazon" "azure" "docker" "do" "gce" "hyperv" "install-iso-hyperv" "install-iso" "iso" "kubevirt" "linode" "lxc-metadata" "lxc" "openstack" "proxmox-lxc" "proxmox" "qcow" "raw-efi" "raw" "sd-aarch64-installer" "sd-aarch64" "vagrant-virtualbox" "virtualbox" "vm-bootloader" "vm" "vm-nogui" "vmware" ];
      flags = {
        all = [ "configuration" "flake" "format" "format-path" "list" "run" "show-trace" "system" "out-link" "cores" "option" ];
        default = [ "flake $NIX_FLAKE_SYSTEM" ];
      };
    };
  };
  risk = rec {
    # Nix sub-commands likely to conflict with others if named as standalone.
    max = [ "eval" "hash" "test" "info" "init" "lock" "new" "show" "clone" "check" ];
    high = [ "run" "copy" "edit" "fmt" "log" "archive" ] ++ max;
    medium = [ "build" "bundle" "profile" "shell" ] ++ high;
    low = [ "daemon" "registry" "repl" "search" "store" "upgrade" ] ++ medium;
    #none = lib.lists.subtractLists low subcmds;
  };
  isStandalone = i: !(builtins.elem i risk.medium);
  mkFlags = lst: lib.strings.concatStringsSep " " (builtins.map (flag: "--" + flag) lst);
  # TODO: Fix `subcmd` given string, expected list
  mkAliasRHS = cmd: subcmd: lib.strings.concatStringsSep " " cmd subcmd (mkFlags commands.${cmd}.flags.default);
  mkAliasLHS = cmd: subcmd: commands.${cmd}.prefix + subcmd;
  mkAlias = cmd: subcmd: { ${mkAliasLHS cmd subcmd} = mkAliasRHS cmd subcmd; } // lib.optionalAttrs (isStandalone subcmd) { ${subcmd} = mkAliasRHS; };
  #let right="${cmd} ${subcmd} ${mkFlags cmd}"; in {
  #${commands.${cmd}.prefix+subcmd} = mkAliasRHS cmd subcmd;
  mkAliases = cmd: extra: lib.fold (subcmd: acc: acc // mkAlias cmd subcmd) extra commands.${cmd}.commands;
  #mkShortcuts = alias-name-prefix: cmd-prefix: cmd-suffix: builtins.fold (i: acc: acc // (lib.optionalAttrs isStandalone {${i}=cmd-prefix+i;}) // {${alias-name-prefix+i}=cmd-prefix+i;}); #init subcmds.nix;
  #mkNixShortcuts   = init: mkShortcuts "n-" "nix " init commands.nix.commands.all;
  #mkNixosShortcuts = init: mkShortcuts "nos-" "nixos-rebuild " "nixos" init subcmds.nixos;
in
{
  environment = {
    sessionVariables = {
      NIX_FLAKE_SYSTEM = lib.mkDefault "~/.config/nixos";
      NIX_FLAKE_HOME = lib.mkDefault "~/.config/nixos";
    };
    shellAliases = {
      # --- manix ---
      # TODO: Conditional if pkgs.manix installed (no option)
      # TODO: Reference binary via package
      n-doc = "manix \"\" | rg '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
      n-manix = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
      nixpkgs = "nix search nixpkgs";
    }
    // {
      #// mkAliases "nix" {
      n = "nix";
      realization = "nix realisation";
      n-realization = "nix realisation";
      n-conf = "nix show-config";
      nb = "nix build";
      nf = "nix flake";
      nr = "nix run";
    }
    #// { # TODO: Move to profiles/nixos/aliases.nix
    #  #// mkAliases "nixos-rebuild" {
    #  nixos = "nixos-rebuild";
    #  nixo = "nixos-rebuild";
    #  nos = "nixos-rebuild";
    #  rebuild = "nixos-rebuild build";
    #  switch = "nixos-rebuild switch";
    #  boot = "nixos-rebuild boot";
    #  dry-activate = "nixos-rebuild dry-activate";
    #  dry-build = "nixos-rebuild dry-build";
    #  nos-activate = "nixos-rebuild activate";
    #  nos-rebuild = "nixos-rebuild build";
    #  nos-switch = "nixos-rebuild switch";
    #  nos-edit = "nixos-rebuild edit";
    #  nos-test = "nixos-rebuild test";
    #  #build-vm = "nixos-rebuild build-vm";
    #  build-vm-with-bootloader = "nixos-rebuild build-vm-with-bootloader";
    #  generations = "nixos-rebuild --list-generations";
    #  upgrade = "nixos-rebuild switch --upgrade-all";
    #  specialisation = "nixos-rebuild test --specialisation";
    #  specialization = "nixos-rebuild test --specialisation";
    #  rollback = "nixos-rebuild switch --rollback";
    #  nup = "nixos-rebuild switch --upgrade-all";
    #  noss = "nixos-rebuild switch --fast";
    #}
    // {
      #// mkAliases "flake" {
      #cfgd = "cd $NIX_FLAKE_SYSTEM"; #${flakeDir}";
      flakeDir = "echo $NIX_FLAKE_SYSTEM"; # ~/.config/nixos";
      flake-dir-system = "echo $NIX_FLAKE_SYSTEM";
      flake-dir-home = "echo $NIX_FLAKE_HOME";
      flake-cd-system = "cd $NIX_FLAKE_SYSTEM";
      flake-cd-home = "cd $NIX_FLAKE_HOME";
    }
      #// mkAliases "generators" {
      #}
    ;
  };
}
