{
  inputs,
  cell,
  pkgs,
  lib,
  config,
  ...
}: {
  commands = [ ];
  env = [];
  language.rust.tools = ["rust-docs"];
  packages = [
    # --- Doc Generation ---------------------------------------------------
    # TODO: //repo/devshellProfiles/mdbook
    # TODO: Preprocessor from std
    pkgs.mdbook
    pkgs.mdbook-d2
    pkgs.mdbook-man
    pkgs.mdbook-epub
    pkgs.mdbook-katex
    pkgs.mdbook-cmdrun
    pkgs.mdbook-pagetoc
    pkgs.mdbook-mermaid
    pkgs.mdbook-toc
    pkgs.mdbook-pdf
    pkgs.mdbook-plantuml
    pkgs.mdbook-graphviz
    pkgs.mdbook-footnote
    pkgs.mdbook-admonish
    pkgs.mdbook-linkcheck
    pkgs.mdbook-open-on-gh
    pkgs.mdbook-emojicodes
    pkgs.mdbook-pdf-outline
    pkgs.mdbook-i18n-helpers
    pkgs.mdbook-kroki-preprocessor
    pkgs.mdbook
    pkgs.book-summary
    pkgs.termbook
  ];
}
