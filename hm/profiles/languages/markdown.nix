{ config, lib, pkgs, ... }:
{
  # https://oxide.md/v0/Guides/Getting+started+with+Markdown+Oxide+Version+0
  # ~/.config/moxide/settings.toml

  # --- Helix ---
  programs.helix = {
    extraPackages = [
      pkgs.markdown-oxide
      pkgs.marksman
      pkgs.mdformat
    ];
    languages = {
      language-server = {
        markdown-oxide.command = lib.getExe pkgs.markdown-oxide;
        marksman.command = "${lib.getExe pkgs.marksman} server";
      };
      language = [{
        name = "markdown";
        auto-format = true;
        formatter.command = lib.getExe pkgs.mdformat;
      }];
    };
  };

  # --- Neovim ---
  # programs.neovim = {
  # };

  # --- VSCode ---
  # https://marketplace.visualstudio.com/items?itemName=FelixZeller.markdown-oxide

  # --- Zed ---
  programs.zed-editor = {
    # NOTE: Only available in unstable (after 24.11)
    # extraPackages = [ pkgs.markdown-oxide ];
    extensions = ["markdown-oxide"];
  };
}
