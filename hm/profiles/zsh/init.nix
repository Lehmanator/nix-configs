{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    #localVariables = {};
    #initExtraBeforeCompInit = "";
    logoutExtra = ''
      echo "Goodbye, $USER!"
    '';

    initExtraFirst = ''
      autoload -Uz add-zsh-hook
    '';

    # TODO: Add file / line numbers of configs
    # TODO: Use lib.shell.ifProgram.withArgs' from ../../lib/shell/ifProgram.nix
    # TODO: Merge initExtra from ./default.nix
    initExtra = let
      # mkZshHook - Create zsh config to add and use zsh hooks
      #   TODO: Migrate existing zsh hooks
      #   TODO: Escape sequences for funcBody
      #   TODO: [[ "${cond}" ]] && add-zsh-hook 
      #   Hooks: chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name
      mkZshHook = { event ? "chpwd", funcName ? "zsh-hook-new-name", funcBody, description, cond ? "true", ... }: ''
        ${lib.optionalString description != null ("# | " + description)}
        function ${funcName}() {
          emulate -L zsh;
          ${funcBody};
        }
        ${lib.optionalString (cond != null) "[[ ${cond} ]] && "} add-zsh-hook ${event} ${funcName}
      '';
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

      # TODO: remove user@hostname when not remote SSH
      # TODO: set title to running command
      xterm-titles = let
        escapes = { title = ["\e]2;" "\a"]; title-screen = ["\e_" "\e\\"]; };
        set-title = msg: "print -Pn -- '\e]2;${msg}\a'";
        set-title-screen = msg: "print -Pn -- '\e_${msg}\e\\'"; # Allows colors
      in ''
        # | Set terminal & tab titles for many terminals
        # | precmd: Executes before each prompt
        # | precmd: Executes before command execution
        # |   print -Pn -- '\e]2;$2 [%n@%m:%~]%# ' && print -n -- "dollarsign{(q)1}\a"
        function xterm_title_precmd() {
          emulate -L zsh;
          [[ "$SSH_TTY" ]] && {
            print -Pn -- '\e]2;[%n@%m]%~\a' # && print -n -- "''${(q)1}\a"
          } || {
            print -Pn -- '\e]2;%~\a' # && print -n -- "''${(q)1}\a"
          }
        }
        function xterm_title_preexec() {
          [[ "$SSH_TTY" ]] && {
            print -Pn -- '\e]2;$2 [%n@%m:%~]\a' # && print -n -- "''${(q)1}\a"
          } || {
            print -Pn -- '\e]2;$2 [%~]\a' # && print -n -- "''${(q)1}\a"
          }
        }
        if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
          add-zsh-hook -Uz precmd  xterm_title_precmd
          add-zsh-hook -Uz preexec xterm_title_preexec
        fi
      '';
      # in ''
      #   function xterm_title_precmd() {
      #     [[ "$SSH_TTY" ]] && msg='${lib.head escapes.title}%n@%m:%~${lib.last escapes.title}' || msg='${lib.head escapes.title}%~${lib.last escapes.title}'
      #     print -Pn -- "$msg" 
      #     # [[ "$SSH_TTY" ]] && msg='%n@%m:%~' || msg='%~'
      #     # esc-beg='\e]2;'; esc-end='\a'
      #     # [[ "$TERM" == 'screen'* ]] && { esc-beg='\e_'; esc-end='\e\\' }
      #     # print -Pn -- "${lib.head escapes.title}$msg${lib.last escapes.title}"
      #     # print -Pn -- "$esc-beg$msg$esc-end"
      #     # print -Pn -- '\e_\005{B}%~\005{-}\e\\'
      #     # print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
      #   }
      #   function xterm_title_preexec () {
      #     [[ "$SSH_TTY" ]] && msg='${lib.head escapes.title}%n@%m:%~${lib.last escapes.title}' || msg='${lib.head escapes.title}%~${lib.last escapes.title}'
      #     [[ "$TERM" == 'screen'* ]] && {
      #       print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && \
      #       print -n -- "''${(q)1}\e\\";
      #     } || print -Pn -- "$msg" 
      #       # print -Pn -- '${set-title "%n@%m"}'
      #       # print -Pn -- "${lib.head escapes.title}$msg${lib.last escapes.title}"
      #   }
      # '';
      # TODO: ls -l for dirs with fewer than N files or subdirectories
      cd-ls = ''
        # | Show directory contents when changing dirs
        function cd-ls() {
          emulate -L zsh;
          max_lines=8
          if [[ "$(\eza -a --tree | wc -l)" -lt $max_lines ]]; then
            ${lscmd} --tree;
          elif [[ "$(\ls -al | wc -l)" -lt $max_lines ]]; then
            ${lscmd} -l;
          elif [[ "$(\ls -a | wc -l)" -lt $max_lines ]]; then
            ${lscmd};
          fi
        }
        add-zsh-hook chpwd cd-ls
      '';

      cd-git = ''
        # | Check if dir is git repo & run command if so
        repo_last=
        function cd-git() {
          emulate -L zsh
          repo_curr="$(git rev-parse --show-toplevel 2> /dev/null)"
          if [[ "$repo_curr" ]] && [[ "$repo_curr" != "$repo_last" ]]; then
            ${lib.getExe pkgs.onefetch}
            git log --oneline --color | head -"$((LINES / 6))"
            git status --short
          fi
          repo_last=$repo_curr
        }
        function cd-git-boxed() {
          cd-git $* | ${lib.getExe pkgs.boxes} --design ansi-rounded --align hlvt --indent box --size "$((COLUMNS-4))" --padding h1v0
        }
        add-zsh-hook -Uz chpwd cd-git-boxed
      '';
    in lib.concatLines ([
      zmods
      xterm-titles
    ] 
    ++ lib.optional config.programs.git.enable cd-git
    ++ [
      cd-ls
    ]);
  };
}
