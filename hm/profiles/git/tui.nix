{ config, lib, pkgs, ... }:
# TODO: Pick one
{
  # --- GitUI ---
  programs.gitui = {
    enable = true;
    #theme = ''
    #'';
  };

  # --- Lazygit ---
  # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
  programs.lazygit = {
    enable = true;
    settings = {
      gui.showIcons = true; # TODO: Pass global style attrset & conditionally set
    };
  };

    # TUI to drag & drop to rearrange commits
  programs.git.aliases.debase = lib.getExe pkgs.debase;
  home.packages = [pkgs.debase];
}
