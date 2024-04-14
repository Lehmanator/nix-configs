{
  inputs,
  cell,
}: {
  imports = [inputs.std.std.devshellProfiles.default];

  nixago = [
    cell.configs.conform
    cell.configs.editorconfig
    #cell.configs.githubsettings
    cell.configs.lefthook
    cell.configs.mdbook
    cell.configs.treefmt
  ];
}
