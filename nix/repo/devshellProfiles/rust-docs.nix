{
  inputs,
  cell,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [cell.devshellProfiles.mdbook];
  commands = [ ];
  env = [];
  language.rust.tools = ["rust-docs" "rust-std" "rust-src" "rustc-dev"];
  packages = [
    # --- Utils ------------------------------------------------------------
    pkgs.rusty-man # CLI viewer for rustdoc docs
    pkgs.rust-code-analysis # Analyze & collect metrics on source code
    pkgs.cargo-typify # Rust type generator from JSON Schema

    
    # --- 3rd-Party Cargo Utils --------------------------------------------
    pkgs.cargo-about # Cargo plugin to generate list of all licenses for a crate
    pkgs.cargo-bundle # Wrap rust executables in OS-specific app bundles
    pkgs.cargo-bundle-licenses # Generate a THIRDPARTY file with all licenses in a cargo project
    pkgs.cargo-fund # Discover funding links for your project's dependencies
    pkgs.cargo-kcov # Cargo subcommand to run kcov to get coverage report on Linux
    pkgs.cargo-llvm-lines # Count the number of lines of LLVM IR across all instantiations of a generic function
    pkgs.cargo-machete # A Cargo tool that detects unused dependencies in Rust projects
    pkgs.cargo-make # A Rust task runner and build tool
    pkgs.cargo-mobile2 # Rust on mobile made easy!
    pkgs.cargo-modules # A cargo plugin for showing a tree-like overview of a crate's modules
    pkgs.cargo-public-api # List and diff the public API of Rust library crates between releases and commits. Detect breaking API changes and semver violations
    pkgs.cargo-readme # Generate README.md from docstrings
    pkgs.cargo-semver-checks # A tool to scan your Rust crate for semver violations
    pkgs.cargo-spellcheck # Checks rust documentation for spelling and grammar mistakes
    pkgs.cargo-sync-readme # A cargo plugin that generates a Markdown section in your README based on your Rust documentation
    pkgs.cargo-tally # Graph the number of crates that depend on your crate over time
    pkgs.cargo-tarpaulin # A code coverage tool for Rust projects
    pkgs.cargo-typify # JSON Schema to Rust type converter
    pkgs.cargo-unused-features # A tool to find potential unused enabled feature flags and prune them
    pkgs.cargo-workspaces # A tool for managing cargo workspaces and their crates, inspired by lerna
    pkgs.ograc # like cargo, but backwards

    # --- Cargo Subcommands ------------
    pkgs.cargo-deadlinks # Cargo subcommand to check rust documentation for broken links
    pkgs.cargo-deps # Cargo subcommand for building dependency graphs of Rust projects
    pkgs.cargo-docset # Cargo subcommand to generate a Dash/Zeal docset for your Rust packages
    pkgs.cargo-i18n # Rust Cargo sub-command and libraries to extract and build localization resources to embed in your application/library
    pkgs.cargo-info # Cargo subcommand to show crates info from crates.io
    pkgs.cargo-license # Cargo subcommand to see license of dependencies
    pkgs.cargo-outdated # A cargo subcommand for displaying when Rust dependencies are out of date
    pkgs.cargo-rdme # Cargo command to create the README.md from your crate's documentation
    pkgs.cargo-web # A Cargo subcommand for the client-side Web

    # --- Frontends ---

    # --- Other Utils ---
    pkgs.rust-audit-info # A command-line tool to extract the dependency trees embedded in binaries by cargo-auditable
  ];
}
