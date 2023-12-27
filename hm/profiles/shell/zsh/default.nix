{ self, inputs
, user
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../common
    ./alias.nix
    #./completion.nix
    ./dirs.nix
    ./highlight.nix
    ./history.nix
    ./init.nix
    #./keymaps.nix
    ./plugins.nix
    #./vte.nix
  ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh"; # Relative to $HOME.

    # --- Keybindings ---
    # TODO: Create homeManagerModule for global user keymap setting
    defaultKeymap = "viins";       # TODO: lib.mkIf config.keymap=="vim";
    #prezto.editor.keymap = "vi";

    # --- Completion ---
    enableAutosuggestions = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U compinit && compinit
      autoload -U bashcompinit && bashcompinit
    '';
    prezto.editor.dotExpansion = true; # Auto expand ... to ../..

    # --- Integration ---
    enableVteIntegration = true;
    prezto.terminal = {
      autoTitle = true;                      # Issue w/ Blackbox terminal or all iTerm-based?
      #multiplexerTitleFormat = "%s";        # TODO: Test tmux
               tabTitleFormat = "%m: %s";    # TODO: Fix tab titles missing
            windowTitleFormat = "%n@%m: %s"; # TODO: Only user@host if remote host or other user
    };
    #prezto.tmux = {
    #  autoStartLocal = true;
    #  autoStartRemote = true;
    #  defaultSessionName = "";
    #  itermIntegration = true;
    #};

  };

  home.packages = [
    pkgs.zsh-nix-shell
    pkgs.any-nix-shell
    pkgs.nix-zsh-completions
  ];

  #home.sessionVariables.ZDOTDIR = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}";

}
