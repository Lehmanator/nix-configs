{ inputs, config, lib, pkgs, ... }:
{
  # Good overview of GPG:
  # - https://rgoulter.com/blog/posts/programming/2022-06-10-a-visual-explanation-of-gpg-subkeys.html
  programs.gpg = {
    settings = {
      default-key = "DC19 62D6 560F F66B B16F  99E0 C47C 1462 4041 0561";
    };
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
  # Which GPG keys (by keygrip) to expose as SSH keys
  services.gpg-agent.sshKeys = [
    #""
  ];
}
