{
  inputs,
  config,
  ...
}: {
  # --- QuickFix ---------------------
  # Better QuickFix window with FZF and previews
  plugins.nvim-bqf = {
    enable = true;
    autoResizeHeight = true;
    extraOptions = {};
    magicWindow = true;
    preview = {
      autoPreview = true;
      bufLabel = true;
      showTitle = true;
      winHeight = 15;
      winVheight = 15;
      wrap = false;
    };
    #borderChars = {};
  };
}
