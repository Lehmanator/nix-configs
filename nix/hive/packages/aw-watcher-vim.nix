{ vimUtils, fetchFromGitHub, lib, ... }:
vimUtils.buildVimPlugin {
  pname = "vim-plugin-activitywatch";
  version = "2024-03-08";
  src = fetchFromGitHub {
    owner = "ActivityWatch";
    repo = "aw-watcher-vim";
    rev = "4ba86d05a940574000c33f280fd7f6eccc284331";
    hash = "sha256-I7YYvQupeQxWr2HEpvba5n91+jYvJrcWZhQg+5rI908=";
  };
  meta = {
    homepage = "https://github.com/ActivityWatch/aw-watcher-vim";
    description = "ActivityWatch plugin for Vim/Neovim";
  };
}
