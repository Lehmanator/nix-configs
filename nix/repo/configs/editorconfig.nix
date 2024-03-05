{
  inputs,
  cell,
}: with inputs.std;
(lib.dev.mkNixago data.configs.editorconfig {
  # TODO: Use to set Neovim editorconfig plugin settings?
  # TODO: Find all options
  data = {};
}) // { meta.description = "Editor configuration for settings common to most text editors."; }
