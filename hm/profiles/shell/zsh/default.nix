{ config, lib, pkgs
, osConfig
, ...
}:
let
  inherit (lib) getExe concatLines concatStringsSep mapAttrs mapAttrsToList optionalString stringLength;
in
{
  imports = [ ../common
    ./alias.nix   ./completion.nix ./dirs.nix    ./highlight.nix
    ./history.nix ./init.nix       ./plugins.nix
  ];

  programs.zsh = {
    enable = true;

    # Relative to $HOME.
    # TODO: Generate from config.xdg.configHome
    dotDir = ".config/zsh";

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
      windowTitleFormat = "%n@%m: %s"; # TODO: Only user@host if remote host or other user
    };
    prezto.tmux = {
      autoStartLocal = true;
      autoStartRemote = true;
      defaultSessionName = "";
      itermIntegration = true;
    };

    #${pkgs.neofetch}/bin/neofetch
    loginExtra = ''
      ${getExe pkgs.fastfetch}
    '';

    initExtra = let
      # TODO: Dynamic path based on this file's path.
      prefix = ''
        # +-- programs.zsh.initExtra --------------------------------+
        # | File Location:                                           |
        # |   Repo: ./hm/profiles/shell/zsh/default.nix              |
        # +----------------------------------------------------------+
        # +-- add-zsh-hook --+
        autoload -Uz add-zsh-hook  # Attach functions to shell events
      '';
      suffix = ''
        # +-- /end: programs.zsh.initExtra --------------------------+
      '';

      mkDivider = sect: let chars = (70-5-4)-(stringLength sect); in "\n# +---[${sect}]${lib.strings.replicate chars "-"}+";
      addDivider = n: v: concatLines [(mkDivider n) v];
      mkSections = sections: concatLines ([prefix] ++ (mapAttrsToList addDivider sections) ++ [suffix]);

      # TODO: Impose ordering on items.
      # TODO: Add comments to start of snippet.
      # TODO: Separate this functionality into lib.
      in mkSections {
        cacheHome = ''mkdir -p "${config.xdg.cacheHome}/zsh"'';
        dirstack = ''
          # Maintain stack of recent directories for quick traversal
          if [[ -f "$DIRSTACKFILE" ]] && (( ''${#dirstack} == 0 )); then
            dirstack=("''${(@f)"$(< "$DIRSTACKFILE")"}")
            [[ -d "''${dirstack[1]}" ]] && cd -- "''${dirstack[1]}"
          fi
          chpwd_dirstack() { print -l -- "$PWD" "''${(u)dirstack[@]}" > "$DIRSTACKFILE" }
          add-zsh-hook -Uz chpwd chpwd_dirstack
          setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
          setopt PUSHD_IGNORE_DUPS     # Remove duplicate entries
          setopt PUSHD_MINUS           # Revert the +/- operators.
        '';
        run-help = ''
          # Show command's manpage using run-help (aliased to 'help')
          # Keybinds: '<ALT>-H' & '<ESC>-H'
          autoload -Uz run-help                      # Generic
          autoload -Uz run-help-ip run-help-openssl  # Command-specific
          ${optionalString config.programs.git.enable "autoload -Uz run-help-git"}
          ${optionalString (osConfig.security.sudo.enable || osConfig.security.sudo-rs.enable) "autoload -Uz run-help-sudo"}
        '';
        rehash-completions = ''
          # Refresh completions when PATH contents change
          zstyle ':completion:*' rehash true
        '';
        reset-fix-terminal-garbage = ''
          function reset_broken_terminal_test () { print '\e(0\e)B' }
          function reset_broken_terminal () {
            	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
          };
          add-zsh-hook -Uz precmd reset_broken_terminal
        '';
        git-repo-greeter-info = ''
          last_repository=
          check_directory_for_new_repository() {
            current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
            if [ "$current_repository" ] && \
               [ "$current_repository" != "$last_repository" ]; then
              ${getExe pkgs.onefetch}
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
        wordchars-improved = ''
          # Better word behavior when using <Alt>+<Backspace>
          #   Info: 'https://lgug2z.com/articles/sensible-wordchars-for-most-developers'
          #   Default: WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
          #   Current: WORDCHARS='*?[]~=&;!#$%^(){}<>'
          WORDCHARS='*?[]~=&;!#$%^(){}<>'
        '';
      };

    shellAliases.help = "run-help";
    localVariables = {
      DIRSTACKSIZE = 20;
      DIRSTACKFILE = "${config.xdg.cacheHome}/zsh/dirs";

      # Better word handling with: <alt> + <backspace>
      #  from: https://lgug2z.com/articles/sensible-wordchars-for-most-developers/
      #  default: WORDCHARS = "*?_-.[]~=/&;!#$%^(){}<>";
      # WORDCHARS = "*?[]~=&;!#$%^(){}<>";
    };
  };

  home.packages = [pkgs.zsh-nix-shell pkgs.any-nix-shell pkgs.nix-zsh-completions];

  #home.sessionVariables.ZDOTDIR = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}";
}
