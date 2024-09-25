{ config, lib, pkgs
, user
, ...
}:
let
  # TODO Dynamically change `starship.character.vimcmd_*symbol`
  vim_show_abbr = true;
  vim_mode_full = true;
  vim_mode_caps = true;
  vim_mode_normalize_width = true;
in
{
  # See: https://starship.rs/config/
  programs.starship = {
    enable = true;
    enableTransience = true;

    settings = {
      # Module: Character to show last cmd status & input mode
      # TODO: Match Neovim statusline config.
      character = {
        #format = "$symbol";
        #error_symbol = "✖";
        error_symbol = "[Insert  ✖ ](bold red)";
        success_symbol = "[Insert  ❯ ](bold green)";
        vimcmd_symbol = "[Normal  ❯ ](bold green)";
        vimcmd_replace_one_symbol = "[replace ❯ ](bold purple)";
        vimcmd_replace_symbol = "[Replace ❯ ](bold purple)";
        vimcmd_visual_symbol = "[Visual  ❯ ](bold orange)";
      };

      # Module: Command Duration
      #cmd_duration = {
      #  #format = "took [$duration]($style)";
      #  min_time = "2_000";
      #  show_milliseconds = false;
      #  style = "bold yellow";
      #  show_notifications = false;
      #  min_time_to_notify = "45_000";
      #  notification_timeout = "45_000"; # time in milliseconds
      #};

      # Module: Directory
      directory = {
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        read_only = "🔒"; # TODO: Eyeball
        read_only_style = "red";
        truncation_symbol = "…/";
        #before_repo_root_style = "";
        truncation_length = 6;
        #repo_root_style = "";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        home_symbol = "~"; # TODO: House icon
        use_os_path_sep = true;
        substitutions = {
          "nix" = "";
          "etc" = "";
          ".config" = "";
          "/home/${user}/.local/repos" = "~";
          "/home/${user}/.local/repos-all" = "~";
        };
      };

      #palette = "testing";
      #palettes.testing = {
      #  blue = 21;
      #  mustard = "#af8700";
      #};

      follow_symlinks = true;

      fill = {
        symbol = "";
        style = "bold gray";
      };
    };
  };
}
