{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;

    # See: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
    arguments = [
      # Follow symlinks
      "--follow"

      # Show hidden files (still ignores .gitignore files)
      "--hidden"

      # Enable hyperlinks
      "--hyperlink-format default" # for VSCode --hyperlink-format vscode

      # Prevent super long lines
      "--max-columns=150"

      # Case-insensitive until you search uppercase
      "--smart-case"

      # --- colorize output ---
      "--colors=line:style:bold" # Bold line numbers

      # --- glob patterns ---
      "--glob=!.git/*" # Ignore .git dirs

      # --- preprocessors ---
      # Run non-text files through preprocessor command (--pre <commandFile> --pre-glob='*.<ext>')

      # --- type definitions ---
      "--type-add nix:{*.nix,flake.lock,_?sources.json}"
      "--type-add notes:*.{org,md,markdown,txt,note}"
      "--type-add rust:{Cargo.{lock,toml},rust-toolchain,*.{rs,rust-toolchain}}"
      "--type-add script:*.{sh,bash,zsh,fish,py,nu}"
      "--type-add web:*.{html,xhtml,js,jsx,mjs,css,scss,sass,tsx}"
    ];
  };

  home.packages = [
    pkgs.repgrep # Interactive replacer for ripgrep
    pkgs.ripgrep-all # ripgrep support: PDFs, eBooks, Office docs, zip, tarballs, & more
    pkgs.vgrep # # Pager for grep / git-grep / ripgrep
  ];
}
# TODO: Create ./grep.nix with other grepper packages:
# pkgs.agrep # Approx grep for fast fuzzy string searching
# pkgs.bingrep # Grep thru binaries from various OS/arch w/ color
# pkgs.grepcidr # Grep for IPv4 / IPv6 addresses matching CIDR patterns
# pkgs.gron # Grep for JSON
# pkgs.igrep # Interactive grep
# pkgs.ipgrep # Grep for IPs and resolve them
# pkgs.pdfgrep # Grep for PDFs
# pkgs.sgrep # Grep for structured text formats like XML
# pkgs.sorted-grep # Sorted grep
# pkgs.ucg # Grepper for large bodies of source code
# pkgs.ugrep # Fast grep w/ interactive query UI
# pkgs.xlsxgrep # Grep for Excel spreadsheets
