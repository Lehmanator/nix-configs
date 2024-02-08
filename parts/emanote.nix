{inputs, ...}: {
  imports = [inputs.emanote.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    emanote.sites.notes = {
      basePath = "../.notes";
      baseUrl = "notes.lehman.run";
      #layers = [ "../docs" ];
      layers = [];
      layersString = ["$HOME/Notes"];
      prettyUrls = true;
    };
  };
}
