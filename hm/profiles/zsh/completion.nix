{ config, lib, pkgs, ... }:
let
  setopt-options = {};
  # TODO: Load by getting all attrs (+ filter unwanted/disabled)
  completion-snippets = {
    # Reorder completion groups
    group-order = "zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands";
  };
in {
  programs.zsh = {
    initExtra = let
      cache-completions = ''
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/.zcompcache"
      '';

      # Colorize completion list
      # Note: Needs module: zsh/complist
      # Docs: man zshmodules
      colorize-list = ''
        zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      '';

      # Completion menu
      completion-list = "zmodload zsh/complist";

      # Show details of file completions
      file-list-details = "zstyle ':completion:*' file-list all";

      # Sort files by recently-modified
      # NOTE: Adding 'reverse' reverses order
      # NOTE: Adding 'follow' uses timestamps from symlink targets
      # TODO: Access timestamps broken by noatime/relatime BTRFS option?
      # Sort fields:
      # - size - Ordered by file size
      # - links - Ordered by number of links pointing at files
      # - modification/date/time - Ordered by date of modification
      # - access - Ordered by time of access
      # - change/inode - Ordered by time of change
      file-sort = "zstyle ':completion:*' file-sort change reverse follow";

      # Group completions by type
      # TODO: Need single quotes?
      group-type = "zstyle ':completion:*' group-name ''";

      # Fallback match case-insensitive & partial words
      # NOTE: see `man zshcompiwid` & search 'completion matching control'
      # 1. Case-sensitive
      # 2. Case-insensitive
      # 3. Partial words
      matcher-list = "zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'";

      # Complete options for cd, chdir, pushd
      # See: https://thevaluable.dev/zsh-install-configure-mouseless
      option-complete = "zstyle ':completion:*' complete-options true";

      # Don't expand '//' to '/*/'
      squeeze-slashes = "zstyle ':completion:*' squeeze-slashes true";

      # Use fzf-tab completion
      zsh-fzf-tab = "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh";
    in ''
      # --- programs.zsh.initExtra ---
    ''
    + lib.optionalString config.programs.fzf.enable zsh-fzf-tab
    ;
  };
}
