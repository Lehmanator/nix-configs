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
    customPaneNavigationAndResize = lib.mkDefault true;
    disableConfirmationPrompt = lib.mkDefault true;
    escapeTime = lib.mkDefault 100;
    historyLimit = lib.mkDefault 20000; # TODO: Set to shell limit
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
      "tmux-256color"; # $TERM variable (tmux default: "screen", term default: "xterm-256color")

    # TODO: Match status bar with Neovim / Zsh
    # TODO: Match color scheme with Neovim / Zsh
    # TODO: Escape tmux command mode with <ESC> (like vim)
    # TODO: Match tmux prefix key with Vim leader key
    # TODO: Status line per-pane?
    # TODO: Fix Vim escape key delay w/ tmux
    # TODO: Fix CTRL-SHIFT-MINUS keybind getting gobbled by tmux
    # https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
    # https://dev.to/iggredible/useful-tmux-configuration-examples-k3g
    # https://thevaluable.dev/tmux-config-mouseless/
    # https://github.com/tmux/tmux/wiki/Getting-Started
    extraConfig = ''

      # --- Configuration ---
      # Easy config reload
      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf

      # --- Status Lines ---
      set -g pane-border-status "top"

      # --- Terminal Integration ---
      set -g set-titles on
      set -g set-titles-string '#{pane_title}'
      set -as terminal-features ",gnome*:RGB"
      set -g display-panes-time 2000

      # --- Pane Management & Navigation -------------------
      # --- Splitting ---
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # --- Switching ---
      # Note: Set by customPaneNavigationAndResize
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # --- Resizing ---

      # --- Moving / Swapping Current Window ---
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1

      # Rename window
      # New Window

      # Mark Switching (Mark: Prefix-m, Jump: ` (backtick))
      bind \` switch-client -t'{marked}'
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

    plugins = with pkgs.tmuxPlugins; [
      battery
      better-mouse-mode
      #copycat
      copy-toolkit # Various copy-mode tools
      cpu
      #ctrlw
      #extrakto # Fuzzy find your text w/ fzf instead of selecting by hand
      #fingers # Highlight stuff for quick copy-paste
      #fpp
      #fuzzback # Fuzzy search for terminal scrollback
      fzf-tmux-url
      #jump # Vimium/Easymotion-like navigation for tmux
      #logging
      mode-indicator # Plugin to display prompt indicating curr active tmux mode
      net-speed
      open
      #online-status
      #pain-control
      #power-theme
      prefix-highlight
      #resurrect # Restore tmux environment after system restart
      #sensible
      #sessionist
      #sidebar
      #sysstat
      tmux-thumbs # Rust tmux-fingers for copy/paste w/ vimium/vimperator-like hints
      tmux-fzf # Use fzf to manage tmux work env.
      urlview
      vim-tmux-focus-events
      #weather
      yank

      {
        # https://github.com/catppuccin/tmux
        plugin = catppuccin; # Theme
        extraConfig = ''
          set -g @catppuccin_status_left_separator ""
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_connect_separator "yes"
          set -g @catppuccin_status_fill "all"

          set -g @catppuccin_window_status_icon_enable "yes"

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator ": "
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_fill "all"

          set -g @catppuccin_status_modules_right "application session"
          set -g @catppuccin_status_modules_left "directory"
          set -g @catppuccin_pane_default_text "#{b:pane_current_path}"
          set -g @catppuccin_pane_status_enabled "yes"
          set -g @catppuccin_pane_border_status "top"
          set -g @catppuccin_pane_left_separator ""
          set -g @catppuccin_pane_right_separator ""
          set -g @catppuccin_pane_middle_separator "█ "
          set -g @catppuccin_pane_number_position "left"
          set -g @catppuccin_pane_default_fill "all"

        '';
      }
      {
        # Continuous saving of tmux env.
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
  };

  # Use floating popup window for tmux commands
  #home.sessionVariables.FZF_TMUX_OPTS = "-p";
}
