{pkgs, ...}:
# TODO: Compose devShells
#
# Nix-based devShells:
# - nixpkgs dev
# - NUR dev
# - NixOS config
# - home-manager config
# - nix-darwin config
# - Nix flakes dev
# - Nix non-flakes dev
#
let
  # TODO: Convert to Nixvim config.
  vim-snippet-updateNixFetchGit = ''
    " Helper to preserve the cursor location w/ filters
    function! Preserve(command)
      let w = winsaveview()
      execute a:command
      call winrestview(w)
    endfunction

    " Update fetcher under cursor
    " - NOTE: Might take a while if large fetched path.
    " - Keybind: '<leader>u'
    autocmd FileType nix map <nowait> <leader>u :call Preserve("%!update-nix-fetchgit --location=" . line(".") . ":" . col("."))<CR>
  '';
  # DevShell configs:
  # - VSCodium w/ config & plugins
  # - Nixvim w/ config & plugins
  # - Git repos w/ auto-pull/auto-updating
in {
  imports = [];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    devshells.nixos = {
      devshell = {
        name = "nixos";
        # TODO: Use figlet
        motd = ''

          ╭───────────────────────────────────────────────────────────╮
          │                                                           │
          │ {202} 🔨   Welcome to Lehmanator's NixOS configuration shell!{reset}  │
          │                                                           │
          ╰───────────────────────────────────────────────────────────╯
          $(type -p menu &>/dev/null && menu)
        '';
        startup = {
          aaa-begin = {
            deps = [];
            text = ''
              read -r LINES COLUMNS < <(stty size)
              printf -- "─%.0s" $(${pkgs.coreutils}/bin/seq $COLUMNS)
              echo
            '';
          };
          onefetch = {
            deps = ["aaa-begin"];
            # --no-merges --no-bots
            text = ''
              ${lib.getExe pkgs.onefetch} \
                --no-color-palette \
                --email \
                --include-hidden \
                --number-of-file-churns 8 \
                --number-separator comma \
                --type programming markup prose data
            '';
          };
          pls = {
            deps = ["onefetch"];
            text = ''
              ${lib.getExe pkgs.pls} --grid "true"
            '';
          };
          starship = {
            deps = ["pls"];
            text = "";
          };
        };
      };
      commands = [
        {
          name = "quit";
          help = "exit dev shell";
          command = "exit";
        }
        {
          category = "info";
          name = "onefetch";
          help = "display repository info";
          package = pkgs.onefetch;
        }
        {
          name = "environment";
          category = "info";
          help = "display environment variables";
          command = "printenv";
        }
        {
          name = "flake-show";
          category = "info";
          help = "display your flake outputs";
          command = "nix flake show";
        }
        {
          name = "host-info";
          category = "info";
          help = "display information about your host machine";
          command = "${lib.getExe pkgs.fastfetch}";
        }
        {
          name = "update flake";
          category = "update";
          help = "Update flake inputs in flake.lock";
          command = "nix flake update --commit-lock-file";
        }
        {
          name = "switch";
          category = "NixOS";
          help = "Rebuild your config & switch to it";
          command = "sudo nixos-rebuild --flake .#$(hostname) switch";
        }
        {
          name = "watch";
          category = "develop";
          help = "Watch this repository & reload on changes";
          command = "echo 'watching...'";
        }
      ];
      # TODO: Split packages into Nix / NixOS shells
      # TODO: Import Nix devshell in NixOS devshell
      packages = [
        pkgs.fastfetch

        # --- NixOS ---
        pkgs.rfc # Util to read RFCs from command line
        pkgs.nix-bundle # Create bundles from Nixpkgs attributes
        pkgs.nix-du # Tool to determine which gc-roots take space in Nix store.
        pkgs.nix-info
        pkgs.nix-top # Tracks what Nix is building
        pkgs.nix-tour # Offline version of "The Tour of Nix" from nixcloud.io/tour
        pkgs.nix-web # Web interface for the Nix store.
        pkgs.nix-search-cli # CLI for searching packages on `search.nixos.org`
        pkgs.nox # Tools to make nix nicer to use
        #pkgs.simple-nix # Simple parsing/pretty printing for Nix expressions
        pkgs.unstick # Silently eats chmod commands forbidden by Nix
        pkgs.vulnix # NixOS vulnerability scanner
        pkgs.xkbvalidate # NixOS tool to validate X keyboard configuration

        # --- Binary Caching ---
        pkgs.cachix # Command-line client for Nix binary cache hosting https://cachix.org
        pkgs.harmonia # Nix binary cache
        pkgs.nix-binary-cache # Set of scripts to serve the Nix store as a binary cache (out-of-date)
        #pkgs.nix-serve # Util for sharing a Nix store as a binary cache
        pkgs.nix-serve-ng # Drop-in replacement for nix-serve that's faster & more stable
        #pkgs.nix-store-gcs-proxy # HTTP Nix store that proxies requests to Google Storage

        # --- Builds ---
        #pkgs.hydra_unstable # Nix-based continuous build system
        #pkgs.nix-delegate # Convenient util for distributed Nix builds.
        pkgs.nix-eval-jobs # Hydra's builtin `hydra-eval-jobs` as a standalone

        # --- Debugging ---
        pkgs.dumpnar # Minimal tool to produce a Nix NAR archive
        pkgs.niff # A program that compares two Nix expressions and determines which attributes changed
        pkgs.nix-bisect # Bisect Nix builds.
        pkgs.nix-derivation # Parse & render `*.drv` files.
        pkgs.nix-diff # Explain why two Nix derivations differ
        pkgs.nix-health # Check the health of your Nix setup
        #pkgs.nix-query-tree-viewer # GTK viewer for the output of `nix store --query --tree`
        pkgs.nix-tree # Interactively browse a Nix store path's dependencies
        pkgs.nixseparatedebuginfod # Download/provide debug symbols & source code for Nix derivations to gdb & debuginfod-capable debuggers

        # --- Deployment ---
        pkgs.colmena # A simple, stateless NixOS deployment tool
        pkgs.deploy-rs # Multi-profile Nix-flake deploy tool
        pkgs.disnix # Nix-based distributed service deployment tool.
        pkgs.disnixos # Provides complementary NixOS infrastructure deployment to Disnix
        pkgs.morph # A NixOS host manager written in Golang
        pkgs.nix-deploy # Deploy Nix-built software to a NixOS machine
        pkgs.nix-simple-deploy # Deploy software or entire NixOS system config to another NixOS system
        pkgs.nixops-dns # DNS server for resolving NixOps machines
        pkgs.nixos-anywhere # Install NixOS anywhere via SSH

        # --- Development ---
        pkgs.namaka # Snapshot testing tool for Nix based on haumea
        #pkgs.nix-lib-nmd # Documentation framework for projects based on NixOS modules.
        #pkgs.nix-lib-nmt # Basic test framework for projects using Nixpkgs module system
        pkgs.nix-melt # Ranger-like flake.lock viewer
        pkgs.nix-pin # Nixpkgs development utility
        pkgs.nix-template # Easily create Nix expressions
        pkgs.nix-unit # Nix unit test runner
        pkgs.nixpacks # App source + Nix packages + Docker = Image Resources
        pkgs.nixpkgs-hammering # Nit-picky rules to point out & explain common mistakes in nixpkgs PRs
        pkgs.nixpkgs-pytools # Tools for making creating nixpkgs derivations less tedious.
        pkgs.nixpkgs-review # Review pull-requests on nixpkgs repo
        pkgs.npins # Simple and convenient dependency pinning for Nix
        pkgs.nvd # Nix/NixOS package version diff tool
        pkgs.pr-tracker # Nixpkgs pull request channel tracker

        # --- Documentation ---
        pkgs.documentation-highlighter # Highlight.js sources for the Nix Ecosystem's documentation
        pkgs.manix # A Fast Documentation Searcher for Nix
        pkgs.nix-doc # Interactive Nix documentation tool
        pkgs.nixdoc # Generate documentation for Nix functions
        pkgs.nixos-render-docs # Renderer for NixOS manual and option docs

        # --- Editor Utils ---
        pkgs.alejandra # The Uncompromising Nix Code Formatter
        pkgs.deadnix # Find and remove unused code in .nix source files
        pkgs.nil # Yet another language server for Nix
        #pkgs.nix-linter # Linter for Nix(pkgs) based on hnix
        pkgs.nixci # Define & build CI for Nix projects
        pkgs.nixd # Nix language server
        pkgs.nixel # Lexer, parser, Abstract Syntax Tree & Concrete Syntax Tree for Nix Expressions Language
        #pkgs.nixfmt # Opinionated formatter for Nix.
        pkgs.nixfmt-rfc-style # Opinionated formatter for Nix.
        pkgs.nixpkgs-fmt # Nix code formatter for nixpkgs
        #pkgs.nixpkgs-lint # Util for nixpkgs contributors to check nixpkgs for common errors
        pkgs.nixpkgs-lint-community # Fast semantic linter for Nix using tree-sitter
        pkgs.rnix-hashes # Nix hash converter
        pkgs.rnix-lsp # WIP language server for Nix w/ syntax checking & basic completion.
        pkgs.statix # Lints and suggestions for the nix programming language
        #pkgs.vimPlugins.nix-develop-nvim
        pkgs.vimPlugins.nvim-treesitter-parsers.nix
        pkgs.vimPlugins.statix # Lints and suggestions for the nix programming language
        pkgs.vscodium-fhs # Wrapped variant of VSCodium which launches in a FHS-compatible environment. Allows easy use of extensions w/o Nix-specific modifications
        pkgs.vscode-extensions.arrterian.nix-env-selector
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.jnoortheen.nix-ide # Nix language support w/ formatting & error report
        pkgs.vscode-extensions.kamadorueda.alejandra # The Uncompromising Nix Code Formatter

        # --- Fetchers / Updaters ---
        pkgs.niv # Easy dependency management for Nix projects
        pkgs.nix-init
        pkgs.nix-prefetch # Prefetch any fetcher function call.
        pkgs.nix-prefetch-docker
        pkgs.nix-prefetch-git
        pkgs.nix-prefetch-github
        pkgs.nix-prefetch-scripts
        pkgs.nix-universal-prefetch
        pkgs.nix-update # Swiss-army-knife for updating Nix packages.
        pkgs.nix-update-source # Util to automate updating of Nix derivation sources
        pkgs.nurl # Command-line tool to generate Nix fetcher calls from repository URLs
        pkgs.nvfetcher # Generate nix sources expr for the latest version of packages
        pkgs.update-nix-fetchgit # Program to update fetchgit values in Nix expressions

        # --- Generators ---
        pkgs.arion # Run docker-compose with help from Nix/NixOS
        #pkgs.autonix-deps-kf5 # Generate dependencies for KDE 5 Nix expressions
        pkgs.buildkit-nix # Nix frontend for BuildKit
        pkgs.bundix # Creates Nix packages from Gemfiles
        pkgs.cabal2nix # Convert Cabal files into Nix build instructions
        pkgs.crate2nix # A Nix build file generator for Rust crates.
        pkgs.crystal2nix # Utility to convert Crystal's shard.lock files to a Nix file
        pkgs.dconf2nix # Convert dconf files to Nix, as expected by Home Manager
        pkgs.dhall-nixpkgs # Convert Dhall projects to Nix packages
        pkgs.elm2nix # Turn your Elm project into buildable Nix project
        pkgs.iconConvTools # Tools for icon conversion specific to nix package manager
        pkgs.mix2nix # Generate nix expressions from mix.lock file.
        pkgs.nim_builder # Internal Nixpkgs utility for buildNimPackage.
        pkgs.nim_lk # Generate Nix specific lock files for Nim packages
        pkgs.nix-generate-from-cpan # Util to generate a Nix expression for Perl package from CPAN
        pkgs.nodePackages_latest.bower2nix # Generate nix expressions to fetch bower dependencies
        pkgs.node2nix # Generate Nix expressions to build NPM packages
        pkgs.sbomnix # Generate SBOMs for nix targets
        #pkgs.stack2nix # Convert stack.yaml files into Nix build instructions.
        #pkgs.stackage2nix # Convert Stack files into Nix build instructions
        pkgs.styx # Nix based static site generator
        pkgs.swiftpm2nix # Generate a Nix expression to fetch swiftpm dependencies
        pkgs.terranix # A NixOS like terraform-json generator
        pkgs.toml2nix # A tool to convert TOML files to Nix expressions
        pkgs.yarn2nix # Convert packages.json and yarn.lock into a Nix expression that downloads all the dependencies
        pkgs.zon2nix # Convert the dependencies in `build.zig.zon` to a Nix expression

        # --- Shell Integration ---
        pkgs.any-nix-shell # Zsh & Fish support for `nix-shell`
        pkgs.cached-nix-shell # Instant startup time for `nix-shell`
        pkgs.nixbang # Special shebang to run scripts in a `nix-shell`
        pkgs.nix-direnv # Fast, persistent use_nix implementation for direnv
        pkgs.nix-script # Shebang for running inside `nix-shell`
        pkgs.nix-bash-completions # Bash completions for Nix, NixOS, & NixOps
        pkgs.nix-zsh-completions # ZSH completions for Nix, NixOS, & NixOps
        pkgs.nix-your-shell # `nix`/`nix-shell` wrapper for shells other than `bash`
        pkgs.zsh-nix-shell # Zsh plugin that lets you use Zsh in `nix-shell` shell

        pkgs.nix-index # Files database for nixpkgs
        #pkgs.nix-index-unwrapped # Files database for nixpkgs.

        # --- System Integration ---
        pkgs.appvm # Nix-based app VMs
        #pkgs.darwin.rewrite-tbd # Rewrite filepath in .tbd to Nix applicable format
        pkgs.disko # Declarative disk partitioning and formatting using nix
        pkgs.home-manager # Nix-based user environment configurator.
        pkgs.lanzaboote-tool # Lanzaboote UEFI tooling for SecureBoot enablement on NixOS systems
        pkgs.linuxKernel.packages.linux_zen.hyperv-daemons # Integration Services for running NixOS under HyperV
        pkgs.lorri # Your project's `nix-env`
        pkgs.python311Packages.nix-kernel # Simple Jupyter kernel for `nix-repl`
        pkgs.nix-ld # Run unpatched dynamic binaries on NixOS
        pkgs.nix-plugins # Collection of misc plugins for Nix expression language
        pkgs.nixos-container
        pkgs.nixos-firewall-tool # Temporarily manipulate the NixOS firewall.
        pkgs.nixos-install-tools # Essential commands from the NixOS installer as a package.
        pkgs.nixos-generators # Collection of image builders
        pkgs.nixos-shell # Spawns lightweight NixOS VMs in a shell
        pkgs.usb-blaster-udev-rules # udev rules that give NixOS permission to communicate with usb blasters

        # --- Wrappers ---
        pkgs.nh # Yet another nix cli helper
        pkgs.nix-build-uncached # CI-friendly wrapper around `nix-build`
        pkgs.nix-output-monitor # Process output of Nix commands to show helpful & pretty info
        pkgs.nux # A wrapper over the nix cli
      ];
    };
  };
}
