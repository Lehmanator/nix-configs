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
      pkgs.mdctags
    ];
    languages = {
      language-server = {
        markdown-oxide.command = lib.getExe pkgs.markdown-oxide;
        marksman = {
          command = lib.getExe pkgs.marksman;
          args = ["server"];
        };
      };
      language = [{
        name = "markdown";
        auto-format = true;
        formatter = {
          command = lib.getExe pkgs.comrak;
          args = ["--inplace" "--gfm"];
        };
      }];
    };
  };

  # --- Neovim ---
  # programs.neovim = {
  # };

  # --- VSCode ---
  # https://marketplace.visualstudio.com/items?itemName=FelixZeller.markdown-oxide
  # vscode-extensions.shd101wyy.markdown-preview-enhanced

  # --- Zed ------
  programs.zed-editor = {
    # NOTE: Only available in unstable (after 24.11)
    # extraPackages = [ pkgs.markdown-oxide ];
    extensions = ["markdown-oxide"];
  };

  home.packages = [
    pkgs.mdcat     # cat for Markdown
    pkgs.mdctags   # Markdown file tags
    pkgs.md-tui    # Markdown TUI renderer
    pkgs.mdr       # Markdown Renderer
    pkgs.mdsh      # Markdown shell pre-processor
    pkgs.papeer    # Convert websites into ebooks & Markdown
    pkgs.mdbook    # Create books from Markdown.
    pkgs.md2pdf    # Markdown to PDF conversion tool
    pkgs.glow      # Fancy Markdown renderer CLI
    pkgs.ronn      # Markdown-based tool for building manpages
    pkgs.marked-man # Markdown to roff
    pkgs.mandown    # Markdown to groff (manpage) converter
    pkgs.comrak     # Markdown formatter & HTML converter
  ];
}
