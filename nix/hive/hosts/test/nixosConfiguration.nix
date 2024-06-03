{ inputs, cell, super, }@args: {
  system.stateVersion = "24.05";
  inherit (super) bee;
  imports = with inputs; [
    { _module.args = super.specialArgs; }
    # --- omnibus ---
    #agenix.nixosModules.age
    arion.nixosModules.arion
    disko.nixosModules.default
    microvm.nixosModules.host
    ragenix.nixosModules.age
    #snapshotter.nixosModules.default #containerd k3s nix-snapshotter preload-containerd (all have -rootless versions)
    sops-nix.nixosModules.sops
    srvos.nixosModules.desktop
    #srvos.nixosModules.server
    #srvos.nixosModules.mixins-nginx
    srvos.nixosModules.mixins-nix-experimental
    srvos.nixosModules.mixins-systemd-boot
    #srvos.nixosModules.mixins-telegraf
    srvos.nixosModules.mixins-terminfo
    srvos.nixosModules.mixins-tracing
    srvos.nixosModules.mixins-trusted-nix-caches
    #srvos.nixosModules.roles-github-actions-runner
    srvos.nixosModules.roles-nix-remote-builder
    #srvos.nixosModules.roles-prometheus

    # --- flake.nix ---
    nix-flatpak.nixosModules.nix-flatpak
    # --- std ---
    cell.nixosModules.debug
    #inputs.cells.android.nixosModules.attestation-server

    cell.diskoConfigurations.test
  ] ++ (with cells.nixosProfiles; [
   acme                               hibernation                        rxe                           
   activation-base                    hidpi                              rygel                         
   activitywatch                      home-manager                       samba-client                  
   adb                                homed                              secureboot                    
   agenix                             hosts-blocking                     server-dns                    
   apparmor                           impermanence                       server-firefly                
   appimage                           installer-base.old                     server-headscale              
   arion                              installer-netboot                  server-ipxe                   
   auditd                             installer-repart                   server-nextcloud              
   auto-upgrade                       installer                          server-portunus               
   avahi                              installer.old                          server-postgres               
   bluetooth                          iscsi-initiator                    server-samba                  
   cachix-agent                       kubenix                            server-wireguard              
   cachix                             kvm                                shell-aliases                 
   colmena                            lanzaboote                         shell-base                    
   containerd                         libreoffice                        sits                          
   cpu-intel                          snowflake                     
   cri-o                              libvirt                            sops                          
   desktop-autologin                  locale-est                         specialization                
   desktop                            lxc                                ssbm-nix                      
   disk-utils                         lxd-image-server                   ssh-serve-store               
   display-base                       lxd                                sshd                          
   displaylink                        microvm                            sssd-client                   
   dns-base                           mobile-base                        stylix                        
   dnscrypt-proxy                     mobile-bootsplash-disable          sudo-rs                       
   docker                             mobile-bootsplash-enable           suspend                       
   emu-architectures                  mobile-button-config               systemd-boot                  
   envfs                              mobile-config                      systemd-debug                 
   filesystems-base                   mobile-disable-phosh               systemd-emergency             
   filesystems-bcachefs               mobile-encrypted-disk              systemd-initrd                
   filesystems-btrfs                  mobile-gtk-apps                    systemd-networkd-wireguard    
   filesystems-btrfs2                 motd                               systemd-repart                
   filesystems-lvm2                   neovim                             systemd-resolved              
   filesystems-mdadm                  networking-base                    tailscale-mullvad-exit-node   
   filesystems-ntfs                   networkmanager                     tailscale-oneshot-auth        
   filesystems-zfs                    nix-index                          tailscale-subnet-router       
   firewall                           nix-output-monitor                 tailscale                     
   flake-gemini                       nix-remote-builder                 thunderbolt                   
   flake-info                         nixified-ai                        tor                           
   flake-utils-plus                   nixos-generators                   touchscreen                   
   flatpak-apps                       nixos-images                       tpm2                          
   flatpak-declarative                nixvim                             ucarp                         
   flatpak                            normalize                          unl0kr                        
   fonts                              nur                                usb                           
   fprintd                            nushell                            user-primary                  
   fuse-eris-server                   ollama                             vm-guest-windows              
   fwupd                              oomd                               vm-host                       
   fzf                                peripherals-apple                  waydroid                      
   gdm                                peripherals-logitech               wayland                       
   github-actions-runner              peripherals-printers               wifi-hotspot                  
   gnome-apps                         peripherals-scanners               wifi-network-home             
   gnome-extensions-appearance        phosh                              wifi-radios                   
   gnome-extensions-clock             pipewire                           wifi                          
   gnome-extensions-desktop           plymouth                           wine                          
   gnome-extensions-gestures          podman                             wireguard-automesh            
   gnome-extensions-gsconnect         polkit                             wireguard                     
   gnome-extensions-pano              power-management                   xserver-base                  
   gnome-extensions-quicksettings     printing                           zsh                           
   gnome-extensions-search            qemu-web                           gnome-extensions              
   qemu                          
  ]);
  # bee = {
  #   system = "x86_64-linux";
  #   inherit (inputs) wsl;
  #   inherit (inputs.omnibus.flake.inputs) darwin;
  #   home = inputs.home-manager;
  #   pkgs = cell.pkgs.unstable-with-overlays;
  #   #pkgs = import inputs.nixpkgs {
  #   #  overlays = with inputs; [
  #   #    agenix.overlays.default
  #   #    arion.overlays.default
  #   #    audioNix.overlays.default
  #   #    devshell.overlays.default
  #   #    fenix.overlays.default
  #   #    flake_env.overlays.default
  #   #    microvm.overlay
  #   #    nil.overlays.coc-nil
  #   #    nil.overlays.nil
  #   #    nix-filter.overlays.default
  #   #    nuenv.overlays.nuenv
  #   #    nur.overlay
  #   #    ragenix.overlays.default
  #   #    snapshotter.overlays.default
  #   #    sops-nix.overlays.default
  #   #    typst.overlays.default
  #   #    inputs.nix-vscode-extensions.overlays.default
  #   #  ];
  #   #};
  # };
}
