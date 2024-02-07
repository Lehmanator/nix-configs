{pkgs, ...}:
# Source: https://github.com/marlonrichert/zsh-autocomplete
# Last Updated: 2024/02/06
#
# Notes:
# - Tabbing only shows aliases for some reason
# - I like the type-ahead, but cant configure tabbing/completion behavior
# - TODO: Look at the source & see if I can copy the type-ahead behavior, but set my own completion behavior.
{
  programs.zsh = {
    # Note: Must disable compinit calls bc plugin calls it instead.
    #       Will break if called in config first.
    # Orig: "autoload -U compinit && compinit";
    # TODO: Disable compinit call AND autoload or just call?
    completionInit = "autoload -U compinit";
    plugins = [
      {
        name = "zsh-autocomplete";
        file = "zsh-autocomplete.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "c7b65508fd3a016dc9cdb410af9ee7806b3f9be1";
          hash = "sha256-u2BnkHZOSGVhcJvhGwHBdeAOVdszye7QZ324xinbELE=";
        };
      }
    ];
  };
}
