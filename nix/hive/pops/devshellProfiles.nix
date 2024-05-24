{ inputs, cell, }@commonArgs:
# TODO: Add exporter wrapper using: inputs.omnibus.flake.inputs.std.${system}.lib.dev.mkShell
{
  src = ../devshell/profiles;
  inputs = {
    inherit cell;
    inputs = {
      inherit (inputs.omnibus.flake.inputs) climodSrc devshell std;
    } // inputs;
  };
}
