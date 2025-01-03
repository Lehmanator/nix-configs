{ inputs, config, lib, pkgs, ... }:
{
  #sops.secrets.email = { }; # TODO: Read secret as text, not file.

  # --- Browser ------------------------
  # Configure Firefox to use Bitwarden extension
  programs.firefox.profiles.default.extensions = [pkgs.nur.repos.rycee.firefox-addons.bitwarden];

  # --- Shell --------------------------
  programs.rbw = {
    enable = true;
    settings = {
      lock_timeout = 3600;
      # TODO: Use secret
      email = "bitwarden@samlehman.dev";
      # email = config.sops.secrets.email.text; #"slehman@piwine.com";
      # base_url = "bitwarden.${config.networking.fqdn}";
      # identity_url = "identity.${config.networking.fqdn}";
    };
  };

  # TODO: https://github.com/kalsowerus/zsh-bitwarden
  # programs.zsh.plugins = [{ name="zsh-bitwarden"; src=pkgs.zsh-bitwarden; file="share/zsh-bitwarden.plugin.zsh";}];

  # --- Packages -----------------------
  # TODO: Better heuristic for graphical environment
  # TODO: Build package: https://github.com/Bitsteward/bitsteward
  # TODO: Conditionally pick b/w: pkgs.bitwarden & pkgs.goldwarden
  home.packages = ([
    pkgs.nur.repos.ambroisie.bw-pass
  ] ++ lib.optionals config.programs.gnome-shell.enable [
    pkgs.bitwarden
    pkgs.goldwarden
  ]);

}
