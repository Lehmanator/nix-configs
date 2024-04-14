{
pkgs
, ...
}:
{
  plugins.markdown-preview = {
    previewOptions = {
      content_editable = true;
    };
    #theme = "dark";
  };
}

