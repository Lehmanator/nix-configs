{ config, lib, pkgs, ... }:
{
  # TODO: Add custom repos (https://github.com/denisidoro/navi/blob/master/docs/cheatsheet_repositories.md)
  # TODO: Auto-update repos (https://github.com/denisidoro/navi/blob/master/docs/cheatsheet_repositories.md#auto-updating-repositories)
  # TODO: Vim syntax highlighting (https://github.com/denisidoro/navi/blob/master/docs/vim.md)
  # TODO: Tmux config (https://github.com/denisidoro/navi/blob/master/docs/tmux.md)
  # TODO: TiddlyWiki integration (https://bimlas.gitlab.io/tw5-navi-cheatsheet/)

  programs.navi = {
    enable = true;

    # https://github.com/denisidoro/navi/blob/master/docs/config_file.md
    # https://github.com/denisidoro/navi/blob/master/docs/config_file_example.yaml
    # navi info config-example
    settings = {
      cheats = {
        # TODO: Use system dirs
        # TODO: Instruct nixpkgs to include navi cheats (environment.pathsToLink)
        paths = [
          "${config.xdg.dataHome}/navi/cheats/"   # ".local/share/navi/cheats/"
          "${config.xdg.configHome}/navi/cheats/" # ".config/navi/cheats/"
        ];
      };

      # TODO: cheatsh client?
      client = {
        tealdeer = config.programs.tealdeer.enable;
      };

      #finder = {
      #  command = "fzf"; # Equiv opt: --finder
      #  #overrides = ""; # Equiv opt: --fzf-overrides
      #  #overrides_var = ""; # Equiv opt: --fzf-overrides-var
      #};

      #search = {
      #  tags = ["git" "!checkout"]; # Equiv: --tag-rules
      #};

      #shell = {
      #  command = "zsh";
      #  finder_command = "zsh";
      #};

      #style = {
      #  comment = {
      #    color = "blue";
      #    width_percentage = 42;
      #    min_width = 30;
      #  };
      #  snippet = {color = "white";};
      #  tag = {
      #    color = "cyan"; # Text color. Values: https://bit.ly/3gloNNI
      #    width_percentage = 25; # Column width relative to terminal window
      #    min_width = 20; # Minimum column width as number of chars.
      #  };
      #};
    };
  };
}
