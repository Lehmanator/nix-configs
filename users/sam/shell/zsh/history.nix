{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  # --- History ---
  programs.zsh = {
    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      extended = true;
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
      share = true;
      ignoreSpace = true;
    };
    historySubstringSearch.enable = true;
  };

}
