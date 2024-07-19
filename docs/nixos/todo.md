# NixOS Configurations To-Dos:

See also:

- [`docs/todo-cloud.md`](../todo-cloud.md)
- [`docs/config/todo-nixvim.md`)(../configs/todo-nixvim.md)
- [`docs/config/todo-shell.md`)(../configs/todo-shell.md)

## NixOS Configurations: Workstations

- [ ] TODO: Disable auto-login
- [ ] TODO: Limit maximum NixOS generations available as boot entries to save boot partition space
- [ ] TODO: Configure `sudo` logging to send email to `admin@piwine.com`
- [ ] TODO: ElectronJS apps: override packages to use `ozone` platform for light/dark mode support
- [ ] TODO: Configure PAM to support login with:
  - [ ] LDAP
  - [ ] Kerberos
  - [ ] OIDC / OAuth2
  - [ ] SAML
  - [ ] SSH Certificates
  - [ ] GPG / PGP authentication keys

- [ ] TODO: Configure PAM to support 2-Factor authentication using:
  - [ ] `SMS`
  - [ ] `TOTP` (authenticator apps / codes)
  - [ ] Email
  - [ ] YubiKey / NitroKey / OnlyKey

- [ ] TODO: Configure PAM to make 2-factor authentication mandatory

- [ ] TODO: Configure purple/pidgin plugins for:
  - [ ] TODO: `XMPP`
  - [ ] TODO: Matrix
  - [ ] TODO: Microsoft Teams
  - [ ] TODO: Facebook Messenger
  - [ ] TODO: Instagram Messenger

- [ ] TODO: Migrate apps from Flatpak to native nixpkgs
  - [ ] TODO: Get list of all installed flatpaks
  - [ ] TODO: Find equivalent packages in `nixpkgs` for flatpak apps
  - [ ] TODO: Use `nix-` to sandbox native packages in `nixpkgs` with `bubblewrap`

## NixOS Configurations: Servers

- [ ] TODO: Re-organize `homeManagerConfigurations`:
  - [ ] TODO: Move hmProfiles to `profiles/home-manager/{default,common}.nix`
  - [ ] TODO: Move hmProfiles to `profiles/home-manager/{nixos,darwin,nixondroid,wsl,system/{common,arch,debian,fedora}}/{default,common}.nix`
  - [ ] TODO: Move hmProfiles to `profiles/home-manager/<user>/{nixos,darwin,nixondroid,wsl,system/{common,arch,debian,fedora}}/{default,common}.nix`
  - [ ] TODO: Only use `users/<username>` for user-specific configurations
  - [ ] TODO: Create user configs: `users/{default,guest,root}/{default,common}.nix`

- [ ] TODO: Re-organize Nix configs to use libs:
  - [ ] TODO: `nix-community/haumea`
  - [ ] TODO: `paisano/paisano-core`
  - [ ] TODO: `divnix/std`
  - [ ] TODO: `divnix/hive`
  - [ ] TODO: `flake-parts`

- [ ] TODO: Re-organize profiles:
  - [ ] `profiles/{,common,nixos,darwin,wsl,nixondroid,system/{common,arch,debian,fedora}}/default.nix`

- [ ] TODO: Setup Nix secrets:
  - [ ] TODO: Configure `sops-nix` / `agenix` with keys that **are not** host-specific
    - [ ] TODO: Create domain-specific secret configs?
      - [ ] `profiles/domains/<domain>/secrets.yaml`
      - [ ] `profiles/servers/<server>/secrets.yaml`
  - [ ] TODO: Configure `sops-nix` / `agenix` with keys that **are**     host-specific
    - Hosts: `hosts/<hostname>/secrets.yaml` ?
    - Users: `users/<username>/secrets.yaml` ?


- [ ] TODO: Modify existing server profiles to accept arguments:
  - [ ] `domain`
  - [ ] `subdomain`


- [ ] TODO: Configure NixOS profiles for servers:

  - `profiles/servers/auth/{default,common}.nix`
  - `profiles/servers/auth/idp/{default,common,keycloak,ldap}.nix`
  - `profiles/servers/auth/kerberos/{default,common}.nix`
  - `profiles/servers/auth/ldap/{default,common,openldap,lldap,radius,bridge/{default,active-directory},active-directory}.nix`
  - `profiles/servers/auth/proxy/{default,common,oauth2proxy,vouch}.nix`

  - `profiles/servers/builder/{default,common}.nix`

  - `profiles/servers/certificate-authority/{default,common,tls}.nix`
  - `profiles/servers/certificate-authority/ssh/{default,common,keys,certs}.nix`
  - `profiles/servers/certificate-authority/gpg/{default,common,openpgp,gpg}.nix`

  - `profiles/servers/fileserver/{default,ftp,ftps,sftp,nfs}.nix`

  - `profiles/servers/mail/{default,common}.nix`
  - `profiles/servers/mail/bridge/{default,common,ews}.nix`
  - `profiles/servers/mail/webmail/{default,common,rainloop}.nix`
  - `profiles/servers/mail/protocols/{default,common,smtp,imap}.nix`

  - `profiles/servers/netboot/{default,common,tft,ipxe,pxe}.nix`

  - `profiles/servers/networking/{default,common}.nix`
  - `profiles/servers/networking/dns/{default,common,powerdns,avahi,pdns}.nix`

  - `profiles/servers/matrix/{default,common}.nix`
  - `profiles/servers/matrix/admin/{default,common}.nix`
  - `profiles/servers/matrix/bots/{default,common}.nix`
  - `profiles/servers/matrix/bridges/{default,common}.nix`
  - `profiles/servers/matrix/bridges/{appservice,}/{default,common}.nix`
  - `profiles/servers/matrix/calls/{default,common}.nix`
  - `profiles/servers/matrix/calls/frontend/{default,common,jitsi,jitsi-meet}.nix`
  - `profiles/servers/matrix/calls/nat/{default,common,coturn,stun,turn}.nix`
  - `profiles/servers/matrix/calls/protocols/{default,common,sip}.nix`
  - `profiles/servers/matrix/frontend/{default,common,element,hydrogen,schlidi}.nix`
  - `profiles/servers/matrix/homeserver/{default,common,synapse,dendrite,conduit}.nix`
  - `profiles/servers/matrix/integration/{default,common}.nix`
  - `profiles/servers/matrix/media/{default,common,ma1sd}.nix`
  - `profiles/servers/matrix/moderation/{default,common}.nix`

  - `profiles/servers/vpn/{default,common,{headscale,openvpn}/{default,common}}.nix`

  - `profiles/servers/webserver/{default,common,base,well-known}.nix`
  - `profiles/servers/webserver/<domain>/{default,common,base,well-known.nix` (domains: `piwine.com`, `pi.wine`)

  - [ ] Matrix AppServices / Bridges:
    - [ ] `XMPP`
    - [ ] Microsoft Teams
    - [ ] Facebook Messenger
    - [ ] Instagram Messenger
