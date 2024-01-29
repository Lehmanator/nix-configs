{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
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
    defaultKeymap = "viins"; # TODO: lib.mkIf config.keymap=="vim";
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
      autoTitle = true; # Issue w/ Blackbox terminal or all iTerm-based?
      #multiplexerTitleFormat = "%s";        # TODO: Test tmux
      tabTitleFormat = "%m: %s"; # TODO: Fix tab titles missing
      windowTitleFormat = "%n@%m: %s"; # TODO: Only user@host if remote host or other user
    };
    #prezto.tmux = {
    #  autoStartLocal = true;
    #  autoStartRemote = true;
    #  defaultSessionName = "";
    #  itermIntegration = true;
    #};

    loginExtra = ''
      ${pkgs.neofetch}/bin/neofetch
    '';

    initExtra = let
      prefix = ''
        autoload -Uz add-zsh-hook run-help run-help-openssl
      '';
      dirstack = ''
        if [[ -f "$DIRSTACKFILE" ]] && (( \$\{#dirstack} == 0 )); then
          dirstack=("\$\{(@f)"$(< "$DIRSTACKFILE")"}")
          [[ -d "\$\{dirstack[1]}" ]] && cd -- "\$\{dirstack[1]}"
        fi
        chpwd_dirstack() {
          print -l -- "$PWD" "\$\{(u)dirstack[@]}" > "$DIRSTACKFILE"
        }
        add-zsh-hook -Uz chpwd chpwd_dirstack
        setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
        ## Remove duplicate entries
        setopt PUSHD_IGNORE_DUPS
        ## This reverts the +/- operators.
        setopt PUSHD_MINUS
      '';
      run-help = ''
        # run-help command & shortcuts <Alt>-H & <Esc>-H
        autoload -Uz run-help
        autoload -Uz run-help-ip run-help-openssl
        ${lib.optionalString config.programs.git.enable
          "autoload -Uz run-help-git"}
        ${lib.optionalString
          (osConfig.security.sudo.enable || osConfig.security.sudo-rs.enable)
          "autoload -Uz run-help-sudo"}

      '';
      rehash = ''
        zstyle ':completion:*' rehash true
      '';
      reset = ''
        autoload -Uz add-zsh-hook
        function reset_broken_terminal () {
          	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
        };
        function reset_broken_terminal_test () { print '\e(0\e)B' }
        add-zsh-hook -Uz precmd reset_broken_terminal
      '';
    in
      prefix + dirstack + rehash + reset + run-help + "\n";

    shellAliases.help = "run-help";
    localVariables = {
      DIRSTACKSIZE = 20;
      DIRSTACKFILE = "${config.xdg.cacheHome}/zsh/dirs";
    };
  };

  home.packages = [pkgs.zsh-nix-shell pkgs.any-nix-shell pkgs.nix-zsh-completions];

  #home.sessionVariables.ZDOTDIR = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}";
}
