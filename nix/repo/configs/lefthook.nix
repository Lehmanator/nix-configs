{
  inputs,
  cell,
}:
{
  meta = rec {
    description = "lefthook: Git hook configuration.";
    homepage = "https://github.com/evilmartians/lefthook";
    longDescription = ''
      **${description}**

      Used to configure Git hooks. Most commonly used to run pre-commit hooks.

      This config creates the `pre-commit` hooks that run:

      - `conform`: Enforces policy on commits.
      - `treefmt`: Formats code before committing.

      #### Info

      repository: [`evilmartians/lefthook`](${homepage})
      blockType: `nixago`

      #### Notes

      - Remember to set the `nixago` attr in your `devshells` so they can automatically pick this up.
    '';
  };
}
// (inputs.std.lib.dev.mkNixago inputs.std.data.configs.lefthook {
  # Tool Homepage: https://github.com/evilmartians/lefthook
  # defaults: https://github.com/divnix/std/blob/5ce7c9411337af3cb299bc9b6cc0dc88f4c1ee0e/src/data/configs/lefthook.nix
  data = {
    commit-msg = {
      commands = {
        conform = {
          # allow WIP, fixup!/squash! commits locally
          run = ''
            [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
            conform enforce --commit-msg-file {1}'';
          skip = ["merge" "rebase"];
        };
      };
    };
    pre-commit = {
      commands = {
        treefmt = {
          run = "treefmt --fail-on-change {staged_files}";
          skip = ["merge" "rebase"];
        };
      };
    };
  };
})
