{inputs, cell, }:
inputs.omnibus.lib.omnibus.mkSuites {

  # Suite that applies to all NixOS systems
  default = [
    {
      profiles = with cell.nixosProfiles; [
        adb
        apparmor
        appimage
        arion
        auditd
        auto-upgrade
        cachix
        # cachix-agent
        dns-base
        docker
        emu-architectures
        envfs
        filesystems-base
        firewall
        flake-gemini
        # flake-info
        flake-utils-plus
        flatpak-declarative
        flatpak-apps
        flatpak
        fonts
        
      ];
      keywords = [];
      knowledges = [ ];
    }
  ];
}
