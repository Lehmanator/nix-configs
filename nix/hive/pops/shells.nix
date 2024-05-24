{ inputs, cell, }@commonArgs: {
  src = ../devshell/configs;
  inputs = { inherit inputs cell; };
}
