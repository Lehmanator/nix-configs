{ self
, inputs
, config
, lib
, pkgs
, ...
}:
# https://rgoulter.com/blog/posts/programming/2022-06-10-a-visual-explanation-of-gpg-subkeys.html
{
  programs.gpg = {
    enable = true;
    #package = pkgs.gnupg
    homedir = "${config.xdg.dataHome}/gnupg"; # Set GPGHOME to follow XDG Spec
    #mutableKeys = false;
    #mutableTrust = true;
    #publicKeys = [
    #{
    #  source = ./pubkeys.txt;
    #  text = "";        # Text of OpenPGP public key
    #  trust = "full";  # unknown | never | marginal | full | ultimate
    #}
    #];

    # See: man scdaemon(1)
    #scdaemonSettings = {
    #  disable-ccid = true;
    #};

    # See: man gpg(1)
    #settings = {
    #  no-comments = false;
    #};
  };

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    extraConfig = ''
    '';

    # TODO: Also set services.dbus.packages = [ pkgs.gcr ];
    #pinentryFlavor = "gnome3"; # gtk2 | gnome3 | curses | tty | qt | emacs

    #enableSshSupport = true;  # Whether to use the GnuPG key agent for SSH keys

    # Which GPG keys (by keygrip) to expose as SSH keys
    #sshKeys = [
    #  ""
    #];
  };
}
