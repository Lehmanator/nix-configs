{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];
  nixpkgs.overlays = [inputs.fenix.overlays.default];
  home.packages = [
    pkgs.fenix.complete.toolchain
    #pkgs.fenix.stable.completeToolchain
    #(pkgs.fenix.stable.withComponents [ "cargo" "clippy" "rust-src" "rustc" "rustfmt" ])
    #pkgs.rust-analyzer-nightly

    # --- 3rd-Party Utils --------------------------------------------
    pkgs.cargo-about # Cargo plugin to generate list of all licenses for a crate
    #pkgs.cargo-audit # Audit Cargo.lock files for crates with security vulnerabilities
    pkgs.cargo-benchcmp # A small utility to compare Rust micro-benchmarks
    pkgs.cargo-bisect-rustc # Bisects rustc, either nightlies or CI artifacts
    pkgs.cargo-bump # Increments the version number of the current project.
    pkgs.cargo-bundle # Wrap rust executables in OS-specific app bundles
    pkgs.cargo-bundle-licenses # Generate a THIRDPARTY file with all licenses in a cargo project
    pkgs.cargo-cache # Manage cargo cache (${CARGO_HOME}, ~/.cargo/), print sizes of dirs and remove dirs selectively
    pkgs.cargo-chef # A cargo-subcommand to speed up Rust Docker builds using Docker layer caching
    pkgs.cargo-component # A Cargo subcommand for creating WebAssembly components based on the component model proposal
    pkgs.cargo-cranky # An easy to configure wrapper for Rust's clippy
    pkgs.cargo-cross # Zero setup cross compilation and cross testing
    pkgs.cargo-deny # Cargo plugin to generate list of all licenses for a crate
    pkgs.cargo-depgraph # Create dependency graphs for cargo projects using `cargo metadata` and graphviz
    pkgs.cargo-dist # A tool for building final distributable artifacts and uploading them to an archive
    pkgs.cargo-edit # A utility for managing cargo dependencies from the command line
    pkgs.cargo-geiger # Detects usage of unsafe Rust in a Rust crate and its dependencies
    pkgs.cargo-generate # A tool to generaet a new Rust project by leveraging a pre-existing git repository as a template
    pkgs.cargo-leptos # A build tool for the Leptos web framework
    pkgs.cargo-make # A Rust task runner and build tool
    pkgs.cargo-mobile2 # Rust on mobile made easy!
    pkgs.cargo-modules # A cargo plugin for showing a tree-like overview of a crate's modules
    pkgs.cargo-nextest # Next-generation test runner for Rust projects
    pkgs.cargo-play # Run your rust code without setting up cargo
    pkgs.cargo-public-api # List and diff the public API of Rust library crates between releases and commits. Detect breaking API changes and semver violations
    pkgs.cargo-readme # Generate README.md from docstrings
    pkgs.cargo-semver-checks # A tool to scan your Rust crate for semver violations
    pkgs.cargo-sort # A tool to check that your Cargo.toml dependencies are sorted alphabetically
    pkgs.cargo-supply-chain # Gather author, contributor and publisher data on crates in your dependency graph
    pkgs.cargo-sync-readme # A cargo plugin that generates a Markdown section in your README based on your Rust documentation
    pkgs.cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
    pkgs.cargo-temp # A CLI tool that allow you to create a temporary new Rust project using cargo with already installed dependencies
    pkgs.cargo-toml-lint # A simple linter for Cargo.toml manifests
    pkgs.cargo-typify # JSON Schema to Rust type converter
    pkgs.cargo-udeps # Find unused dependencies in Cargo.toml
    #pkgs.cargo-ui # A GUI for Cargo
    pkgs.cargo-unused-features # A tool to find potential unused enabled feature flags and prune them
    pkgs.cargo-whatfeatures # A simple cargo plugin to get a list of features for a specific crate
    pkgs.cargo-workspaces # A tool for managing cargo workspaces and their crates, inspired by lerna
    pkgs.cargo-xbuild # Automatically cross-compiles the sysroot crates core, compiler_builtins, and alloc

    # --- Cargo Subcommands ------------
    pkgs.cargo-all-features # A Cargo subcommand to build and test all feature flag combinations
    pkgs.cargo-binutils # Cargo subcommands to invoke the LLVM tools shipped with the Rust toolchain
    pkgs.cargo-c # A cargo subcommand to build and install C-ABI compatible dynamic and static libraries
    pkgs.cargo-clone # Cargo subcommand to fetch source code of a Rust crate
    pkgs.cargo-deadlinks # Cargo subcommand to check rust documentation for broken links
    pkgs.cargo-deb # A cargo subcommand that generates Debian packages from information in Cargo.toml
    pkgs.cargo-deps # Cargo subcommand for building dependency graphs of Rust projects
    pkgs.cargo-docset # Cargo subcommand to generate a Dash/Zeal docset for your Rust packages
    pkgs.cargo-duplicates # A cargo subcommand for displaying when different versions of a same dependency are pulled in
    pkgs.cargo-feature # Cargo plugin to manage dependency features
    pkgs.cargo-graph # A cargo subcommand for creating GraphViz DOT files and dependency graphs
    pkgs.cargo-hack # Cargo subcommand to provide various options useful for testing and continuous integration
    pkgs.cargo-i18n # Rust Cargo sub-command and libraries to extract and build localization resources to embed in your application/library
    pkgs.cargo-info # Cargo subcommand to show crates info from crates.io
    pkgs.cargo-license # Cargo subcommand to see license of dependencies
    pkgs.cargo-local-registry # A cargo subcommand to manage local registries
    pkgs.cargo-msrv # Cargo subcommand "msrv": assists with finding your minimum supported Rust version (MSRV)
    pkgs.cargo-profiler # Cargo subcommand for profiling Rust binaries
    pkgs.cargo-outdated # A cargo subcommand for displaying when Rust dependencies are out of date
    pkgs.cargo-rdme # Cargo command to create the README.md from your crate's documentation
    pkgs.cargo-release # Cargo subcommand "release": everything about releasing a rust crate
    pkgs.cargo-update # A cargo subcommand for checking and applying updates to installed executables
    pkgs.cargo-valgrind # Cargo subcommand "valgrind": runs valgrind and collects its output in a helpful manner
    pkgs.cargo-wasi # A lightweight Cargo subcommand to build code for the wasm32-wasi target
    pkgs.cargo-watch # A Cargo subcommand for watching over Cargo project's source
    pkgs.cargo-web # A Cargo subcommand for the client-side Web
    pkgs.cargo-wipe # Cargo subcommand "wipe": recursively finds and optionally wipes all "target" or "node_modules" folders

    # --- Frontends ---
    pkgs.cauwugo # An alternative cargo frontend that implements dynamic shell completion for usual cargo commands

    # --- Other Utils ---
    pkgs.crate2nix # A Nix build file generator for Rust crates.
  ];
}
