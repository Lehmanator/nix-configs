{ inputs
, config
, lib
, pkgs
, user
, bindings ? "vim"
, ...
}:
{
  imports = [ ];
  # TODO: Determine base source of truth for keybinds            (i.e. Vim keybinds set ZSH, readline, etc.)
  # TODO: Determine base source of truth for completion behavior (i.e. Vim wildmenu completion mimicks ZSH, readline)
  #
  # TODO: Declare highlights & delimiter themes in global user style preference & pass in profile imports for Vim, ZSH, readline, shell utils, etc.
  # - Prompt style / segment delimiting chars / segment order
  # - colorscheme
  #
  # TODO: Programmatically match all program keybinds with those of the source of truth
  # - Vim keybind base
  #
  # TODO: Consider files per-keymap-type to set keybind configs across all programs instead of per-program configs for all behavior. (../<category>/<program>.nix -> ../<
  # - ../keybinds/vim.nix   {programs.readline.bindings={..}; programs.zsh.completion.strategy=[..]; programs.fzf.keybinds={..};}
  # - ../keybinds/emacs.nix {programs.readline.bindings={..}; programs.zsh.completion.strategy=[..]; programs.fzf.keybinds={..};}
  # - ../completion/<PRESET>.nix {programs.readline={..}; programs.zsh.completion.strategy=[..]; programs.fzf.keybinds={..};}
  # - ../prompt/square.nix {...}
  # - ../prompt/round.nix  {...}
  # - ../highlight/<colorscheme>.nix {programs.bat.theme={..}; ...}

  # See: https://www.man7.org/linux/man-pages/man3/readline.3.html
  programs.readline = {
    enable = true;
    bindings = { };
    includeSystemConfig = true;
    variables = {
      editing-mode = if bindings == "emacs" then bindings else "vi";
      bell-style = "visible";
      blink-matching-paren = true;
      colored-stats = true;
      colored-completion-prefix = true;
      show-mode-in-prompt = true;
      expand-tilde = true;
      menu-complete-display-prefix = true;
      show-all-if-ambiguous = true;
      skip-completed-text = true;
    };
    #extraConfig = ''
    #  $include ${config.xdg.configFile.inputrc-completion.target}
    #  $include ${config.xdg.configFile.inputrc-highlight.target}
    #  $include ${config.xdg.configFile.inputrc-history.target}
    #  $include ${config.xdg.configFile.inputrc-keybinds.target}
    #  $include ${config.xdg.configFile.inputrc-prompt.target}
    #'';
  };

  # TODO: Can make .inputrc respect XDG Base Directories spec?
  # TODO: If lots of `extraConfig`, split into files in `XDG_CONFIG_HOME`
  #home.xdg.configFile = {
  #  inputrc-completion = {
  #    target = "${config.xdg.configHome}/inputrc/completion.rc";
  #    text = ''
  #    '';
  #  };
  #  inputrc-highlight = {
  #    target = "${config.xdg.configHome}/inputrc/highlight.rc";
  #    text = ''
  #    '';
  #  };
  #  inputrc-keybinds = {
  #    target = "${config.xdg.configHome}/inputrc/keybinds.rc";
  #    text = ''
  #    '';
  #  };
  #  inputrc-history = {
  #    target = "${config.xdg.configHome}/inputrc/history.rc";
  #    text = ''
  #    '';
  #  };
  #  inputrc-prompt = {
  #    target = "${config.xdg.configHome}/inputrc/prompt.rc";
  #    text = ''
  #    '';
  #  };
  #};
}
