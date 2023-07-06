{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--previeww 'tree -C {} | head -200'" ];
    #colors = { };
    #defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    #historyWidgetOptions = [ ]; #--sort --exact
  };

}
