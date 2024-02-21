{
  config,
  lib,
  pkgs,
  self,
  inputs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Disable sudo-rs on install media
  security.sudo-rs.enable = lib.mkImageMediaOverride false;

  # Make sure we can use nix commands and flakes in installer
  nix = {
    package = pkgs.nixUnstable;
    settings.experimental-features = ["nix-command" "flakes" "repl-flake"];
  };

  boot = {
    kernelParams = lib.mkAfter ["noquiet"];

    # TODO: installer does not support systemd initrd yet
    #  Should be supported upstream soon-ish
    initrd.systemd = {
      enable = lib.mkImageMediaOverride false;
      emergencyAccess = lib.mkImageMediaOverride true;
    };
  };

  isoImage = {
    isoName =
      lib.mkImageMediaOverride
      "lehmanator-${config.system.build.installHostname}-${config.system.nixos.release}-${
        self.shortRev or "dirty"
      }-${pkgs.stdenv.hostPlatform.uname.processor}.iso";
    volumeID = "lehmanator-${config.system.nixos.release}-${
      self.shortRev or "dirty"
    }-${pkgs.stdenv.hostPlatform.uname.processor}";
  };

  networking.hostName =
    lib.mkImageMediaOverride "${config.system.build.installHostname}-installer";

  # TODO: Move to package file. Import here. Also import in devShell.
  # TODO: Make pretty.
  # TODO: Write similar shell script to inform user of options during setup process.
  # TODO: Inform user about defining SYSTEM_CLOSURE, INSTALL_HOSTNAME, & lehmanator-install
  environment.systemPackages = with pkgs; let
    installer-instructions = writeShellApplication {
      name = "installer-instructions";
      runtimeInputs = [pkgs.figlet];
      text = ''
        set -euxo pipefail
        echo '╭─────────────────────────────────────────────────────────────╮'
        echo '│ ██   ████ ██ ██ ██   ██  ███  ██  ██  ███ ██████ ███  ████  │'
        echo '│ ██   ██   ██ ██ ███ ███ ██ ██ ███ ██ ██ ██  ██  ██ ██ ██ ██ │'
        echo '│ ██   ███  █████ ██ █ ██ ██ ██ ██ ███ ██ ██  ██  ██ ██ ██ ██ │'
        echo '│ ██   ██   ██ ██ ██   ██ █████ ██ ███ █████  ██  ██ ██ ████  │'
        echo '│ ████ ████ ██ ██ ██   ██ ██ ██ ██  ██ ██ ██  ██   ███  ██ ██ │'
        echo '├─────────────────────────────────────────────────────────────┤'
        echo '│                                                             │'
        echo '│             Welcome to my NixOS installer!                  │'
        echo '│                                                             │'
        echo '├──────────────┬──────────────────────────────────────────────┤'
        echo '│ Instructions │                                              │'
        echo '├──────────────╯                                              │'
        echo '│                                                             │'
        echo '│ 1.  Run the installation command:                           │'
        echo '│   ╭────────────────────────────────╮                        │'
        echo '│   │  $  sudo lehmanator-install    │                        │'
        echo '│   ╰────────────────────────────────╯                        │'
        echo '│ 2.  Enter disk encryption password when prompted.           │'
        echo '│ 3.  Done!  Seriously.  Enjoy your fresh NixOS system! :)    │'
        echo '│                                                             │'
        echo '├────────────────────────────────┬────────────────────────────┤'
        echo '│ Customize installation process │                            │'
        echo '├────────────────────────────────╯                            │'
        echo '│                                                             │'
        echo '│  ╭───[change hostname]──────────────────────────────╮       │'
        echo '│  │ $  export INSTALL_HOSTNAME=<new_hostname>        │       │'
        echo '│  ╰──────────────────────────────────────────────────╯       │'
        echo '│                                                             │'
        echo '│  ╭───[change git branch]────────────────────────────╮       │'
        echo '│  │ $  export GIT_REPO_BRANCH=<git_branch>           │       │'
        echo '│  ╰──────────────────────────────────────────────────╯       │'
        echo '│                                                             │'
        echo '│  ╭───[change system definition]─────────────────────╮       │'
        echo '│  │                                                  │       │'
        echo '│  │ # NOTE: This variable must point to a valid path │       │'
        echo '│  │ #       of a NixOS system closure path in the    │       │'
        echo '│  │ #       Nix store within this live environment.  │       │'
        echo '│  │                                                  │       │'
        echo '│  │ # TIP: Use Nix to build another system. Then set │       │'
        echo '│  │ #      this variable to its store path to use.   │       │'
        echo '│  │                                                  │       │'
        echo '│  │ $  export SYSTEM_CLOSURE=<new_system_store_path> │       │'
        echo '│  │                                                  │       │'
        echo '│  ╰──────────────────────────────────────────────────╯       │'
        echo '│                                                             │'
        echo '│  ╭───[run pre-install commands]─────────────────────╮       │'
        echo '│  │                                                  │       │'
        echo '│  │ # NOTE: This function will be called by the      │       │'
        echo '│  │ #       installer command: `lehmanator-install`  │       │'
        echo '│  │ #       before formatting your disk & beginning  │       │'
        echo '│  │ #       the NixOS installation process.          │       │'
        echo '│  │                                                  │       │'
        echo '│  │ $  lehmanator-prepare()                          │       │'
        echo '│  │      # ...                                       │       │'
        echo '│  │      # --- INSERT YOUR COMMANDS HERE ---         │       │'
        echo '│  │      # ...                                       │       │'
        echo '│  │    }                                             │       │'
        echo '│  │                                                  │       │'
        echo '│  ╰──────────────────────────────────────────────────╯       │'
        echo '│                                                             │'
        echo '│ If you need to see this info   ╭────────────────────────────┤'
        echo '│ again, re-run this command:    │ $  installer-instructions  │'
        echo '╰────────────────────────────────┴────────────────────────────╯'
      '';
    };
    # TODO: ALlow customizing mount path.
    # TODO: Allow previewing/adding config from command: nixos-generate-config
    installer-script = pkgs.writeShellApplication {
      name = "lehmanator-install";
      runtimeInputs = [
        pkgs.nixUnstable
        pkgs.openssh
        pkgs.gitAndTools.gitFull
        pkgs.figlet
      ];
      text = ''
        set -euxo pipefail
        export SYSTEM_CLOSURE='${config.system.build.installClosure}'
        export INSTALL_HOSTNAME='${config.system.build.installHostname}'
        BRANCH="''${GIT_REPO_BRANCH:-main}"

        # Allow writing an extra script that can be called in the install process when defined
        which lehmanator-prepare &>/dev/null && {
          echo 'Running prepare function...'
          lehmanator-prepare && echo 'Prepared.' || echo 'Prepare function failed.'
        }

        # TODO: Ask user if they want to provide a disko config.
        ${config.system.build.installDiskoScript or "echo 'INFO: No disko config provided. Not partitioning automatically.'"}

        # Copy self (flake) to /mnt/etc/nixos
        mkdir -p /mnt/etc
        cp -rT ${self} /mnt/etc/nixos
        git -C /mnt/etc/nixos init
        git -C /mnt/etc/nixos remote add origin git@github.com:lehmanator/nix-configs.git
        (
          git -C /mnt/etc/nixos fetch && \
          git -C /mnt/etc/nixos reset ${self.rev or "origin/HEAD"} && \
          git -C /mnt/etc/nixos branch --set-upstream-to="origin/$BRANCH" "$BRANCH"
        ) || true
        if nix eval "/mnt/etc/nixos#nixosConfigurations.$INSTALL_HOSTNAME.config.environment.persistence./state" >/dev/null; then
          mkdir -p /mnt/etc/ssh
          echo "Please enter the SSH RSA host key for $INSTALL_HOSTNAME and then press CTRL-D:"
          cat >/mnt/etc/ssh/ssh_host_rsa_key
          chmod u=rw,go= /mnt/etc/ssh/ssh_host_rsa_key
          ssh-keygen -y -f /mnt/etc/ssh/ssh_host_rsa_key >/mnt/etc/ssh/ssh_host_rsa_key.pub

          echo "Please enter the SSH ed25519 host key for $INSTALL_HOSTNAME and then press CTRL-D:"
          cat >/mnt/etc/ssh/ssh_host_ed25519_key
          chmod u=rw,go= /mnt/etc/ssh/ssh_host_ed25519_key
          ssh-keygen -y -f /mnt/etc/ssh/ssh_host_ed25519_key >/mnt/etc/ssh/ssh_host_ed25519_key.pub
        fi
        if nix eval "/mnt/etc/nixos#nixosConfigurations.$INSTALL_HOSTNAME.config.sops.secrets" >/dev/null; then
          mkdir -p /mnt/state/etc
          cp -a /mnt/etc/nixos /mnt/state/etc/
          if [ -e /mnt/etc/ssh ]; then
            mkdir -p /mnt/state/etc/ssh
            cp -a /mnt/etc/ssh/ssh_host_{rsa,ed25519}_key{,.pub} /mnt/state/etc/ssh/
          fi
        fi
        installArgs=(--no-channel-copy)
        if [ "$(nix eval "/mnt/etc/nixos#nixosConfigurations.$INSTALL_HOSTNAME.config.users.mutableUsers")" = "false" ]; then
          installArgs+=(--no-root-password)
        fi

        nixos-install --flake "/mnt/etc/nixos#$INSTALL_HOSTNAME" "''${installArgs[@]}"
      '';
    };
  in [installer-instructions installer-script];
  #system.build = {
  #  installHostname = config.networking.hostName;
  #  installClosure = config.system.build.toplevel;
  #  installDiskoScript = config.system.build.diskoScript;
  #  #installerSystem = installerConfiguration;
  #  installer = let
  #    isoName = config.isoImage.isoName;
  #    isoPath = "${config.system.build.isoImage}/iso/${isoName}";
  #  in
  #    pkgs.runCommandLocal isoName {inherit isoPath;}
  #    ''ln -s "$isoPath" $out'';
  #};

  programs.git = {
    enable = true;
    package = lib.mkImageMediaOverride pkgs.gitAndTools.gitFull;
  };
}
