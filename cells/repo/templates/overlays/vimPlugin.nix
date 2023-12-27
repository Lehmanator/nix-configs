# Using flake inputs
final: prev: let
  winresizer-vim = prev.vimUtils.buildVimPlugin {
    name = "winresizer-vim";
    src = inputs.winresizer-vim;
  };
in { vimPlugins = prev.vimPlugins // { inherit winresizer-vim; }; }

final: prev: {
  vimPlugins = prev.vimPlugins.overrideScope' (vfinal: vprev: {

    # New plugin using fetcher
    vim-better-whitespace = pkgs.vimUtils.buildVimPlugin {
      name = "vim-better-whitespace";
      src = pkgs.fetchFromGitHub {
        owner = "ntpeters";
        repo = "vim-better-whitespace";
        rev = "984c8da518799a6bfb8214e1acdcfd10f5f1eed7";
        sha256 = "10l01a8xaivz6n01x6hzfx7gd0igd0wcf9ril0sllqzbq7yx2bbk";
      };
    };

    # New plugin from flake inputs
    #  inputs.winresizer-vim = { url = "github:simeji/winresizer"; flake = false; };
    winresizer-vim = prev.vimUtils.buildVimPlugin {
      name = "winresizer-vim";
      src = inputs.winresizer-vim;
    };
  
  });
}
