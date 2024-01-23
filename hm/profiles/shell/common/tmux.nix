{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    #package = pkgs.tmux;
    aggressiveResize = lib.mkDefault false;
    baseIndex =
      lib.mkDefault 1; # Start index at 1 instead of 0 (easier num row)
    clock24 = lib.mkDefault false; # Use 12-hour clock
    customPaneNavigationAndResize = lib.mkDefault false;
    disableConfirmationPrompt = lib.mkDefault false;
    escapeTime = lib.mkDefault 500;
    historyLimit = lib.mkDefault 2000;
    keyMode = lib.mkDefault "vi";
    mouse = lib.mkDefault true; # TODO: Conflict w/ plugin: better-mouse-mode ?
    newSession = lib.mkDefault true;
    prefix =
      lib.mkDefault
      "C-a"; # Reachable bind. No conflict w/ zsh vi keybinds. Overrides shortcut. Original: C-b
    resizeAmount = lib.mkDefault 5;
    reverseSplit = lib.mkDefault false;
    secureSocket = lib.mkDefault true;
    sensibleOnTop = lib.mkDefault true;
    shell =
      lib.mkDefault
      "${pkgs.zsh}/bin/zsh"; # TODO: Set to user default shell in NixOS/home-manager
    #shortcut = lib.mkDefault "b"; # TODO: vs prefix????
    terminal =
      lib.mkDefault
      "screen-256color"; # $TERM variable (tmux default: "screen", term default: "xterm-256color")

    # TODO: Match status bar with Neovim / Zsh
    # TODO: Match color scheme with Neovim / Zsh
    # https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
    extraConfig = ''
      # Sane split keybinds
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Easy config reload
      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf

      # Fast pane switching
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
    '';

    # Termuxinator - Session Manager
    # https://github.com/tmuxinator/tmuxinator
    # TODO: Write config to ~/.config/tmuxinator (YAML)
    # TODO: Create custom session layouts
    tmuxinator.enable = lib.mkDefault true;

    # Tmuxp - Session manager
    # https://github.com/tmux-python/tmuxp
    # TODO: Compare w/ Tmuxinator
    tmuxp.enable = lib.mkDefault false;

    plugins = [
      pkgs.tmuxPlugins.battery
      pkgs.tmuxPlugins.better-mouse-mode
      pkgs.tmuxPlugins.catppuccin # Theme
      pkgs.tmuxPlugins.continuum # Continuous saving of tmux env.
      #pkgs.tmuxPlugins.copycat
      pkgs.tmuxPlugins.copy-toolkit # Various copy-mode tools
      pkgs.tmuxPlugins.cpu
      #pkgs.tmuxPlugins.ctrlw
      #pkgs.tmuxPlugins.extrakto # Fuzzy find your text w/ fzf instead of selecting by hand
      #pkgs.tmuxPlugins.fingers
      #pkgs.tmuxPlugins.fpp
      #pkgs.tmuxPlugins.fuzzback # Fuzzy search for terminal scrollback
      pkgs.tmuxPlugins.fzf-tmux-url
      #pkgs.tmuxPlugins.jump # Vimium/Easymotion-like navigation for tmux
      #pkgs.tmuxPlugins.logging
      pkgs.tmuxPlugins.mode-indicator # Plugin to display prompt indicating curr active tmux mode
      pkgs.tmuxPlugins.net-speed
      pkgs.tmuxPlugins.open
      #pkgs.tmuxPlugins.online-status
      #pkgs.tmuxPlugins.pain-control
      #pkgs.tmuxPlugins.power-theme
      pkgs.tmuxPlugins.prefix-highlight
      #pkgs.tmuxPlugins.resurrect # Restore tmux environment after system restart
      #pkgs.tmuxPlugins.sensible
      #pkgs.tmuxPlugins.sessionist
      #pkgs.tmuxPlugins.sidebar
      #pkgs.tmuxPlugins.sysstat
      pkgs.tmuxPlugins.tmux-thumbs # Rust tmux-fingers for copy/paste w/ vimium/vimperator-like hints
      pkgs.tmuxPlugins.tmux-fzf # Use fzf to manage tmux work env.
      pkgs.tmuxPlugins.urlview
      pkgs.tmuxPlugins.vim-tmux-focus-events
      #pkgs.tmuxPlugins.weather
      pkgs.tmuxPlugins.yank

      #{
      #  plugin = pkgs.tmuxPlugins.continuum;
      #  extraConfig = ''
      #    set -g @continuum-restore 'on'
      #    set -g @continuum-save-interval '60' # minutes
      #  '';
      #}
    ];
  };
}
