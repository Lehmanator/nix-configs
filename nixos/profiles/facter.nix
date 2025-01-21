{ inputs, config, lib, pkgs, ... }:
let
  # --- nixos-facter ---
  # Hardware reports to be used to configure NixOS.
  #   Aims to replace:
  #   - nixos-hardware 
  #   - nixos-generate-config
  #
  # Docs: https://nix-community.github.io/nixos-facter/latest
  #
  # Repo:
  # - Program: https://github.com/nix-community/nixos-facter
  # - Modules: https://github.com/nix-community/nixos-facter-modules
  #
  # Usage:
  # - $ sudo nix run github:nix-community/nixos-facter#nixos-facter -- -o facter.json
  # - $ sudo nix run                           nixpkgs#nixos-facter -- -o facter.json
  #
  # To-Do:
  #
  # - [ ] TODO: Conditional import `nixos/hosts/${config.networking.hostName}/hardware-configuration.nix`
  #
  # List of items nixos-facter can provide.
  hardware = rec {
    all = default-used ++ default-unused;
    default-used = ["bios" "block" "cpu" "memory" "monitor" "net" "pci" "prom" "sbus" "scsi" "serial" "sys" "sysfs" "udev" "usb" "wlan" ];
    default-unused = [
      "adb"
      "all"
      "bios_acpi"   "bios_crc"     "bios_ddc"     "bios_ddc_ports" "bios_fb" "bios_mode" "bios_vbe" "bios_vesa" "bios_vram"
      "block_cdrom" "block_mods"   "block_part"
      "braille"     "braille_alva" "braille_baum" "braille_fhp"    "braille_ht"
      "cpuemu"      "cpuemu_debug"
      "edd"         "edd_mod"
      "fb"
      "floppy"
      "fork"
      "hal"
      "ignx11"
      "input"
      "isa"         "isa_isdn"
      "isapnp"      "isapnp_mod"   "isapnp_new"   "isapnp_old"
      "isdn"
      "kbd"
      "lxrc"
      "manual"
      "max"
      "misc"        "misc_floppy"
      "misc_par"    "misc_serial"
      "modem"       "modem_usb"
      "modules_pata"
      "mouse"
      "net_eeprom"
      "parallel"    "parallel_imm" "parallel_lp" "parallel_zip"
      "pcmcia"
      "pppoe"
      "s390"        "s390disks"
      "scan"
      "scsi_noserial"
      "usb_mods"
      "veth"
      "x86emu"
    ];
  };
in
{
  imports = [inputs.facter.nixosModules.facter];
  facter.reportPath = inputs.self + /nixos/hosts/${config.networking.hostName}/facter.json;

  # Include binary in system environment.
  environment.systemPackages = [
    inputs.facter.packages.${pkgs.system}.nixos-facter
    (pkgs.writeShellApplication {
      name = "facter";
      runtimeInputs = [inputs.facter.packages.${pkgs.system}.nixos-facter];
      text = ''
        nixos-facter                                                        \
          --hardware ${builtins.concatStringsSep "," hardware.default-used} \
          --output nixos/hosts/${config.networking.hostName}/facter.json    \
          --swap
      '';
    })
  ];
}
