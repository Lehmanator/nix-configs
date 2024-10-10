{ inputs
, config, lib, pkgs
, ...
}:
{
  programs.zsh = {
    #localVariables = {};
    #initExtraFirst = "";
    #initExtraBeforeCompInit = "";
    logoutExtra = ''
      echo "Goodbye, $USER!"
    '';

    # TODO: Add file / line numbers of configs
    # TODO: Use lib.shell.ifProgram.withArgs' from ../../lib/shell/ifProgram.nix
    # TODO: Merge initExtra from ./default.nix
    initExtra = let
      mkProgram = prog: args: let
        bin = 
          if config.programs ? prog && config.programs.${prog} ? "package" 
          then lib.getExe config.programs.${prog}.package
          else prog
        ;
      in bin + " " + (lib.concatStringsSep " " (lib.cli.toGNUCommandLine {
            # optionValueSeparator = "=";
            mkOption = k: v: if v == null then [] else ["${if builtins.stringLength k == 1 then "-${k}" else "--${k}"}=${v}" ];
          } args
        )
      );
      lscmd = 
        if config.programs.eza.enable then mkProgram "eza" {
          group-directories-first = true;
          git        = config.programs.git.enable;
          icons      = true;  # TODO: lib.mkIf config.fonts.  ; # If using NerdFont 
          almost-all = true;
          color      = "always";
          time-style = "relative";
        }
        else if config.programs.lsd.enable then mkProgram "lsd" {
          # lsd args
        }
        else if config.programs.pls.enable then mkProgram "pls" {
          # pls args
        }
        else mkProgram "ls" {
          # coreutils ls args
        }
      ;
      zmods = ''
        # --- Load Zsh modules ---
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

      # TODO: Check escaped "${"{(q)1}"}\e\\";
      xterm-titles = ''
        # --- Set terminal title ---
        autoload -Uz add-zsh-hook
        function xterm_title_precmd() {
          print -Pn -- '\e]2;%n@%m %~\a'
          [[ "$TERM" == 'screen'* ]] && \
            print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
        }
        function xterm_title_preexec () {
          print -Pn -- '\e]2;%n@%m %~ %# ' && \
          print -n -- "''${"{(q)1}"}\a"
          [[ "$TERM" == 'screen'* ]] && {
            print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && \
            print -n -- "''${"{(q)1}"}\e\\";
          }
        }
        if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
          add-zsh-hook -Uz precmd  xterm_title_precmd
          add-zsh-hook -Uz preexec xterm_title_preexec
        fi
      '';

      cd-ls = ''
        # --- Show directory contents when changing dirs ---
        function cd-ls() { ${lscmd} }
        chpwd_functions+=(cd-ls)
      '';

      # TODO: Use onefetch
      cd-git = ''
        # --- Show git status of dir contents when changing dirs ---
        function cd-git-status() { [[ -d ".git" ]] && git status }
        chpwd_functions+=(cd-git-status)
      '';

    in lib.concatLines ([
      zmods
      cd-ls
      xterm-titles
    ] 
    ++ lib.optional config.programs.git.enable cd-git
    );

  };
}
