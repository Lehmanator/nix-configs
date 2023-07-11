
{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- GitUI ---
  programs.gitui = {
    enable = true;
    #theme = ''
    #'';
  };

  # --- Lazygit ---
  # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
  programs.lazygit = {
    enable = false;
    settings = {
      gui.showIcons = true;  # TODO: Pass global style attrset & conditionally set
    };
  };

}
