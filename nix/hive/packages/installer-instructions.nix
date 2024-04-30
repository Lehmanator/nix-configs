{
  figlet,
  stdenv,
  writeShellApplication,
  writeShellScript, # { pkgs
  lib,
  ...
}:
#{ installer-instructions = pkgs.callPackage (
# TODO: Import in nixosConfigurations / nixosModules.installer & devShells.installer
# TODO: Apply formatting to portions of text. e.g. colors, underline, bold, etc.
# TODO: Write similar shell script to inform user of options during setup process.
# TODO: Display values from defaults & environment.
# TODO: Dynamically adjust output width when wrapping variable-length text.
writeShellApplication {
  name = "installer-instructions";
  runtimeInputs = [figlet stdenv];
  meta.description = "Provides installation instructions to be shown within the installation live image.";
  text = let
    raw = ''
      ╭─────────────────────────────────────────────────────────────╮
      │ ██   ████ ██ ██ ██   ██  ███  ██  ██  ███ ██████ ███  ████  │
      │ ██   ██   ██ ██ ███ ███ ██ ██ ███ ██ ██ ██  ██  ██ ██ ██ ██ │
      │ ██   ███  █████ ██ █ ██ ██ ██ ██ ███ ██ ██  ██  ██ ██ ██ ██ │
      │ ██   ██   ██ ██ ██   ██ █████ ██ ███ █████  ██  ██ ██ ████  │
      │ ████ ████ ██ ██ ██   ██ ██ ██ ██  ██ ██ ██  ██   ███  ██ ██ │
      ├─────────────────────────────────────────────────────────────┤
      │                                                             │
      │             Welcome to my NixOS installer!                  │
      │                                                             │
      ├──────────────┬──────────────────────────────────────────────┤
      │ Instructions │                                              │
      ├──────────────╯                                              │
      │                                                             │
      │ 1.  Run the installation command:                           │
      │   ╭────────────────────────────────╮                        │
      │   │  $  sudo installer-script      │                        │
      │   ╰────────────────────────────────╯                        │
      │ 2.  Enter disk encryption password when prompted.           │
      │ 3.  Done!  Seriously.  Enjoy your fresh NixOS system! :)    │
      │                                                             │
      ├────────────────────────────────┬────────────────────────────┤
      │ Customize installation process │                            │
      ├────────────────────────────────╯                            │
      │                                                             │
      │  ╭───[change hostname]──────────────────────────────╮       │
      │  │ $  export INSTALL_HOSTNAME=<new_hostname>        │       │
      │  ╰──────────────────────────────────────────────────╯       │
      │                                                             │
      │  ╭───[change git branch]────────────────────────────╮       │
      │  │ $  export GIT_REPO_BRANCH=<git_branch>           │       │
      │  ╰──────────────────────────────────────────────────╯       │
      │                                                             │
      │  ╭───[change system definition]─────────────────────╮       │
      │  │                                                  │       │
      │  │ # NOTE: This variable must point to a valid path │       │
      │  │ #       of a NixOS system closure path in the    │       │
      │  │ #       Nix store within this live environment.  │       │
      │  │                                                  │       │
      │  │ # TIP: Use Nix to build another system. Then set │       │
      │  │ #      this variable to its store path to use.   │       │
      │  │                                                  │       │
      │  │ $  export SYSTEM_CLOSURE=<new_system_store_path> │       │
      │  │                                                  │       │
      │  ╰──────────────────────────────────────────────────╯       │
      │                                                             │
      │  ╭───[run pre-install commands]─────────────────────╮       │
      │  │                                                  │       │
      │  │ # NOTE: This function will be called by the      │       │
      │  │ #       installer command:  lehmanator-install   │       │
      │  │ #       before formatting your disk & beginning  │       │
      │  │ #       the NixOS installation process.          │       │
      │  │                                                  │       │
      │  │ $  installer-prepare()                           │       │
      │  │      # ...                                       │       │
      │  │      # --- INSERT YOUR COMMANDS HERE ---         │       │
      │  │      # ...                                       │       │
      │  │    }                                             │       │
      │  │                                                  │       │
      │  ╰──────────────────────────────────────────────────╯       │
      │                                                             │
      │ If you need to see this info   ╭────────────────────────────┤
      │ again, re-run this command:    │ $  installer-instructions  │
      ╰────────────────────────────────┴────────────────────────────╯
    '';
  in ''
    #set -euxo pipefail
    echo "${raw}"
  '';
}
