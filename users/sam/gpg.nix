{ self
, inputs
, config
, lib
, pkgs
, ...
}:
#
# Good overview of GPG:
# - https://rgoulter.com/blog/posts/programming/2022-06-10-a-visual-explanation-of-gpg-subkeys.html
#
# TODO: Unify all secret-related config
# TODO: Move all GNOME-related config to ./gnome/default.nix or ./gnome/keys.nix
# TODO: Conditionally set pinentry program based on default desktop
# TODO: Figure out how to use pinentry ${pkgs.gcr_4}/libexec/gcr4-ssh-askpass everywhere
#
{
  programs.gpg = {
    # --- Basic GnuPG Options ---
    # See: man gpg(1)
    # https://gnupg.org/documentation/manuals/gnupg24/gpg.1.html
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg"; # Set GPGHOME to follow XDG Spec
    settings = {
      # TODO: Avoid hard-coding this as string
      default-key = "DC19 62D6 560F F66B B16F  99E0 C47C 1462 4041 0561";
      enable-progress-filter = true;
      list-options = [ "show-uid-validity" "show-photos" "show-keyring" ];
      no-comments = false;
      photo-viewer = "org.gnome.Loupe"; # TODO: Set based on desktop environment or use terminal photo viewer
      use-agent = true;
      utf8-strings = true;
      verify-options = [ "show-uid-validity" "show-photos" ];
      with-fingerprint = true;
      #agent-program = "";         # Agent program for secret key operations
      #dirmngr-program = "";       # Keyserver access program, default: /usr/local/bin/dirmngr
      #enable-large-rsa = true;    # TODO: Requires binary built with: large secure memory buffer
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
    enable = true;
    enableExtraSocket = true; # Enable extra socket of GnuPG key agent, useful for GPG Agent forwarding
    enableScDaemon = true;    # Enable scdaemon tool, enables ability to do smartcard operations
    #enableSshSupport = false; # Use GnuPG agent for SSH keys
    #extraConfig = ''
    #'';

    # TODO: Also set services.dbus.packages = [ pkgs.gcr ];
    #pinentryFlavor = "gnome3"; # gtk2 | gnome3 | curses | tty | qt | emacs

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
