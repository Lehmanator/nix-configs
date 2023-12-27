{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.zsh = {

    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      extended = true;
      ignoreAllDups = false;
      ignoreDups = false;
      ignoreSpace = true;
      ignorePatterns = [
        "rm -r *"
        "rm -rf *"
        "echo * > *key*"
        "echo * > *secret*"
        "echo \"*\" > *key*"
        "echo \"*\" > *secret*"
        "echo '*' > *key*"
        "echo '*' > *secret*"
        # TODO: LUKS commands w/ key passed in CLI
      ];
      save = 100000;
      share = true;
    };

    historySubstringSearch = {
      enable = true;
      #searchDownKey = "^[[B";
      #searchUpKey = "^[[A";
    };

  };

}
