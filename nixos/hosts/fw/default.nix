{inputs, ...}: {
  # https://github.com/nixvital/fprint-clear
  # https://github.com/ssddq/fw-ectool
  # https://github.com/mdvmeijer/fw-fanctrl-nix
  # https://github.com/DHowett/FrameworkHacksPkg
  # https://github.com/taotien/framework_toolbox
  # https://github.com/DHowett/framework-ec
  # https://github.com/morpheus636/awesome-framework
  imports = [
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ./hardware-configuration.nix # Configuration related to hardware
    # ./disko.nix
    ./displays.nix # Handles hardware peripherals for external & internal displays
    ./managed.nix # Include app-managed config: nixos-conf-editor & nix-software-center
    (inputs.self + /nixos/profiles)
    (inputs.self + /nixos/profiles/bluetooth.nix)
    (inputs.self + /nixos/profiles/desktop)
    (inputs.self + /nixos/profiles/gnome)
    (inputs.self + /nixos/profiles/fprintd.nix)
    # (inputs.self + /nixos/profiles/displaylink.nix)
    # (inputs.self + /nixos/profiles/hardware)
    (inputs.self + /nixos/profiles/hardware/peripherals/apple.nix)
    (inputs.self + /nixos/profiles/hardware/peripherals/logitech.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/printers.nix)
    # (inputs.self + /nixos/profiles/hardware/peripherals/scanners.nix)
    # (inputs.self + /nixos/profiles/hercules-ci.nix)
    # (inputs.self + /nixos/profiles/impermanence.nix)
    (inputs.self + /nixos/profiles/lanzaboote.nix)
    # (inputs.self + /nixos/profiles/network)
    # (inputs.self + /nixos/profiles/nixos)
    (inputs.self + /nixos/profiles/plymouth.nix)
    # (inputs.self + /nixos/profiles/server/kubernetes/k3s-node-main.nix)
    # (inputs.self + /nixos/profiles/slippi.nix)
    # (inputs.self + /nixos/profiles/sops.nix)
    (inputs.self + /nixos/profiles/systemd-boot.nix)
    (inputs.self + /nixos/profiles/systemd-initrd.nix)
    # (inputs.self + /nixos/profiles/systemd-homed.nix)
    (inputs.self + /nixos/profiles/thunderbolt.nix)
    (inputs.self + /nixos/profiles/tlp.nix)
    (inputs.self + /nixos/profiles/tpm2.nix)
    (inputs.self + /nixos/profiles/virt.nix)
    # (inputs.self + /nixos/profiles/vm-guest-windows.nix)
  ];
  console.useXkbConfig = true;
  disko.enableConfig = false;
  environment.etc.machine-id.text = "aa38a832d16e436d8aab8bb0550d4810";
  networking.hostId = "aa38a832";
  networking.hostName = "fw";
  system.stateVersion = "24.11";

  # programs.home-manager.enable = true;
  # isoImage = {
  #   isoName = lib.mkImageMediaOverride
  #   "lehmanator-${config.system.build.installHostname}-${config.system.nixos.release}-${inputs.self.shortRev or "dirty"}-${pkgs.stdenv.hostPlatform.uname.processor}.iso";
  #   volumeID = "lehmanator-${config.system.nixos.release}-${inputs.self.shortRev or "dirty"}-${pkgs.stdenv.hostPlatform.uname.processor}";
  # };
  # system.build = {
  #   installHostname = config.networking.hostName;
  #   installClosure = config.system.build.toplevel;
  #   installDiskoScript = config.system.build.diskoScript;
  #   installer = pkgs.runCommandLocal config.isoImage.isoName {
  #     isoPath = "${config.system.build.isoImage}/iso/${config.isoImage.isoName}";
  #   } ''ln -s "$isoPath" $out'';
  # };
}
