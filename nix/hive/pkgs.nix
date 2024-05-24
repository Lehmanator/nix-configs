{ inputs, cell, }:
cell.pops.pkgs.exports.default
#let
#  l = inputs.nixpkgs.lib // builtins;
#  hasOverlay = l.hasAttrByPath [ "overlay" ];
#  hasOverlays = l.hasAttrByPath [ "overlays" ];
#  hasDefault = l.hasAttrByPath [ "overlays" "default" ];
#  renameInputOverlays = iname: ival:
#    let
#      hasSelfNamed = l.hasAttrByPath [ "overlays" iname ];
#      overlays = rec {
#        cleaned =
#          if hasOverlays ival then
#            l.removeAttrs ival.overlays [ "default" iname ]
#          else
#            { };
#        default = l.attrsByPath [ "overlays" "default" ]
#          (l.attrsByPath [ "overlays" iname ]
#            (l.attrsByPath [ "overlay" ] null ival)
#            ival)
#          ival;
#        all = cleaned // { "${iname}-default" = default; };
#      };
#    in
#    l.mapAttrs' (n: v: l.nameValuePair "${iname}-${n}" v) overlays.all;
#  getOverlays = rec {
#    all = ins: l.mapAttrs' (n: v: renameInputOverlays n v) ins;
#    #l.foldAttrs (item: acc: acc // item) { }
#    #  (l.mapAttrs' renameInputOverlays ins);
#    default = ins: l.filterAttrs (n: v: l.hasSuffix "-default" n) (all ins);
#  };
#  iprime = l.concatMapAttrs (n: v:
#    let
#      rename = l.mapAttrs' (o_n: o_v: l.nameValuePair "${n}-${o_n}" o_v);
#      hasSelfNamed = l.hasAttrByPath [ "overlays" n ];
#      d =
#        if hasDefault v then
#          v.overlays.default
#        else if hasSelfNamed v then
#          v.overlays.${n}
#        else if hasOverlay v then
#          v.overlay
#        else
#          null;
#      c =
#        if hasOverlays v then l.removeAttrs v.overlays [ "default" n ] else { };
#      a = c // { default = d; };
#      d_rn = rename d;
#      c_rn = rename c;
#      a_rn = rename a;
#    in
#    l.filterAttrs (an: av: (l.isFunction av)) a_rn);
#in
#{
#  unstable-with-default-overlays = import inputs.nixpkgs-unstable {
#    config.allowUnfree = true;
#    #overlays = l.attrValues (getOverlays.default inputs.omnibus.flake.inputs);
#  };
#  unstable-with-all-overlays = import inputs.nixpkgs-unstable {
#    #inherit (inputs.self) system;
#    config = {
#      allowUnfree = true;
#      allowBroken = true;
#      allowUnsupportedSystem = true;
#      android_sdk.accept_license = true;
#    };
#    #overlays = l.attrValues (iprime inputs.omnibus.flake.inputs);
#    #overlays = l.attrValues (getOverlays.all inputs.omnibus.flake.inputs);
#  };
#  unstable-with-overlays = import inputs.nixpkgs-unstable {
#    config = {
#      allowUnfree = true;
#      allowUnsupportedSystem = true;
#      android_sdk.accept_license = true;
#    };
#    overlays = with inputs.omnibus.flake.inputs; [
#      agenix.overlays.default
#      arion.overlays.default
#      audioNix.overlays.default
#      devshell.overlays.default
#      #disko.overlays.default  # disko exports no overlays
#      fenix.overlays.default
#      flake_env.overlays.default
#      microvm.overlay
#      nil.overlays.coc-nil
#      nil.overlays.nil
#      nix-filter.overlays.default
#      nuenv.overlays.nuenv
#      nur.overlay
#      ragenix.overlays.default
#      snapshotter.overlays.default
#      sops-nix.overlays.default
#      typst.overlays.default
#      inputs.nix-vscode-extensions.overlays.default
#    ];
#  };
#}
##if l.hasAttrByPath [ "overlays" "default" ] ival then
##  #if (ival.overlays ? default) && (ival.overlays ? iname) then
##else
### If inputs.<name>.overlays, return { "<name>-<overlayName>" = inputs.<name>.overlays.<overlayName>; }
##  if (l.hasAttrByPath [ "overlays" ] ival) then
##    if (l.length (l.attrNames ival.overlays) <= 2) then
##      l.mapAttrs' (n: v: l.nameValuePair (if iname == n then n else "${iname}-${n}") v) ival.overlays else
##    # Else return { "<name>" = inputs.<name>.overlay; }
##      if (l.hasAttrByPath [ "overlay" ] ival) then { ${iname} = ival.overlay; } else null;
##  allOverlays = inattrs: l.foldAttrs (item: acc: acc // item) {} (l.mapAttrs' (n: v: returnRenamedOverlays n v) inattrs);
##  defaultOverlays = l.filterAttrs (n: v: (l.hasSuffix "-default" n) )
##  getOverlaysFromInputs = l.mapAttrsToList (n: v:
##    # 1. inputs.<name>.overlay
##    (l.attrByPath [ n "overlay" ]
##    # 2. inputs.<name>.overlays.default
##    (l.attrByPath [ n "overlays" "default" ]
##    # 3. inputs.<name>.overlays.<name>
##    (l.attrByPath [ n "overlays" n ] v) v) v));
##  inputsWithOverlay = l.filterAttrs (n: v: (l.hasAttrByPath ["overlays" n] v) || (l.hasAttrByPath ["overlays" "default") || (l.hasAttrByPath ["overlay"] v));
##inputOverlays = iname: l.mapAttrs' (n: v: l.nameValuePair "${iname}-${n}" v);
##getAllOverlays = l.mapAttrsToList (n: v: (l.attrsByPath [n "overlays"] (l.attrsByPath [n "overlay"] null v) v));
