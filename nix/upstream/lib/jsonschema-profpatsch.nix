#
# Retrieved from:
# https://gist.github.com/Profpatsch/8ee75ad3912a72964d89372aeac30bb6
#
# See also:
# https://git.clan.lol/clan/clan-core/src/branch/main/lib/jsonschema/default.nix
#
let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  allOptions = (import <nixpkgs/nixos> {}).options;

  # ** some helpers

  # Like mapAttrs, but if `null` is returned from the mapping function,
  # the element is removed from the attrset.
  #
  # mapAttrsMaybe :: (k -> v -> a) -> Attrs k v -> Attrs k a
  #
  # Examples:
  #   mapAttrsMaybe (_: v: v) { foo = null; bar = 42; }
  #   => { bar = 42; }
  #   mapAttrsMaybe (_: v: if lib.isList v then null else v)
  #                 { foo = []; bar = 42; baz = null; }
  #   => { bar = 42; }
  mapAttrsMaybe = f: attrs: lib.pipe attrs [
    (lib.mapAttrsToList (k: v: { name = k; value = f k v; }))
    (builtins.filter ({name, value}: if value == null then false else true))
    lib.listToAttrs
  ];

  # Takes a tag, checks whether it is an attrset with one element,
  # if so sets `isTag` to `true` and sets the name and value.
  # If not, sets `isTag` to `false` and sets `errmsg`.
  verifyTag = tag:
    let
      cases = builtins.attrNames tag;
      len = builtins.length cases;
    in
    if builtins.length cases == 1
    then
      let name = builtins.head cases; in {
        isTag = true;
        name = name;
        val = tag.${name};
        errmsg = null;
      }
    else {
      isTag = false;
      errmsg =
        ("match: an instance of a sum is an attrset "
          + "with exactly one element, yours had ${toString len}"
          + ", namely: ${lib.generators.toPretty {} cases}");
      name = null;
      val = null;
    };

  # like `verifyTag`, but throws the error message if it is not a tag.
  assertIsTag = tag:
    let res = verifyTag tag; in
    assert res.isTag || throw res.errmsg;
    { inherit (res) name val; };

  # Discriminator for values.
  # Goes through a list of tagged predicates `{ <tag> = <pred>; }`
  # and returns the value inside the tag
  # for which the first predicate applies, `{ <tag> = v; }`.
  # They can then later be matched on with `match`.
  #
  # `defTag` is the tag that is assigned if there is no match.
  #
  # Examples:
  #   discrDef "smol" [
  #     { biggerFive = i: i > 5; }
  #     { negative = i: i < 0; }
  #   ] (-100)
  #   => { negative = -100; }
  #   discrDef "smol" [
  #     { biggerFive = i: i > 5; }
  #     { negative = i: i < 0; }
  #   ] 1
  #   => { smol = 1; }
  discrDef = defTag: fs: v:
    let
      res = lib.findFirst
        (t: t.val v)
        null
        (map assertIsTag fs);
    in
    if res == null
    then { ${defTag} = v; }
    else { ${res.name} = v; };

  # Like `discrDef`, but fail if there is no match.
  discr = fs: v:
    let res = discrDef null fs v; in
    assert lib.assertMsg (res != { })
      "tag.discr: No predicate found that matches ${lib.generators.toPretty {} v}";
    res;

  # The canonical pattern matching primitive.
  # A sum value is an attribute set with one element,
  # whose key is the name of the variant and
  # whose value is the content of the variant.
  # `matcher` is an attribute set which enumerates
  # all possible variants as keys and provides a function
  # which handles each variant’s content.
  # You should make an effort to return values of the same
  # type in your matcher, or new sums.
  #
  # Example:
  #   let
  #      success = { res = 42; };
  #      failure = { err = "no answer"; };
  #      matcher = {
  #        res = i: i + 1;
  #        err = _: 0;
  #      };
  #    in
  #       match success matcher == 43
  #    && match failure matcher == 0;
  #
  match = sum: matcher:
    let cases = builtins.attrNames sum;
    in assert
    let len = builtins.length cases; in
    lib.assertMsg (len == 1)
      ("match: an instance of a sum is an attrset "
        + "with exactly one element, yours had ${toString len}"
        + ", namely: ${lib.generators.toPretty {} cases}");
    let case = builtins.head cases;
    in assert
    lib.assertMsg (matcher ? ${case})
      ("match: \"${case}\" is not a valid case of this sum, "
        + "the matcher accepts: ${lib.generators.toPretty {}
            (builtins.attrNames matcher)}");
    matcher.${case} sum.${case};

  # A `match` with the arguments flipped.
  # “Lam” stands for “lambda”, because it can be used like the
  # `\case` LambdaCase statement in Haskell, to create a curried
  # “matcher” function ready to take a value.
  #
  # Example:
  #   lib.pipe { foo = 42; } [
  #     (matchLam {
  #       foo = i: if i < 23 then { small = i; } else { big = i; };
  #       bar = _: { small = 5; };
  #     })
  #     (matchLam {
  #       small = i: "yay it was small";
  #       big = i: "whoo it was big!";
  #     })
  #   ]
  #   => "whoo it was big!";
  matchLam = matcher: sum: match sum matcher;


  # ** nixos options to json schema

  optionSchema = opt: {
    type = simpletype opt;
    description = opt.description.text or "";
  };

  simpletype = option: lib.pipe option [
    ({type,...}: let n = type.name; in
    if      n == "bool" then "boolean"
    else if n == "int"  then "number"
    else if n == "str"  then "string"
    # TODO: more simple option types
    else "undefined")
  ];

  # Discriminate options based on what they do
  optionDiscr = discr [
    # if an option has no _type field, it is a namespace for more options
    { namespace = v: !(v ? _type); }
    # this option is invisible
    { invisibleOption = v:
       # Apparently "shallow" is also an option for `visible`.
       (v.visible or true)
       == false; }
    # it’s a normal option with a type
    { option = _: true; }
  ];

  # for a namespace in an options schema, recursively create json-schema
  # for each nested namespace and option
  # (the toplevel of `nixos.options` is a namespace as well)
  optionNamespaceSchema = nsName: ns: lib.pipe ns [
    (mapAttrsMaybe (name: val: lib.pipe val [
      optionDiscr
      (matchLam {
        namespace = optionNamespaceSchema name;
        invisibleOption = v: lib.traceSeqN 2 (v.type) null;
        option = optionSchema;
        # TODO: submodules? I guess?
      })
    ]))
    (vals: {
      type = "object";
      description = "Option namespace ${nsName}";
      properties = vals;
    })
  ];

in optionNamespaceSchema "toplevel" allOptions

