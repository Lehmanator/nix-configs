{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.markdown-preview = {
    settings = {
      preview_options = {content_editable = true;};
      #theme = "dark";
    };
  };
}
