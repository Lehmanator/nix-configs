{ figlet
, stdenv
, writeShellApplication
, writeShellScript
#{ pkgs
, lib
, ...
}:
#{ installer-instructions = pkgs.callPackage (
# TODO: Import in nixosConfigurations / nixosModules.installer & devShells.installer
# TODO: Apply formatting to portions of text. e.g. colors, underline, bold, etc.
# TODO: Write similar shell script to inform user of options during setup process.
# TODO: Display values from defaults & environment.
# TODO: Dynamically adjust output width when wrapping variable-length text.
writeShellApplication {
  name = "installer-instructions";
  runtimeInputs = [ figlet stdenv ];
  text = ''
    #set -euxo pipefail
    echo "╭─────────────────────────────────────────────────────────────╮"
    echo "│ ██   ████ ██ ██ ██   ██  ███  ██  ██  ███ ██████ ███  ████  │"
    echo "│ ██   ██   ██ ██ ███ ███ ██ ██ ███ ██ ██ ██  ██  ██ ██ ██ ██ │"
    echo "│ ██   ███  █████ ██ █ ██ ██ ██ ██ ███ ██ ██  ██  ██ ██ ██ ██ │"
    echo "│ ██   ██   ██ ██ ██   ██ █████ ██ ███ █████  ██  ██ ██ ████  │"
    echo "│ ████ ████ ██ ██ ██   ██ ██ ██ ██  ██ ██ ██  ██   ███  ██ ██ │"
    echo "├─────────────────────────────────────────────────────────────┤"
    echo "│                                                             │"
    echo "│             Welcome to my NixOS installer!                  │"
    echo "│                                                             │"
    echo "├──────────────┬──────────────────────────────────────────────┤"
    echo "│ Instructions │                                              │"
    echo "├──────────────╯                                              │"
    echo "│                                                             │"
    echo "│ 1.  Run the installation command:                           │"
    echo "│   ╭────────────────────────────────╮                        │"
    echo "│   │  $  sudo installer-script      │                        │"
    echo "│   ╰────────────────────────────────╯                        │"
    echo "│ 2.  Enter disk encryption password when prompted.           │"
    echo "│ 3.  Done!  Seriously.  Enjoy your fresh NixOS system! :)    │"
    echo "│                                                             │"
    echo "├────────────────────────────────┬────────────────────────────┤"
    echo "│ Customize installation process │                            │"
    echo "├────────────────────────────────╯                            │"
    echo "│                                                             │"
    echo "│  ╭───[change hostname]──────────────────────────────╮       │"
    echo "│  │ $  export INSTALL_HOSTNAME=<new_hostname>        │       │"
    echo "│  ╰──────────────────────────────────────────────────╯       │"
    echo "│                                                             │"
    echo "│  ╭───[change git branch]────────────────────────────╮       │"
    echo "│  │ $  export GIT_REPO_BRANCH=<git_branch>           │       │"
    echo "│  ╰──────────────────────────────────────────────────╯       │"
    echo "│                                                             │"
    echo "│  ╭───[change system definition]─────────────────────╮       │"
    echo "│  │                                                  │       │"
    echo "│  │ # NOTE: This variable must point to a valid path │       │"
    echo "│  │ #       of a NixOS system closure path in the    │       │"
    echo "│  │ #       Nix store within this live environment.  │       │"
    echo "│  │                                                  │       │"
    echo "│  │ # TIP: Use Nix to build another system. Then set │       │"
    echo "│  │ #      this variable to its store path to use.   │       │"
    echo "│  │                                                  │       │"
    echo "│  │ $  export SYSTEM_CLOSURE=<new_system_store_path> │       │"
    echo "│  │                                                  │       │"
    echo "│  ╰──────────────────────────────────────────────────╯       │"
    echo "│                                                             │"
    echo "│  ╭───[run pre-install commands]─────────────────────╮       │"
    echo "│  │                                                  │       │"
    echo "│  │ # NOTE: This function will be called by the      │       │"
    echo "│  │ #       installer command: `lehmanator-install`  │       │"
    echo "│  │ #       before formatting your disk & beginning  │       │"
    echo "│  │ #       the NixOS installation process.          │       │"
    echo "│  │                                                  │       │"
    echo "│  │ $  installer-prepare()                           │       │"
    echo "│  │      # ...                                       │       │"
    echo "│  │      # --- INSERT YOUR COMMANDS HERE ---         │       │"
    echo "│  │      # ...                                       │       │"
    echo "│  │    }                                             │       │"
    echo "│  │                                                  │       │"
    echo "│  ╰──────────────────────────────────────────────────╯       │"
    echo "│                                                             │"
    echo "│ If you need to see this info   ╭────────────────────────────┤"
    echo "│ again, re-run this command:    │ $  installer-instructions  │"
    echo "╰────────────────────────────────┴────────────────────────────╯"
  '';
}
