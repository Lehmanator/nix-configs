{inputs, ...}: {
  imports = [inputs.emanote.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    emanote.sites.notes = {
      allowBrokenLinks = true;
      baseUrl = "/";
      layers = [
        {
          path = ./.;
          pathString = "$HOME/Notes";
        }
      ];
      prettyUrls = true;
    };
  };
}
