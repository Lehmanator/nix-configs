{
  inputs,
  cell,
  pkgs,
  lib,
  config,
  ...
}: {
  # TODO: Split this file into?:
  # - ./rust-dev-platform-{common,all,android,linux,windows}.nix
  # - ./rust-dev-web.nix
  # - ./rust-dev-kernel.nix
  # - ./rust-nix.nix
  # - [x] ./rust-docs.nix
  # - ./rust-alternatives-coreutils.nix
  # - ./rust-alternatives-extras.nix
  # - ./rust-alternatives-full.nix

  commands = [
    # TODO: crate2nix
  ];
  env = [];
  language.rust = {
    enableDefaultToolchain = lib.mkDefault true;
    packageSet = lib.mkDefault pkgs.rustPlatform;
    tools = [
      "rustc" "cargo" "clippy" "rustfmt"
      "rust-std" "rust-docs" "rust-analyzer" "miri" "rust-src"
      "llvm-tools"
      "rustc-dev"
    ];
  };
  packages = [
    # --- Utils ------------------------------------------------------------
    pkgs.rustycli # Rust playground CLI
    pkgs.rustup # Rust toolchain installer
    pkgs.rust-script # Run Rust files/expressions as scripts w/o compilation.
    pkgs.rustup-toolchain-install-master # Install a rustc master toolchain usable from rustup
    pkgs.rs-git-fsmonitor # Fast git core.fsmonitor hook written in Rust

    
    # --- 3rd-Party Cargo Utils --------------------------------------------
    pkgs.cargo-bump # Increments the version number of the current project.
    pkgs.cargo-bundle # Wrap rust executables in OS-specific app bundles
    pkgs.cargo-cache # Manage cargo cache (${CARGO_HOME}, ~/.cargo/), print sizes of dirs and remove dirs selectively
    pkgs.cargo-dist # A tool for building final distributable artifacts and uploading them to an archive
    pkgs.cargo-edit # A utility for managing cargo dependencies from the command line
    pkgs.cargo-expand # A utility and Cargo subcommand designed to let people expand macros in their Rust source code
    pkgs.cargo-flamegraph # Easy flamegraphs for Rust projects and everything else, without Perl or pipes <3
    pkgs.cargo-generate # A tool to generaet a new Rust project by leveraging a pre-existing git repository as a template
    pkgs.cargo-modules # A cargo plugin for showing a tree-like overview of a crate's modules
    pkgs.cargo-play # Run your rust code without setting up cargo
    pkgs.cargo-semver-checks # A tool to scan your Rust crate for semver violations
    pkgs.cargo-sort # A tool to check that your Cargo.toml dependencies are sorted alphabetically
    pkgs.cargo-spellcheck # Checks rust documentation for spelling and grammar mistakes
    pkgs.cargo-ui # A GUI for Cargo
    pkgs.cargo-whatfeatures # A simple cargo plugin to get a list of features for a specific crate
    pkgs.cargo-workspaces # A tool for managing cargo workspaces and their crates, inspired by lerna

    # --- Cargo Subcommands ------------
    pkgs.cargo-all-features # A Cargo subcommand to build and test all feature flag combinations
    pkgs.cargo-clone # Cargo subcommand to fetch source code of a Rust crate
    pkgs.cargo-feature # Cargo plugin to manage dependency features
    pkgs.cargo-graph # A cargo subcommand for creating GraphViz DOT files and dependency graphs
    pkgs.cargo-info # Cargo subcommand to show crates info from crates.io
    pkgs.cargo-release # Cargo subcommand "release": everything about releasing a rust crate
    pkgs.cargo-profiler # Cargo subcommand for profiling Rust binaries
    pkgs.cargo-update # A cargo subcommand for checking and applying updates to installed executables
    pkgs.cargo-watch # A Cargo subcommand for watching over Cargo project's source

    # --- Frontends ---
    pkgs.cauwugo # An alternative cargo frontend that implements dynamic shell completion for usual cargo commands
  ];
}
