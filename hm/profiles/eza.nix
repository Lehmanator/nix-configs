{lib, ...}: {
  # https://github.com/eza-community/eza
  # https://github.com/eza-community/eza-themes
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;

    # TODO: Use lib.cli.toGNUCommandLine {} attrs;
    extraOptions = [
      "--across"
      # "--classify"
      "--color=always"
      "--color-scale=all"
      "--color-scale-mode=gradiient"
      # "--git-ignore"
      "--group-directories-first"
      "--follow-symlinks"
      "--hyperlink"
      "--level=3"
      "--time-style=relative"

      # --- Long View ---
      # "--git-repos"
      "--git-repos-no-status"
      "--header"
      "--no-permissions"
      "--octal-permissions"
      "--smart-group"
      "--time=modified"
      "--total-size"
    ];
  };

  # TODO: Configure theme here
  # NOTE: `LS_COLORS` & `EZA_COLORS` take precedence over the theme file
  # xdg.configFile."eza/theme.yml".text = ''
  # '';
}
