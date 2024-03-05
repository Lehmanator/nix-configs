{
  inputs,
  cell,
}:
{
  meta = rec {
    homepage = "https://github.com/siderolabs/conform";
    description = "siderolabs/conform: Tool to enforce policies on your commits.";
    longDescription = ''
      **${description}**

      Used for Conventional Commits.

      repository: `${homepage}`
      blockType: `nixago`
    '';
  };
}
// (inputs.std.lib.dev.mkNixago inputs.std.data.configs.conform {
  # TODO: Find all options.
  data = {
    # TODO: What does this do?
    inherit (inputs) cells;
  };
})
