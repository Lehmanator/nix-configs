{ inputs, ... }:
{
  # TODO: Configure nixd to call treefmt formatter?
  imports = [ inputs.treefmt.flakeModule ];
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      treefmt = {
        package = pkgs.treefmt;
        projectRootFile = "flake.nix";
        enableDefaultExcludes = true;
        flakeCheck = false;
        flakeFormatter = true;
        programs = {
          # --- Cuelang ---
          cue.enable = true;

          # --- JSON ---
          formatjson5.enable = true;
          jsonfmt.enable = false;

          # --- Jsonnet ---
          jsonnet-lint.enable = true;
          jsonnetfmt.enable = false;

          # --- Just ---
          just.enable = true;

          # --- Line Endings ---
          # Fix line endings. Convert CRLF to LF
          dos2unix.enable = true;

          # --- Markdown ---
          mdformat = {
            enable = false;
            includes = [ ];
            excludes = [ "*.md" ];
            settings = {
              end-of-line = "lf";
              number = false;
              wrap = "keep";
            };
          };
          mdsh = {
            enable = false;
            includes = [ ];
            excludes = [ "*.md" ];
          };

          # --- Nickel ---
          nickel.enable = true;

          # --- Nix ---
          alejandra = {
            enable = true;
            includes = [ "*.nix" ];
            excludes = [ ];
          };
          deadnix = {
            enable = false;
            excludes = [ "*.nix" ];
            includes = [ ];
            no-lambda-arg = true; # Dont check lamba parameter args
            no-lambda-pattern-names = true; # Dont check lambda attrset pattern names (dont break callPackage)
            no-underscore = true;
          };
          nixfmt = {
            enable = false;
            includes = [ ];
            excludes = [ "*.nix" ];
          };
          nixfmt-rfc-style = {
            enable = false;
            includes = [ "../nixos/packages/*.nix" ];
            excludes = [ "*.nix" ];
          };
          nixpkgs-fmt.enable = false;
          statix = {
            enable = false;
            disabled-lints = [ ];
            includes = [ ];
            excludes = [ ];
          };

          # --- Nushell ---
          nufmt.enable = true;

          # --- Python ---
          black.enable = true;

          # --- Shell / Bash ---
          beautysh.enable = false;
          shellcheck = {
            enable = false;
            includes = [ ];
            excludes = [ ];
          };
          shfmt.enable = false;

          # --- TOML ---
          toml-sort.enable = false;

          # --- Natural Languages ---
          typos.enable = false;

          # --- YAML ---
          # Format GitHub Actions YAML files
          actionlint.enable = true;
          yamlfmt.enable = false;
        };
        settings.formatter = {
          # nixpkgs-fmt.includes = [
          #   "../darwin/packages"
          #   "../hm/packages"
          #   "../nixos/packages"
          # ];
          # nixfmt.excludes = [
          #   "../nixos/packages"
          #   "../cells"
          # ];
        };
      };
    };
}
