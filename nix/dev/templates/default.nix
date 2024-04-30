{
  inputs,
  cell,
}:
# Output templates from template collection repos, merging with mine.
# TODO: add input.nix-templates.url="github:MordragT/nix-templates"
inputs.nix-templates.templates
//
# TODO: add input.nix-templates.url="github:the-nix-way/dev-templates"
inputs.dev-templates.templates
//
# TODO: Define pop or re-use from other cell.
cell.pops.templates.exports.default
