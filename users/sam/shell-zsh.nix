{
  self,
  inputs,
  system,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
    ./shell.nix
  ];

  programs.zsh.enable = true;

  # --- Keybindings ---
  programs.zsh.defaultKeymap = "viins";

  # --- Directories ---
  programs.zsh.autocd = true;
  #programs.zsh.cdpath = lib. config.programs.zsh.dirHashes  # TODO: Find lib to turn attrset values into list
  programs.zsh.dirHashes = {
    # TODO: Use XDG User Dirs if graphical environment
    code = "$HOME/Code";
    dl   = "$HOME/Downloads";
    docs = "$HOME/Documents";
    game = "$HOME/Games";
    note = "$HOME/Notes";
    vids = "$HOME/Videos";

    cache  = "$XDG_CACHE_HOME";
    config = "$XDG_CONFIG_HOME";
    data   = "$XDG_DATA_HOME";
    state  = "$XDG_STATE_HOME";

    nix    = "$XDG_CONFIG_HOME/nixos";

    gpg    = "$GNUPGHOME";
    ssh    = "$HOME/.ssh";

    bin    = "$HOME/.local/bin";
    repos  = "$HOME/.local/repos";
    shh    = "$HOME/.local/secrets";
  };

  # --- Completion ---
  programs.zsh.enableCompletion = true;

  # --- Colors ---
  programs.zsh.enableSyntaxHighlighting = true;

  # --- Integration ---
  programs.zsh.enableVteIntegration = true;

  # --- History ---
  programs.zsh.history.extended = true;
  programs.zsh.history.ignorePatterns = [ 
    "rm -r *"          "rm -rf *"
    'echo * > *key*'   'echo * > *secret*'
    'echo "*" > *key*' 'echo "*" > *secret*'
    "echo '*' > *key*" "echo '*' > *secret*"
    # TODO: LUKS commands w/ key passed in CLI
  ]
  programs.zsh.history.ignoreSpace = true;
  programs.zsh.historySubstringSearch.enable = true;

  # --- Aliases ---
  programs.zsh.shellGlobalAliases = {
    G = "| rg";
  };
}
