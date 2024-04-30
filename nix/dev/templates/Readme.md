# `//dev/templates`

Development templates for a multitude of languages & frameworks.

## Templates Provided

- TODO: Add templates.

## External Template Sources

### [`the-nix-way/dev-templates`](https://github.com/the-nix-way/dev-templates)

Templates:

- clojure, csharp, cue, dhall, elixir, elm, gleam, go, hashi, haxe, java,
  kotlin, latex, nickel, nim, nix, node, ocaml, opa, php, protobuf, pulumi,
  purescript, ruby, rust, scala, shell, zig

Usage:

Initialize in the current project:

```(bash)
nix flake init --template github:the-nix-way/dev-templates#rust
```

Create a new project:

```(bash)
nix flake new --template github:the-nix-way/dev-templates#rust ${NEW_PROJECT_DIRECTORY}`
```

Automatically use template `devShells` (if you have `nix-direnv` enabled):

```(bash)
direnv allow
```

Use development shell without `nix-direnv`:

```(bash)
nix develop
```

### [`MordragT/nix-templates`](https://github.com/MordragT/nix-templates)

Templates:

- android, kotlin,
  cpp,
  mdbook,
  angular, deno, svelte-tailwind,
  python-micromamba, python-poetry, python-venv,
  rust-stable, rust-nightly, tauri,
  slides, slides-fh-aachen,
  stm32-platformio,
  tex, typst,
  trivial,

Usage:

Initialize in the current project:

```(bash)
nix flake init -t github:MordragT/nix-templates#<name>
```

Add templates repo to the Nix registry:

```(bash)
nix registry add templates github:MordragT/nix-templates
```
