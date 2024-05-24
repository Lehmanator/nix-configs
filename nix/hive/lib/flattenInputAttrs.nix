{ inputs, cell, }:
builtins.mapAttrs (n: v:
if (builtins.length (builtins.attrNames v) == 0) then
  null
else if (builtins.length (builtins.attrNames v) == 1) then
  builtins.head (builtins.attrValues v)
else if (builtins.length (builtins.attrNames v) == 2)
  && builtins.hasAttr "default" v then
  builtins.head (builtins.attrValues v)
else
  v)
