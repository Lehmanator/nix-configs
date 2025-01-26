{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
# https://github.com/nix-community/impermanence
let
  inherit (lib) optional optionals;

  # Control how much to save by default
  #  "lenient" = save everything we might need without granularity. safest option
  #  "default" = save all services dataDirs.
  #  "explicit" = require manual saving of every directory.
  preset = "lenient";
  # TODO: Create lib to search `options.services` for items with `dataDir` & use lib.mkIf enable dataDir
  # TODO: How to deal with thunks?
  # dataDirs =
  #   # Filter out null values
  #   lib.filter (d: builtins.isString)
  #   # if service is enabled, add its dataDir
  #   (
  #     builtins.mapAttrs (n: v:
  #       if v.enable
  #       then v.dataDir
  #       else null)
  #     # Filter services to only those with attrs "enable" & "dataDir"
  #     (lib.filterAttrs (n: v: ((builtins.hasAttr "enable" v) && (v.enable == true)) && ((builtins.hasAttr "dataDir" v) && (builtins.isString v.dataDir)))
  #       # Get all service configs
  #       (builtins.attrValues config.services))
  #   );
in {
  imports = [inputs.impermanence.nixosModules.default];

  # Enable impermanence for home-manager too.
  # TODO: Move to hm/profiles/impermanence.nix
  home-manager = {
    sharedModules = [
      # inputs.impermanence.homeManagerModules.impermanence
      # (inputs.self + /hm/profiles/impermanence.nix)
    ];
    # users.${user} = {config, ...}: {
    #   imports = [
    #     inputs.impermanence.homeManagerModules.default
    #     (inputs.self + /hm/profiles/impermanence.nix)
    #   ];
    # };
    #   home.persistence."/nix/persist/users/${config.home.username}" = {
    #     directories =
    #       (builtins.attrValues config.xdg.userDirs.extraConfig)
    #       ++ [
    #         ".ssh"
    #         ".gnupg"
    #       ]
    #       ++ (optionals (preset == "lenient") [
    #         ".cache"
    #         ".local/share"
    #         ".local/state"
    #         ".local/repos"
    #         ".var/app"
    #       ]);
    #     files = [];
    #   };
    # };
  };
  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist/system" = {
    hideMounts = true;
    directories =
      [
        # TODO: Caches
        # TODO: Containers
        "/etc/nixos"
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ]
      ++ (optionals (preset == "lenient") [
        "/var/lib"
        "/etc"
      ])
      # ++ dataDirs
      ++ (optional config.hardware.bluetooth.enable "/var/lib/bluetooth")
      ++ (optional config.networking.nftables.enable "/var/lib/nftables")
      ++ (optional config.networking.networkmanager.enable "/etc/NetworkManager/system-connections")
      ++ (optional config.programs.ccache.enable config.programs.ccache.cacheDir or "/nix/var/cache/ccache")
      ++ (optional config.programs.rust-motd.enable "/var/lib/rust-motd")
      ++ (optional config.security.acme.acceptTerms "/var/lib/acme")
      ++ (optional config.security.tpm2.enable "/var/lib/tpm")
      ++ (optional config.services.accounts-daemon.enable "/var/lib/AccountsService")
      ++ (optional config.services.airsonic.enable config.services.airsonic.home)
      ++ (optional config.services.amule.enable config.services.amule.dataDir)
      ++ (optional config.services.anuko-time-tracker.enable config.services.anuko-time-tracker.dataDir)
      ++ (optional config.services.archisteamfarm.enable config.services.archisteamfarm.dataDir)
      ++ (optional config.services.audiobookshelf.enable config.services.audiobookshelf.dataDir)
      ++ (optional config.services.awstats.enable config.services.awstats.dataDir)
      # ++ (optional config.services.bitcoind.enable config.services.bitcoind.dataDir)
      # ++ (optional config.services.blockbook-frontend."${name}".enable config.services.blockbook-frontend.dataDir)
      ++ (optional config.services.boinc.enable config.services.boinc.dataDir)
      ++ (optional config.services.bookstack.enable config.services.bookstack.dataDir)
      ++ (optional config.services.caddy.enable config.services.caddy.dataDir)
      ++ (optional config.services.calibre-web.enable config.services.calibre-web.dataDir)
      ++ (optional config.services.etcd.enable config.services.etcd.dataDir)
      ++ (optional config.services.fprintd.enable "/var/lib/fprint")
      ++ (optional config.services.firefly-iii.enable config.services.firefly-iii.dataDir)
      ++ (optional config.services.hardware.bolt.enable "/var/lib/boltd")
      ++ (optional config.services.jackett.enable config.services.jackett.dataDir)
      ++ (optional config.services.kubernetes.apiserver.enable config.services.kubernetes.dataDir)
      ++ (optional config.services.kubernetes.kubelet.enable "/var/lib/kubelet")
      ++ (optional config.services.lidarr.enable config.services.lidarr.dataDir)
      ++ (optional config.services.mosquitto.enable config.services.mosquitto.dataDir)
      ++ (optional config.services.openssh.enable "/etc/ssh")
      ++ (optional config.services.ollama.enable "/var/lib/private/ollama")
      ++ (optional config.services.printing.enable "/var/lib/cups")
      ++ (optional config.services.radarr.enable config.services.radarr.dataDir)
      ++ (optional config.services.readarr.enable config.services.readarr.dataDir)
      ++ (optional config.services.rke2.enable config.services.rke2.dataDir)
      ++ (optional config.services.sonarr.enable config.services.sonarr.dataDir)
      ++ (optional config.services.tabby.enable "/var/lib/private/tabby")
      ++ (optional config.services.tailscale.enable "/var/lib/tailscale")
      ++ (optional config.services.tcsd.enable config.services.tcsd.stateDir)
      ++ (optional config.services.tmate-ssh-server.enable config.services.tmate-ssh-server.keysDir)
      ++ (optional config.services.wgautomesh.enable "/var/lib/private/wgautomesh")
      # ++ (optional config.boot.lanzaboote.enable config.boot.lanzaboote.pkiBundle)
      # ++ (optional config.microvm.host.enable config.microvm.stateDir or "/var/lib/microvms")
      # ++ (optional config.services.attestation-server.enable "/var/lib/private/attestation")
      # ++ (optional config.services.harmonia.enable config.sops.secrets.harmonia-signing-key.path)
      # ++ (optional config.services.invokeai.enable config.services.invokeai.settings.root or "/var/lib/invokeai")
      ++ (optional config.virtualisation.containerd.enable "/var/lib/containerd")
      ++ (optional config.virtualisation.containers.enable "/var/lib/containers")
      ++ (optional config.virtualisation.cri-o.enable "/var/lib/crio")
      ++ (optional config.virtualisation.libvirtd.enable "/var/lib/libvirtd")
      ++ (optional config.virtualisation.waydroid.enable "/var/lib/waydroid")
      # ++ (optional config.virtualisation.qemu.qemuGuest.enable "/var/lib/qemu") # TODO: Which runs in host vs. guest?
      # ++ (optional config.services.qemuGuest.enable "/var/lib/qemu")
      ++ (optionals config.services.activemq.enable [config.services.activemq.baseDir config.services.activemq.configurationDir])
      ++ (optionals config.services.k3s.enable ["/var/lib/rancher/k3s" "/etc/rancher/k3s"])
      ++ (optionals config.services.flatpak.enable ["/var/lib/flatpak" "/var/lib/flatpak-module"]);

    files =
      [
        "/etc/machine-id"
        #{ file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      ]
      ++ (optional config.services.sshguard.enable config.services.sshguard.blacklist_file);

    users.${user} = {
      directories =
        [
          "Audio"
          "Backup"
          "Books"
          "Code"
          "Documents"
          "Downloads"
          "Games"
          "Music"
          "Nix"
          "Notes"
          "Pictures"
          "Templates"
          "Videos"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
          {
            directory = ".nixops";
            mode = "0700";
          }
          ".kube"
          ".pki"
        ]
        ++ (optional config.programs.adb.enable ".android")
        ++ (optional config.programs.dconf.enable ".config/dconf")
        ++ (optional config.programs.direnv.enable ".local/share/direnv")
        ++ (optional config.programs.firefox.enable ".mozilla")
        ++ (optionals config.services.flatpak.enable [".local/share/flatpak" ".var"])
        ++ (optional config.services.openssh.enable {
          directory = ".ssh";
          mode = "0700";
        })
        # ++ (optionals config.age.enable [".config/age" ".config/sops/age"])
        ++ (optionals (preset == "lenient") [
          ".cache"
          ".local/share"
          # ".mozilla"
          # ".pki"
        ]);
    };
  };
}
