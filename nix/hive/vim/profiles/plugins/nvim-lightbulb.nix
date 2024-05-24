{
  config,
  lib,
  pkgs,
  ...
}: {
  # --- nvim-lightbulb: Code Actions ---
  plugins.nvim-lightbulb = {
    enable = true;
    autocmd = {
      enabled = lib.mkDefault true;
      events = ["CursorHold" "CursorHoldI"];
      pattern = ["*"];
    };
    float.enabled = lib.mkDefault true;
    statusText.enabled = lib.mkDefault true;
    virtualText = {
      enabled = lib.mkDefault true;
      hlMode = "replace"; # replace | combine | blend
    };
  };
}
