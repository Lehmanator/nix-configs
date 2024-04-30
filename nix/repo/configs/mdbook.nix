{
  inputs,
  cell,
}:
{
  meta.description = "Config(mdbook) - Documentation static webpage.";
} // (inputs.std.lib.dev.mkNixago inputs.std.data.configs.mdbook
{
  # Tool Homepage: https://rust-lang.github.io/mdBook/
  # defaults: https://github.com/divnix/std/blob/5ce7c9411337af3cb299bc9b6cc0dc88f4c1ee0e/src/data/configs/mdbook.nix
  hook.mode = "copy"; # Let CI pick it up outside of devshell
  #packages = with inputs.nixpkgs; [alejandra nodePackages.prettier nodePackages.prettier-plugin-toml shfmt inputs.mdbook-paisano-preprocessor.app.package.mdbook-paisano-preprocessor];
  data = {
    book = {
      title = "Lehmanator Configs: Documentation";
      authors = ["Sam Lehman"];
      language = "en";
      multilingual = "true";
      src = "docs";
    };
    build = {
      build-dir = "docs/book";
      create-missing = true;
      description = "mdBook providing documentation & more for Lehmanator/nix-configs";
    };
    preprocessor = {
      paisano-preprocessor = {
        before = ["links"];
        registry = ".#__std.init";
        multi = [
          {
            chapter = "Cell: repo";
            cell = "repo";
          }
          {
            chapter = "Cell: hive";
            cell = "hive";
          }
          {
            chapter = "Cell: kube";
            cell = "kube";
          }
        ];
      };
    };
  };
})
