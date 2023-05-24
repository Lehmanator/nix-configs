{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  programs.git.includes = [

    # --- Users ---
    # TODO: Import all users in ./users/default.nix

    (import ./users/public.nix)
    (import ./users/personal.nix)
    (import ./users/gnome.nix)
    (import ./users/gaming.nix)
    (import ./users/work.nix)

    # TODO: Extra conditionals

    # { path = "~/path/to/config.inc"; }
    # { path = "~/path/to/conditional.inc";
    #   condition = "gitdir:~/src/dir";
    # }

  ];

}
