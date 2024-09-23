# GNOME 46: triple-buffering-v4-46
# NOTE: Might need to disable aliases: `nixpkgs.config.allowAliases=false;`
(final: prev: {
  gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
    mutter = gnomePrev.mutter.overrideAttrs (old: {
      src = prev.fetchFromGitLab  {
        domain = "gitlab.gnome.org";
        owner = "vanvugt";
        repo = "mutter";
        rev = "triple-buffering-v4-46";
        hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
      };
    });
  });
})
