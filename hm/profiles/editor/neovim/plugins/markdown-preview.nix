{ inputs
, pkgs
, ...
}:
{
  programs.nixvim.plugins.markdown-preview = {
    previewOptions = {
      content_editable = true;
    };
    #theme = "dark";
  };
}

