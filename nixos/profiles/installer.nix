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

  security.sudo-rs.enable = lib.mkImageMediaOverride false;

  boot = {
    kernelParams = lib.mkAfter ["noquiet"];
    # TODO: installer does not support systemd initrd yet
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
  # TODO: Inform user about defining SYSTEM_CLOSURE, INSTALL_HOSTNAME, & lehmanator-install
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "lehmanator-install";
      runtimeInputs = [pkgs.nixUnstable pkgs.openssh pkgs.gitFull];
      text = ''
        set -euxo pipefail

        export SYSTEM_CLOSURE='${config.system.build.installClosure}'
        export INSTALL_HOSTNAME='${config.system.build.installHostname}'

        # Allow writing an extra script that can be called in the install process when defined
        which lehmanator-prepare &>/dev/null && lehmanator-prepare

        ${config.system.build.installDiskoScript or "echo 'No disko config, not partitioning automatically'"}

        mkdir -p /mnt/etc
        cp -rT ${self} /mnt/etc/nixos
        git -C /mnt/etc/nixos init
        git -C /mnt/etc/nixos remote add origin git@github.com:lehmanator/nix-configs.git
        (
          git -C /mnt/etc/nixos fetch && \
          git -C /mnt/etc/nixos reset ${self.rev or "origin/HEAD"} && \
          git -C /mnt/etc/nixos branch --set-upstream-to=origin/develop develop
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
    })
  ];

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
}
