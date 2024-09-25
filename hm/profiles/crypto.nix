{ ... }: {
  imports = [
    #./age.nix                     # age secret encryption
    #./gpg                         # GPG client
    #./gpg/agent.nix               # GPG agent
    #./sops.nix                    # sops secret encryption
    #./ssh/config.nix              # SSH client config
    #./ssh/certs.nix               # SSH cert authentication
    #./ssh/keys.nix                # SSH key authentication
    #./tls.nix                     # TLS certificates
    #./keyring/pass.nix            # services.pass-secret-service.enable
    #./keyring/password-store.nix  # services.password-store-sync.enable
    #./storage/luks.nix            # Per-user disk encryption using LUKS2 containers
    #./storage/ecryptfs.nix        # Per-user disk encryption using ecryptfs
    #./storage/fcryptfs.nix        # Per-user disk encryption using fcryptfs
    #./storage/gocryptfs.nix       # Per-user disk encryption using gocryptfs
    #./storage/gocryptfs.nix       # TODO: Other dir encryption method supported by Vaults GTK4 app
    #./vault.nix                   # Hashicorp Vault
  ];
}
