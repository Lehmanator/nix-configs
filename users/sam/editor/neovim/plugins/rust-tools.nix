{ inputs
, pkgs
, ...
}:
{

  programs.nixvim.plugins.rust-tools = {
    crateGraph = {
      enabledGraphvizBackends = [ "dot" "jpg" "json" "pdf" "plain-ext" "png" "svg" "webp" "x11" ];
      backend = "svg";
    };
    server.cargo.features = "all";
  };
}
