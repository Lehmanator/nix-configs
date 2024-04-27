{ inputs
, config
, lib
, pkgs
, ...
}:
# Good overview of GPG:
# - https://rgoulter.com/blog/posts/programming/2022-06-10-a-visual-explanation-of-gpg-subkeys.html
#
# TODO: Unify all secret-related config
# TODO: Move all GNOME-related config to ./gnome/default.nix or ./gnome/keys.nix
# TODO: Figure out how to use pinentry ${pkgs.gcr_4}/libexec/gcr4-ssh-askpass everywhere
# TODO: Use pkgs.gpg with binary built with "large secure memory buffer" (for option: enable-large-rsa)
# TODO: Avoid hard-coding default key as string
# TODO: Set services.gpg-agent.pinentryFlavor conditionally based on default desktop
# TODO: Set programs.gpg.settings.photo-viewer = "<defaultProgram>" based on desktop environment / terminal photo viewer program
# TODO: Set programs.gpg.settings.use-agent = true when any GPG agent program is enabled (services.gpg-agent.enable)
{
  programs.gpg = {
    # --- Basic GnuPG Options ---
    # See: man gpg(1)
    # https://gnupg.org/documentation/manuals/gnupg24/gpg.1.html
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg"; # Set GPGHOME to follow XDG Spec
    settings = {
      enable-progress-filter = true;
      list-options = [
        "show-uid-validity"
        "show-keyring"
        #"show-photos"
      ];
      no-comments = false;
      photo-viewer = "${pkgs.lsix}/bin/lsix"; #"org.gnome.Loupe";
      use-agent = true;
      utf8-strings = true;
      verify-options = [
        "show-uid-validity"
        #"show-photos"
      ];
      with-fingerprint = true;
      #agent-program = "";         # Agent program for secret key operations
      #dirmngr-program = "";       # Keyserver access program, default: /usr/local/bin/dirmngr
      #enable-large-rsa = true;    #
      #show-keyserver-urls = true; # invalid
      #show-notations = true;      # invalid
      #show-policy-urls = true;    # invalid
      #show-sig-expire = true;     # invalid
      #show-usage = true;          # invalid
    };
    #package = pkgs.gnupg
    #mutableKeys = false;  # Default: true
    #mutableTrust = true;  # Default: true
    # --- Smartcard Daemon ---
    # pkgs.gnupg-pkcs11-scd  # scdaemon that enables use of PKCS#11 tokens w/ GnuPG
    # See: man scdaemon(1)
    #scdaemonSettings = {
    #  disable-ccid = true;
    #};
    # --- External Public Keys ---
    # WARN: Entries here will be added to the world-viewable Nix store
    #publicKeys = [
    #{
    #  source = ./pubkeys.txt;
    #  text = "";        # Text of OpenPGP public key
    #  trust = "full";  # unknown | never | marginal | full | ultimate
    #}
    #];
  };

  # --- GnuPG Agent ---
  services.gpg-agent = {
    enable = true; # Use agent to manage access to GPG keys
    enableExtraSocket = true; # Enable extra socket of GnuPG key agent, useful for GPG Agent forwarding
    enableScDaemon = true; # Enable scdaemon tool, enables ability to do smartcard operations
    enableSshSupport = lib.mkIf (!config.services.gnome-keyring.enable) true; # Use GnuPG agent for SSH keys
    defaultCacheTtl = 1800;
    defaultCacheTtlSsh = 1800;
    #grabKeyboardAndMouse = true;
    #maxCacheTtl = null;
    #maxCacheTtlSsh = null;
    # TODO: Also set services.dbus.packages = [ pkgs.gcr ];
    verbose = true;
    extraConfig = ''
      allow-loopback-pinentry
    '';
    # Which GPG keys (by keygrip) to expose as SSH keys
    #sshKeys = [
    #  ""
    #];
  };

  # --- Keychain ---
  #programs.keychain.agents = [
  #];

  # --- PAM ---
  # TODO: See if pam_gnupg is used with existing config
  # TODO: Enable pam_gnupg if not already (to unlock GPG keys on login)

  # --- GNOME Keyring ---
  # --- libsecret ---
  # --- Secret Service ---
  # --- age/rage ---
  # --- agenix/sops-nix ---
  # --- SSH Agent ---
  # --- SSH Client ---
}
