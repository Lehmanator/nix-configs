{inputs, cell, config, lib, pkgs, ...}:
{
  env = [
    # {name=""; value=}
  ];
  commands = [
    { command = "taplo check"; help="Validate TOML file against schema"; name="toml-check"; }
    { command = "taplo fmt"; help="Format TOML"; name="toml-format"; }
    { command = "taplo get -o json"; help="Convert TOML to JSON"; name="toml-convert"; }
    { command = "$BROWSER https://json-schema.org"; help="Open json-schema.org"; name="json-schema-docs"; }
    { command = "$BROWSER https://json-schema.org/learn/glossary"; help="Open json-schema.org glossary"; name="json-schema-glossary"; }
    { command = "$BROWSER https://json-schema.org/understanding-json-schema/reference"; help="Open json-schema.org reference"; name="json-schema-ref"; }
    { command = "$BROWSER https://www.learnjsonschema.com/2020-12/"; help="Open meta-schema reference (2020-12)"; name="json-schema-ref-meta"; }
    { command = "$BROWSER https://json-schema.org/specification-links"; help="Open spec links"; name="json-schema-specs"; }
    { command = "$BROWSER https://json-schema.org/draft/2020-12/json-schema-validation"; help="Open validation spec"; name="json-schema-spec-validation"; }
    { command = "$BROWSER https://json-schema.org/implementations#validator-web%20(online)"; help="Open util list"; name="json-schema-utils"; }
    { command = "$BROWSER https://schemastore.org"; help="Open schemastore.org"; name="schema-store"; }

    # TODO: Make services
    { command = "taplo lsp stdio"; help="Run LSP (stdio)"; name="toml-lsp-stdio"; }
    { command = "taplo lsp tcp --address 0.0.0.0:9181"; help="Run LSP on localhost:9181"; name="toml-lsp-tcp"; }
  ];
  interactive = {
    # toml-repl = {deps=[]; text=""; };
  };
  startup = {
    # toml-setup = {deps=[]; text=""; };
  };
  packages = [
    pkgs.boon # Rust JSON Schema validation
    pkgs.jsonschema-rs # Rust JSON Schema validation lib
    pkgs.taplo # Rust TOML toolkit using JSON Schemas (features: lsp, toml-test)
    pkgs.cargo-typify # Rust type generator from JSON Schema
  ];
}
