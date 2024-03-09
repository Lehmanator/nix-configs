{ vimUtils, fetchFromGitHub, lib, ... }:
vimUtils.buildVimPlugin {
  pname = "aw-watcher-vscode";
  #pname = "activitywatch-vscode";
  version = "2024-03-08";
  src = fetchFromGitHub {
    owner = "ActivityWatch";
    repo = "aw-watcher-vscode";
    rev = "36093d4ac133f04363f144bdfefa4523f8e8f25f";
    hash = "sha256-dui6btqwLVkfoERVLxB8stWruMKc8MEsMbU5b/iLEug=";
  };
  meta = {
    homepage = "https://github.com/ActivityWatch/aw-watcher-vscode";
    description = "ActivityWatch plugin for VSCode";
  };
}
