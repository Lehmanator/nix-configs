{ osConfig, config, lib, pkgs, ... }: {
  imports = [
    ./alias.nix
    ./completion.nix
    ./dirs.nix
    ./highlight.nix
    ./history.nix
    ./init.nix
    #./keymaps.nix
    #./plugins
    ./prezto.nix
    #./vte.nix
  ]
  # Originally in ./plugins/default.nix
  ++ builtins.map (n: "${./plugins}/${n}")
    (builtins.attrNames (builtins.readDir ./plugins));

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh"; # Relative to $HOME.

    # --- Keybindings ---
    # TODO: Create homeManagerModule for global user keymap setting
    defaultKeymap = "viins"; # TODO: lib.mkIf config.keymap=="vim";
    #prezto.editor.keymap = "vi";

    # --- Completion ---
    enableAutosuggestions = true;
    enableCompletion = false;
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
      windowTitleFormat =
        "%n@%m: %s"; # TODO: Only user@host if remote host or other user
    };
    prezto.tmux = {
      autoStartLocal = true;
      autoStartRemote = true;
      defaultSessionName = "";
      itermIntegration = true;
    };

    #${pkgs.neofetch}/bin/neofetch
    loginExtra = ''
      ${lib.getExe pkgs.fastfetch}
    '';

    initExtra =
      let
        prefix = ''
          # +-- programs.zsh.initExtra --------------------------------+
          # |                                                          |
          # +----------------------------------------------------------+
          # +-- add-zsh-hook --+
          autoload -Uz add-zsh-hook  # Attach functions to shell events
        '';
        cacheHome = ''
          mkdir -p "${config.xdg.cacheHome}/zsh"
        '';
        dirstack = ''
          # +-- dirstack --+
          # Maintain stack of recent directories for quick traversal
          if [[ -f "$DIRSTACKFILE" ]] && (( ''${#dirstack} == 0 )); then
            dirstack=("''${(@f)"$(< "$DIRSTACKFILE")"}")
            [[ -d "''${dirstack[1]}" ]] && cd -- "''${dirstack[1]}"
          fi
          chpwd_dirstack() {
            print -l -- "$PWD" "''${(u)dirstack[@]}" > "$DIRSTACKFILE"
          }
          add-zsh-hook -Uz chpwd chpwd_dirstack
          setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
          setopt PUSHD_IGNORE_DUPS     # Remove duplicate entries
          setopt PUSHD_MINUS           # Revert the +/- operators.
        '';
        run-help = ''
          # --- run-help -----------------------------------------------
          # Show command's manpage using run-help (aliased to 'help')
          # Keybinds: '<ALT>-H' & '<ESC>-H'
          autoload -Uz run-help                      # Generic
          autoload -Uz run-help-ip run-help-openssl  # Command-specific
          ${lib.optionalString config.programs.git.enable
          "autoload -Uz run-help-git"}
          ${lib.optionalString
          (osConfig.security.sudo.enable || osConfig.security.sudo-rs.enable)
          "autoload -Uz run-help-sudo"}
        '';
        rehash = ''
          # --- rehash completions -------------------------------------
          # Refresh completions when PATH contents change
          zstyle ':completion:*' rehash true
        '';
        reset = ''
          # --- fix terminal garbage -----------------------------------
          function reset_broken_terminal_test () { print '\e(0\e)B' }
          function reset_broken_terminal () {
            	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
          };
          add-zsh-hook -Uz precmd reset_broken_terminal
        '';
        repo-info = ''
          # --- git repository greeter ---
          last_repository=
          check_directory_for_new_repository() {
            current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
            if [ "$current_repository" ] && \
               [ "$current_repository" != "$last_repository" ]; then
              ${lib.getExe pkgs.onefetch}
            fi
            last_repository=$current_repository
          }
          add-zsh-hook -Uz chpwd check_directory_for_new_repository
          #cd() {
          #  builtin cd "$@"
          #  check_directory_for_new_repository
          #}

          # optional, greet also when opening shell directly in repository directory
          # adds time to startup
          #check_directory_for_new_repository
        '';
      in
      lib.strings.concatStringsSep "\n" [
        prefix
        cacheHome
        dirstack
        rehash
        reset
        run-help
        repo-info
      ];
    #prefix + dirstack + rehash + reset + run-help + "\n";

    shellAliases.help = "run-help";
    localVariables = {
      DIRSTACKSIZE = 20;
      DIRSTACKFILE = "${config.xdg.cacheHome}/zsh/dirs";
    };
  };

  home.packages =
    [ pkgs.zsh-nix-shell pkgs.any-nix-shell pkgs.nix-zsh-completions ];

  #home.sessionVariables.ZDOTDIR = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}";
}
