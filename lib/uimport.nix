# https://github.com/yunfachi/nixpkgs-yunfachi/blob/master/lib/umport.nix
let
  filterAttrs = pred: set:
    builtins.listToAttrs (builtins.concatMap (
      name: let
        v = set.${name};
      in
        if pred name v
        then [
          {
            inherit name;
            value = v;
          }
        ]
        else []
    ) (builtins.attrNames set));

  umportRaw = inputs @ {
    path,
    include ? [],
    exclude ? [],
    copyToStore ? false,
  }: let
    currentFile = builtins.unsafeGetAttrPos "path" inputs;
  in
    builtins.filter (x: x != null) (
      builtins.map (
        n: (
          if
            !(builtins.elem (path + "/${n}") (
              if currentFile != null
              then exclude ++ [(/. + "${currentFile.file}")]
              else exclude
            ))
          then
            (
              if copyToStore
              then "${path}/${n}"
              else builtins.toString path + "/${n}"
            )
          else null
        )
      ) (
        builtins.attrNames (
          filterAttrs (
            name: type: (
              if type == "regular"
              then
                (
                  if (builtins.substring ((builtins.stringLength name) - 4) (builtins.stringLength name) name) == ".nix"
                  then true
                  else false
                )
              else true
            )
          ) (builtins.readDir path)
        )
      )
    )
    ++ builtins.map
    (
      n: (
        if copyToStore
        then "${n}"
        else toString n
      )
    )
    include;

  umportRecursive = inputs @ {
    path,
    include ? [],
    exclude ? [],
    copyToStore ? false,
    recursive ? false,
  }: let
    args = builtins.removeAttrs inputs ["recursive"];
  in
    if !recursive
    then umportRaw args
    else
      (
        let
          objects = umportRaw args;
          objectsAttr = builtins.readDir path;
          objectsTypes = builtins.attrValues objectsAttr;
        in
          if builtins.elem "directory" objectsTypes
          then
            builtins.concatMap
            (
              object:
                umportRecursive (inputs // {path = path + "/${object}";})
            )
            (builtins.attrNames (
              filterAttrs (name: type: type == "directory") objectsAttr
            ))
            ++ (
              builtins.map (
                file: builtins.toString path + "/${file}"
              ) (
                builtins.attrNames (
                  filterAttrs (name: type: type == "regular") objectsAttr
                )
              )
            )
          else objects
      );
  umport = inputs @ {
    path ? null,
    paths ? [],
    include ? [],
    exclude ? [],
    copyToStore ? false,
    recursive ? false,
  }: let
    args = builtins.removeAttrs inputs ["paths"];
  in
    if paths != []
    then
      (
        builtins.concatMap
        (path: umportRecursive (args // {inherit path;}))
        paths
      )
    else umportRecursive args;
in
  umport
