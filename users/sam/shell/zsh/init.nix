{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [];

  programs.zsh = {
    #localVariables = {};

    #initExtraFirst = "";
    #initExtraBeforeCompInit = "";

    loginExtra = ''
      ${pkgs.neofetch}/bin/neofetch
    '';

    logoutExtra = ''
      echo "Goodbye, $USER!"
    '';

    initExtra = let

      zmods = ''
        autoload -Uz zargs zcp zln zmv
        zmodload zsh/attr
        zmodload zsh/computil
        zmodload zsh/mathfunc
        zmodload zsh/parameter
        zmodload zsh/nearcolor
        zmodload zsh/stat
        zmodload zsh/termcap
        zmodload zsh/terminfo
        zmodload zsh/watch
        zmodload zsh/zpty
      '';

      xterm-titles = ''
        autoload -Uz add-zsh-hook
        function xterm_title_precmd() {
          print -Pn -- '\e]2;%n@%m %~\a'
          [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
        }
        function xterm_title_preexec () {
          print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${"{(q)1}"}\a"
         [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${"{(q)1}"}\e\\"; }
        }
        if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
          add-zsh-hook -Uz precmd  xterm_title_precmd
          add-zsh-hook -Uz preexec xterm_title_preexec
        fi
      '';

      # Show directory contents when changing dirs
      cd-ls = ''
        function cd-ls() {
          ${pkgs.eza}/bin/eza \
            --almost-all \
            --icons \
            --git \
            --group-directories-first \
            --time-style=relative \
            --color=always
        }
      '';

      # Show git status of dir contents when changing dirs
      cd-git = ''
        function cd-git() {
          if [[ -d ".git" ]]; then
            git status
          fi
        }
      '';

    in ''
      ${zmods}
      ${cd-ls}
      #${cd-git}
      #${xterm-titles}
      chpwd_functions=(cd-ls)
    '';

  };
}
