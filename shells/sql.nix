{
  inputs',
  self,
  ...
}: {
  imports = [inputs'.devshell.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    devshells.rust = {
      commands = [];
      devshell = {};
      env = [];
      packages = [
        inputs'.fenix.packages.complete.toolchain
        #pkgs.fenix.stable.completeToolchain
        #(pkgs.fenix.stable.withComponents [ "cargo" "clippy" "rust-src" "rustc" "rustfmt" ])
        #pkgs.rust-analyzer-nightly

        # --- 3rd-Party Utils --------------------------------------------
        pkgs.cargo-about # Cargo plugin to generate list of all licenses for a crate
        pkgs.cargo-apk # Tool for creating Android packages
        pkgs.cargo-asm # Display the assembly or LLVM-IR generated for Rust source code
        pkgs.cargo-audit # Audit Cargo.lock files for crates with security vulnerabilities
        pkgs.cargo-auditable # A tool to make production Rust binaries auditable
        pkgs.cargo-auditable-cargo-wrapper # A tool to make production Rust binaries auditable
        pkgs.cargo-bazel # Part of the `crate_universe` collection of tools which use Cargo to generate build targets for Bazel
        pkgs.cargo-benchcmp # A small utility to compare Rust micro-benchmarks
        pkgs.cargo-binstall # A tool for installing rust binaries as an alternative to building from source
        pkgs.cargo-bisect-rustc # Bisects rustc, either nightlies or CI artifacts
        pkgs.cargo-bitbake # Cargo extension that can generate BitBake recipes utilizing the classes from meta-rust
        pkgs.cargo-bolero # Fuzzing and property testing front-end framework for Rust
        pkgs.cargo-bootimage # Creates a bootable disk image from a Rust OS kernel.
        pkgs.cargo-bump # Increments the version number of the current project.
        pkgs.cargo-bundle # Wrap rust executables in OS-specific app bundles
        pkgs.cargo-bundle-licenses # Generate a THIRDPARTY file with all licenses in a cargo project
        pkgs.cargo-cache # Manage cargo cache (${CARGO_HOME}, ~/.cargo/), print sizes of dirs and remove dirs selectively
        pkgs.cargo-careful # A tool to execute Rust code carefully, with extra checking along the way
        pkgs.cargo-chef # A cargo-subcommand to speed up Rust Docker builds using Docker layer caching
        pkgs.cargo-codspeed # Cargo extension to build & run your codspeed benchmarks
        pkgs.cargo-component # A Cargo subcommand for creating WebAssembly components based on the component model proposal
        pkgs.cargo-cranky # An easy to configure wrapper for Rust's clippy
        pkgs.cargo-crev # A cryptographically verifiable code review system for the cargo (Rust) package manager
        pkgs.cargo-criterion # Cargo extension for running Criterion.rs benchmarks
        pkgs.cargo-cross # Zero setup cross compilation and cross testing
        pkgs.cargo-deny # Cargo plugin to generate list of all licenses for a crate
        pkgs.cargo-depgraph # Create dependency graphs for cargo projects using `cargo metadata` and graphviz
        pkgs.cargo-dephell # A tool to analyze the third-party dependencies imported by a rust crate or rust workspace
        pkgs.cargo-diet # Help computing optimal include directives for your Cargo.toml manifest
        pkgs.cargo-dist # A tool for building final distributable artifacts and uploading them to an archive
        pkgs.cargo-edit # A utility for managing cargo dependencies from the command line
        pkgs.cargo-espflash # Serial flasher utility for Espressif SoCs and modules based on esptool.py
        pkgs.cargo-espmonitor # Cargo tool for monitoring ESP32/ESP8266 execution
        pkgs.cargo-expand # A utility and Cargo subcommand designed to let people expand macros in their Rust source code
        pkgs.cargo-flamegraph # Easy flamegraphs for Rust projects and everything else, without Perl or pipes <3
        pkgs.cargo-fund # Discover funding links for your project's dependencies
        pkgs.cargo-fuzz # Command line helpers for fuzzing
        pkgs.cargo-geiger # Detects usage of unsafe Rust in a Rust crate and its dependencies
        pkgs.cargo-generate # A tool to generaet a new Rust project by leveraging a pre-existing git repository as a template
        pkgs.cargo-guppy # A command-line frontend for guppy
        pkgs.cargo-hakari # Manage workspace-hack packages to speed up builds in large workspaces.
        pkgs.cargo-inspect # See what Rust is doing behind the curtains
        pkgs.cargo-kcov # Cargo subcommand to run kcov to get coverage report on Linux
        pkgs.cargo-lambda # A Cargo subcommand to help you work with AWS Lambda
        pkgs.cargo-leptos # A build tool for the Leptos web framework
        pkgs.cargo-llvm-lines # Count the number of lines of LLVM IR across all instantiations of a generic function
        pkgs.cargo-machete # A Cargo tool that detects unused dependencies in Rust projects
        pkgs.cargo-make # A Rust task runner and build tool
        pkgs.cargo-mobile2 # Rust on mobile made easy!
        pkgs.cargo-modules # A cargo plugin for showing a tree-like overview of a crate's modules
        pkgs.cargo-mutants # A mutation testing tool for Rust
        pkgs.cargo-ndk # Cargo extension for building Android NDK projects
        pkgs.cargo-nextest # Next-generation test runner for Rust projects
        pkgs.cargo-pgrx # Build Postgres Extensions with Rust!
        pkgs.cargo-pgx # Cargo subcommand for ‘pgx’ to make Postgres extension development easy
        pkgs.cargo-play # Run your rust code without setting up cargo
        pkgs.cargo-public-api # List and diff the public API of Rust library crates between releases and commits. Detect breaking API changes and semver violations
        pkgs.cargo-raze # Generate Bazel BUILD files from Cargo dependencies
        pkgs.cargo-readme # Generate README.md from docstrings
        pkgs.cargo-risczero # Cargo extension to help create, manage, and test RISC Zero projects.
        pkgs.cargo-semver-checks # A tool to scan your Rust crate for semver violations
        pkgs.cargo-sort # A tool to check that your Cargo.toml dependencies are sorted alphabetically
        pkgs.cargo-spellcheck # Checks rust documentation for spelling and grammar mistakes
        pkgs.cargo-supply-chain # Gather author, contributor and publisher data on crates in your dependency graph
        pkgs.cargo-swift # A cargo plugin to easily build Swift packages from Rust code
        pkgs.cargo-sync-readme # A cargo plugin that generates a Markdown section in your README based on your Rust documentation
        pkgs.cargo-tally # Graph the number of crates that depend on your crate over time
        pkgs.cargo-tarpaulin # A code coverage tool for Rust projects
        pkgs.cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
        pkgs.cargo-temp # A CLI tool that allow you to create a temporary new Rust project using cargo with already installed dependencies
        pkgs.cargo-toml-lint # A simple linter for Cargo.toml manifests
        pkgs.cargo-typify # JSON Schema to Rust type converter
        pkgs.cargo-udeps # Find unused dependencies in Cargo.toml
        pkgs.cargo-ui # A GUI for Cargo
        pkgs.cargo-unused-features # A tool to find potential unused enabled feature flags and prune them
        pkgs.cargo-vet # A tool to help projects ensure that third-party Rust dependencies have been audited by a trusted source
        pkgs.cargo-whatfeatures # A simple cargo plugin to get a list of features for a specific crate
        pkgs.cargo-workspaces # A tool for managing cargo workspaces and their crates, inspired by lerna
        pkgs.cargo-xbuild # Automatically cross-compiles the sysroot crates core, compiler_builtins, and alloc
        pkgs.cargo-xwin # Cross compile Cargo project to Windows MSVC target with ease
        pkgs.cargo-zigbuild # A tool to compile Cargo projects with zig as the linker
        pkgs.ograc # like cargo, but backwards

        # --- Cargo Subcommands ------------
        pkgs.cargo-all-features # A Cargo subcommand to build and test all feature flag combinations
        pkgs.cargo-binutils # Cargo subcommands to invoke the LLVM tools shipped with the Rust toolchain
        pkgs.cargo-bloat # A tool and Cargo subcommand that helps you find out what takes most of the space in your executable
        pkgs.cargo-c # A cargo subcommand to build and install C-ABI compatible dynamic and static libraries
        pkgs.cargo-clone # Cargo subcommand to fetch source code of a Rust crate
        pkgs.cargo-deadlinks # Cargo subcommand to check rust documentation for broken links
        pkgs.cargo-deb # A cargo subcommand that generates Debian packages from information in Cargo.toml
        pkgs.cargo-docset # Cargo subcommand to generate a Dash/Zeal docset for your Rust packages
        pkgs.cargo-duplicates # A cargo subcommand for displaying when different versions of a same dependency are pulled in
        pkgs.cargo-feature # Cargo plugin to manage dependency features
        pkgs.cargo-graph # A cargo subcommand for creating GraphViz DOT files and dependency graphs
        pkgs.cargo-hack # Cargo subcommand to provide various options useful for testing and continuous integration
        pkgs.cargo-hf2 # Cargo Subcommand for Microsoft HID Flashing Library for UF2 Bootloaders
        pkgs.cargo-i18n # Rust Cargo sub-command and libraries to extract and build localization resources to embed in your application/library
        pkgs.cargo-info # Cargo subcommand to show crates info from crates.io
        pkgs.cargo-insta # A Cargo subcommand for snapshot testing
        pkgs.cargo-license # Cargo subcommand to see license of dependencies
        pkgs.cargo-limit # Cargo subcommand "limit": reduces the noise of compiler messages
        pkgs.cargo-llvm-cov # Cargo subcommand to easily use LLVM source-based code coverage
        pkgs.cargo-local-registry # A cargo subcommand to manage local registries
        pkgs.cargo-msrv # Cargo subcommand "msrv": assists with finding your minimum supported Rust version (MSRV)
        pkgs.cargo-profiler # Cargo subcommand for profiling Rust binaries
        pkgs.cargo-outdated # A cargo subcommand for displaying when Rust dependencies are out of date
        pkgs.cargo-rdme # Cargo command to create the README.md from your crate's documentation
        pkgs.cargo-release # Cargo subcommand "release": everything about releasing a rust crate
        pkgs.cargo-rr # Cargo subcommand "rr": a light wrapper around rr, the time-travelling debugger
        pkgs.cargo-show-asm # Cargo subcommand showing the assembly, LLVM-IR and MIR generated for Rust code
        pkgs.cargo-shuttle # A cargo command for the shuttle platform
        pkgs.cargo-sweep # A Cargo subcommand for cleaning up unused build files generated by Cargo
        pkgs.cargo-update # A cargo subcommand for checking and applying updates to installed executables
        pkgs.cargo-valgrind # Cargo subcommand "valgrind": runs valgrind and collects its output in a helpful manner
        pkgs.cargo-wasi # A lightweight Cargo subcommand to build code for the wasm32-wasi target
        pkgs.cargo-watch # A Cargo subcommand for watching over Cargo project's source
        pkgs.cargo-web # A Cargo subcommand for the client-side Web
        pkgs.cargo-wipe # Cargo subcommand "wipe": recursively finds and optionally wipes all "target" or "node_modules" folders

        # --- Frontends ---
        pkgs.cauwugo # An alternative cargo frontend that implements dynamic shell completion for usual cargo commands

        # --- Other Utils ---
        pkgs.build2 # build2 build system
        pkgs.crate2nix # A Nix build file generator for Rust crates.
        pkgs.elf2nucleus # Integrate micronucleus into the cargo buildsystem, flash an AVR firmware from an elf file
        pkgs.mrustc-minicargo # A minimalist builder for Rust
        pkgs.panamax # Mirror rustup and crates.io repositories for offline Rust and cargo usage
        pkgs.protoc-gen-prost-crate # A protoc plugin that generates Cargo crates and include files for `protoc-gen-prost`
        pkgs.reindeer # Reindeer is a tool which takes Rust Cargo dependencies and generates Buck build rules
        pkgs.rust-audit-info # A command-line tool to extract the dependency trees embedded in binaries by cargo-auditable
      ];
    };
  };
}
