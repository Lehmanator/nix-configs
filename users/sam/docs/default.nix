{ inputs, self
, config, lib, pkgs
, ...
}:
# --- Documentation --------
{
  imports = [
    #./manpages.nix
    #./tldr.nix
    #./news.nix
  ];

  home.extraOutputsToInstall = [ "doc" "info" "devdoc" ];

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };

  news.display = "show";  # silent | notify | show

  # See: https://dbrgn.github.io/tealdeer/config.html
  programs.tealdeer = {
    enable = true;
    settings = {
      display.compact = true;
      display.use_pager = false;
      updates.auto_update = true;
      #style.example_variable.foreground = "cyan";
    };
  };

}
